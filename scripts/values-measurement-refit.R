# Refit of the M6 values measurement model without the gender-role and fatalism items
# (sexism_roles_2016, class_manlymen_2017, fatalism2_2011), run from the project root.
#
# Reproduces the half-B CFA sample from the original measurement pass
# (research-design/voter-measurement-pass.md): all 5,000 Jul 2017 respondents,
# random split with seed 20261001, lavaan WLSMV, all items ordinal, pairwise missing,
# latent variances fixed to 1, equal loadings on the two-item factors (RELIG, INEFF).
# The original 26-item M6 is refit first to confirm the split matches the published fit.

library(data.table)
library(lavaan)

set.seed(20261001)
out_dir <- "output/values-measurement-refit"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# ---- Items (same recodes as scripts/analysis.R) ---------------------------------
rev_k <- function(k) function(x) (k + 1) - x
spec <- list(
  e_equalopp    = list("egalitarian_opportunities_2017", 1:5, rev_k(5)),
  e_worryless   = list("egalitarian_worryless_2017", 1:5, identity),
  e_chance      = list("egalitarian_chance_2017", 1:5, identity),
  e_fewerprob   = list("egalitarian_fewerproblems_2017", 1:5, rev_k(5)),
  e_redist      = list("income_redistribution_2017", 1:3, function(x) c(3, 1, 2)[x]),
  e_wealth      = list("wealth_2016", 1:2, function(x) x - 1),
  e_econbias    = list("economicbias_2016", 1:4, rev_k(4)),
  e_unfair      = list("fairsociety_2016", 1:4, identity),
  i_govless     = list("govt_moreorless_2017", 1:2, function(x) x - 1),
  i_freemkt     = list("govt_econinvolve_2016", 1:2, function(x) x - 1),
  i_overreg     = list("govtreg_business_2017", 1:3, rev_k(3)),
  i_nohealth    = list("univhealthcov_2017", 1:2, function(x) x - 1),
  gr_womenrole  = list("sexism_roles_2016", 1:4, rev_k(4)),  # dropped in trimmed model
  gr_manlymen   = list("class_manlymen_2017", 1:5, rev_k(5)),  # dropped in trimmed model
  ext_success   = list("fatalism2_2011", 1:4, rev_k(4)),  # dropped in trimmed model
  auth_respect  = list("sc1_independent_2016", 1:2, function(x) x - 1),
  auth_manners  = list("sc2_curiosity_2016", 1:2, function(x) x - 1),
  auth_obey     = list("sc3_obedience_2016", 1:2, function(x) 2 - x),
  auth_behaved  = list("sc4_considerate_2016", 1:2, function(x) x - 1),
  relig_serv    = list("religservice_2016", 1:6, rev_k(6)),
  relig_imp     = list("religimp_2016", 1:4, rev_k(4)),
  dist_careful  = list("people_trust_2016", 1:2, function(x) 2 - x),
  dist_selfish  = list("people_helpful_2016", 1:2, function(x) x - 1),
  dist_unfair   = list("people_fair_2016", 1:2, function(x) 2 - x),
  ineff_nosay   = list("nosay_2016", 1:4, rev_k(4)),
  ineff_elecnot = list("electionsmatter_2016", 1:4, rev_k(4))
)

raw <- fread("data/voter_panel.csv",
             select = c(unname(vapply(spec, `[[`, "", 1)), "weight_genpop_2017"), showProgress = FALSE)
raw <- raw[!is.na(weight_genpop_2017)]
d <- as.data.frame(lapply(spec, function(s) { x <- raw[[s[[1]]]]; x[!x %in% s[[2]]] <- NA; s[[3]](x) }))
stopifnot(nrow(d) == 5000)

half <- sample(rep(c("A", "B"), length.out = nrow(d)))   # same draw as the measurement pass
dB <- d[half == "B", ]

# ---- Models ------------------------------------------------------------------------
econ12 <- "e_equalopp + e_worryless + e_chance + e_fewerprob + e_redist + e_wealth +
           e_econbias + e_unfair + i_govless + i_freemkt + i_overreg + i_nohealth"
rest <- "
  AUTH     =~ auth_respect + auth_manners + auth_obey + auth_behaved
  RELIG    =~ r*relig_serv + r*relig_imp
  DISTRUST =~ dist_careful + dist_selfish + dist_unfair
  INEFF    =~ q*ineff_nosay + q*ineff_elecnot
"
models <- list(
  M6_original = paste0("ECON =~ ", econ12, " + gr_womenrole + gr_manlymen + ext_success", rest),
  M6_trimmed  = paste0("ECON =~ ", econ12, rest)
)

fit_m <- function(m, dat) cfa(m, data = dat, ordered = TRUE, estimator = "WLSMV",
                              missing = "pairwise", std.lv = TRUE)
fits <- list(
  M6_original_halfB = fit_m(models$M6_original, dB),
  M6_trimmed_halfB  = fit_m(models$M6_trimmed, dB),
  M6_trimmed_full   = fit_m(models$M6_trimmed, d)   # all 5,000; for scoring, not model testing
)

# ---- Fit -------------------------------------------------------------------------
fm_names <- c("chisq.scaled", "df.scaled", "cfi.scaled", "tli.scaled", "rmsea.scaled",
              "cfi.robust", "tli.robust", "rmsea.robust", "srmr")
cfa_fit <- rbindlist(lapply(names(fits), function(n) {
  data.table(model = n, n = lavInspect(fits[[n]], "nobs"), t(round(fitMeasures(fits[[n]], fm_names), 3)))
}))
fwrite(cfa_fit, file.path(out_dir, "cfa-fit.csv"))
print(cfa_fit)

# Check the reproduced split against the published M6 fit (chi-square 4,016 on 291 df)
stopifnot(round(cfa_fit[model == "M6_original_halfB", df.scaled]) == 291,
          abs(cfa_fit[model == "M6_original_halfB", chisq.scaled] - 4016) < 1)

# ---- Loadings, omega, factor correlations, modification indices -----------------------
for (n in names(fits)) {
  pe <- as.data.table(standardizedSolution(fits[[n]], se = FALSE))
  ld <- pe[op == "=~", .(factor = lhs, item = rhs, std_loading = round(est.std, 3))]
  fwrite(ld, file.path(out_dir, sprintf("loadings-%s.csv", n)))
  # ordinal omega on the latent-response scale; abs() handles the bipolar ECON factor
  om <- ld[, .(n_items = .N, omega_ordinal = round(sum(abs(std_loading))^2 /
                 (sum(abs(std_loading))^2 + sum(1 - std_loading^2)), 3)), by = factor]
  fwrite(om, file.path(out_dir, sprintf("omega-%s.csv", n)))
  fwrite(pe[op == "~~" & lhs != rhs & lhs %in% lavNames(fits[[n]], "lv"),
            .(lhs, rhs, r = round(est.std, 3))],
         file.path(out_dir, sprintf("factor-cors-%s.csv", n)))
  mi <- as.data.table(modindices(fits[[n]], sort. = TRUE, maximum.number = 20))
  fwrite(mi[, .(lhs, op, rhs, mi = round(mi, 1), sepc.all = round(sepc.all, 2))],
         file.path(out_dir, sprintf("modindices-%s.csv", n)))
}

writeLines(capture.output(sessionInfo()), file.path(out_dir, "sessionInfo.txt"))
