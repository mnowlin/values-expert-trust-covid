# Core Values and Trust in Experts Before and After COVID-19
# Analysis code sourced by values-expert-trust-covid.qmd (run from the project root).
#
# Data: Democracy Fund VOTER Survey panel (data/voter_panel.csv; not tracked in git)
# Design: research-design/expert-trust-covid-design.md
#
# Analytic panel: respondents in both the Jul 2017 and Nov 2020 waves (n = 2,544).
# Values are measured pre-COVID (2016, 2017); expert trust in 2017 (T1) and
# Nov 2020 (T2); COVID exposure in Sep and Nov 2020; COVID attitudes (consequences of
# change in expert trust) in Nov 2020. No mediators: COVID is the period between T1 and T2.
#
# Coding rule: every recode is checked against the wave-specific codebook entry
# (data/VOTER-Survey-Guide-2021Dec.pdf). Codes can differ across waves, e.g.
# people_trust_2016 is reversed relative to people_trust_2020Nov.

library(data.table)

# ---- Helpers -----------------------------------------------------------------
# keep valid codes, set everything else (DK, skipped, not asked) to NA, then recode
rc <- function(x, valid, f = identity) { x[!x %in% valid] <- NA; f(x) }
rev_k <- function(k) function(x) (k + 1) - x

# ---- Load --------------------------------------------------------------------
value_vars <- c(
  # ECON (egalitarian + / individualist -)
  "egalitarian_opportunities_2017", "egalitarian_worryless_2017", "egalitarian_chance_2017",
  "egalitarian_fewerproblems_2017", "income_redistribution_2017", "wealth_2016",
  "economicbias_2016", "fairsociety_2016", "govt_moreorless_2017", "govt_econinvolve_2016",
  "govtreg_business_2017", "univhealthcov_2017",
  # AUTH, RELIG, DISTRUST, INEFF
  "sc1_independent_2016", "sc2_curiosity_2016", "sc3_obedience_2016", "sc4_considerate_2016",
  "religservice_2016", "religimp_2016",
  "people_trust_2016", "people_helpful_2016", "people_fair_2016",
  "nosay_2016", "electionsmatter_2016")
outcome_vars <- c(paste0("expert_", rep(c("trustordinary", "facts", "help", "struggle"), 2),
                         rep(c("_2017", "_2020Nov"), each = 4)),
                  "inst_cdc_2020Nov")
# Exposure (Sep and Nov 2020) moderates change; COVID attitudes (Nov 2020 only, so they
# follow the T2 trust measure in time) are outcomes of change in expert trust (RQ5).
# The Sep 2020 restriction-support items (covid_restrict_*) are not used: they were asked
# only before T2, so they cannot be outcomes of the 2017 -> Nov 2020 change.
sick_circles <- c("you", "family", "work", "friend")
covid_vars <- c(paste0("covid_sick", rep(sick_circles, 2), rep(c("_2020Sep", "_2020Nov"), each = 4)),
                "trumpapp_covid_2020Nov", "govapp_covid_2020Nov", "covid_endrestrictions_2020Nov")
placebo_vars <- c("trustgovt_2017", "trustgovt_2020Nov",
                  paste0("inst_", rep(c("military", "court", "business", "congress", "media"), 2),
                         rep(c("_2019Jan", "_2020Nov"), each = 5)),
                  paste0("beliefinmedia_", c("2016", "2019Jan", "2019Nov", "2020Nov")))
control_vars <- c("pid7_2017", "ideo5_2017", "educ_2017", "birthyr_2011", "gender_2011",
                  "race_2017", "faminc_2017", "newsint_2017", "trumpapp_2017", "inputstate_2020Nov",
                  "cdid_2020Nov")
weight_vars <- c("weight_genpop_2017", "weight_genpop_2020Nov", "weight_panel_2020Nov",
                 "weight_allpanel_2020Nov")

raw <- fread("data/voter_panel.csv",
             select = c(value_vars, outcome_vars, covid_vars, placebo_vars, control_vars, weight_vars),
             showProgress = FALSE)
panel <- raw[!is.na(weight_genpop_2017) & !is.na(weight_genpop_2020Nov)]
stopifnot(nrow(panel) == 2544)

# ---- Recode: values (higher = more of the construct) -----------------------------
d <- panel[, .(
  # ECON
  e_equalopp    = rc(egalitarian_opportunities_2017, 1:5, rev_k(5)),
  e_worryless   = rc(egalitarian_worryless_2017, 1:5),
  e_chance      = rc(egalitarian_chance_2017, 1:5),
  e_fewerprob   = rc(egalitarian_fewerproblems_2017, 1:5, rev_k(5)),
  e_redist      = rc(income_redistribution_2017, 1:3, function(x) c(3, 1, 2)[x]),
  e_wealth      = rc(wealth_2016, 1:2, function(x) x - 1),
  e_econbias    = rc(economicbias_2016, 1:4, rev_k(4)),
  e_unfair      = rc(fairsociety_2016, 1:4),
  i_govless     = rc(govt_moreorless_2017, 1:2, function(x) x - 1),
  i_freemkt     = rc(govt_econinvolve_2016, 1:2, function(x) x - 1),
  i_overreg     = rc(govtreg_business_2017, 1:3, rev_k(3)),
  i_nohealth    = rc(univhealthcov_2017, 1:2, function(x) x - 1),
  # AUTH (child-rearing)
  auth_respect  = rc(sc1_independent_2016, 1:2, function(x) x - 1),
  auth_manners  = rc(sc2_curiosity_2016, 1:2, function(x) x - 1),
  auth_obey     = rc(sc3_obedience_2016, 1:2, function(x) 2 - x),
  auth_behaved  = rc(sc4_considerate_2016, 1:2, function(x) x - 1),
  # RELIG
  relig_serv    = rc(religservice_2016, 1:6, rev_k(6)),
  relig_imp     = rc(religimp_2016, 1:4, rev_k(4)),
  # DISTRUST (2016 people_trust: 1 = "can't be too careful")
  dist_careful  = rc(people_trust_2016, 1:2, function(x) 2 - x),
  dist_selfish  = rc(people_helpful_2016, 1:2, function(x) x - 1),
  dist_unfair   = rc(people_fair_2016, 1:2, function(x) 2 - x),
  # INEFF
  ineff_nosay   = rc(nosay_2016, 1:4, rev_k(4)),
  ineff_elecnot = rc(electionsmatter_2016, 1:4, rev_k(4))
)]

# ---- Recode: outcomes (higher = more pro-expert) ---------------------------------
# trustordinary and facts: agreement = anti-expert, so the raw 1-4 code already runs
# anti -> pro; help: agreement = pro-expert, so reverse.
for (w in c("2017", "2020Nov")) {
  s <- if (w == "2017") "17" else "20"
  d[, paste0("x_trustexp_", s) := rc(panel[[paste0("expert_trustordinary_", w)]], 1:4)]
  d[, paste0("x_facts_", s)    := rc(panel[[paste0("expert_facts_", w)]], 1:4)]
  d[, paste0("x_help_", s)     := rc(panel[[paste0("expert_help_", w)]], 1:4, rev_k(4))]
  d[, paste0("manichean_", s)  := rc(panel[[paste0("expert_struggle_", w)]], 1:4, rev_k(4))]
}
d[, cdc_conf_20 := rc(panel$inst_cdc_2020Nov, 1:4, rev_k(4))]

# ---- Recode: COVID exposure (Sep and Nov 2020) -------------------------------------
# Each circle: 1 = Yes, 0 = No or Maybe. Codes are the same in both waves.
sick_yes <- function(w) sapply(sick_circles, function(cc)
  rc(panel[[paste0("covid_sick", cc, "_", w)]], 1:3, function(x) as.numeric(x == 1)))
sick_sep <- sick_yes("2020Sep")
sick_nov <- sick_yes("2020Nov")
d[, covid_exposure_sep := rowSums(sick_sep)]   # count of circles with a case (0-4)
d[, covid_exposure_nov := rowSums(sick_nov)]
# primary measure: a case in that circle reported in either wave; missing only if both waves are
sick_any <- pmax(sick_sep, sick_nov, na.rm = TRUE)
d[, covid_exposure := rowSums(sick_any)]

# ---- Recode: COVID attitudes, Nov 2020 (outcomes of change in expert trust) -------------
d[, trump_covid_app_20 := rc(panel$trumpapp_covid_2020Nov, 1:4, rev_k(4))]   # 4 = strongly approve
d[, gov_covid_app_20   := rc(panel$govapp_covid_2020Nov, 1:4, rev_k(4))]
d[, fear_lift_early_20 := rc(panel$covid_endrestrictions_2020Nov, 1:2, function(x) 2 - x)]   # 1 = too quickly

# ---- Recode: placebo / pre-trend outcomes (higher = more trust) ---------------------
# trustgovt has three categories (1 = just about always ... 3 = some of the time)
d[, trustgovt_17 := rc(panel$trustgovt_2017, 1:3, rev_k(3))]
d[, trustgovt_20 := rc(panel$trustgovt_2020Nov, 1:3, rev_k(3))]
for (inst in c("military", "court", "business", "congress", "media")) {
  d[, paste0("inst_", inst, "_19") := rc(panel[[paste0("inst_", inst, "_2019Jan")]], 1:4, rev_k(4))]
  d[, paste0("inst_", inst, "_20") := rc(panel[[paste0("inst_", inst, "_2020Nov")]], 1:4, rev_k(4))]
}
# "You can't believe much of what you hear from mainstream media": disagree = more trust.
# 2016 response labels differ (Agree / Disagree vs. Somewhat agree / disagree), so the
# pre-trend uses 2019Jan -> 2019Nov; 2019Nov code 5 (not sure) is set to missing.
for (w in c("2016", "2019Jan", "2019Nov", "2020Nov")) {
  d[, paste0("mediatrust_", w) := rc(panel[[paste0("beliefinmedia_", w)]], 1:4)]
}

# ---- Recode: controls (pre-COVID) ----------------------------------------------
d[, `:=`(
  pid7      = rc(panel$pid7_2017, 1:7),
  ideo5     = rc(panel$ideo5_2017, 1:5),
  ideologue = rc(panel$ideo5_2017, 1:5, function(x) as.numeric(x != 3)),  # Jackson (2015) approximation
  educ      = rc(panel$educ_2017, 1:6),
  age_2020  = 2020 - panel$birthyr_2011,
  female    = rc(panel$gender_2011, 1:2, function(x) as.numeric(x == 2)),
  white     = rc(panel$race_2017, 1:8, function(x) as.numeric(x == 1)),
  black     = rc(panel$race_2017, 1:8, function(x) as.numeric(x == 2)),
  hispanic  = rc(panel$race_2017, 1:8, function(x) as.numeric(x == 3)),
  other_race = rc(panel$race_2017, 1:8, function(x) as.numeric(x >= 4)),
  faminc    = rc(panel$faminc_2017, 1:16),   # 2017 uses the 2016 coding; 97 = prefer not to say
  trumpapp_17 = rc(panel$trumpapp_2017, 1:4, rev_k(4)),   # 4 = strongly approve
  newsint   = rc(panel$newsint_2017, 1:4, rev_k(4)),
  state     = panel$inputstate_2020Nov,
  cdid      = panel$cdid_2020Nov,
  w_2020    = panel$weight_genpop_2020Nov,
  w_allpanel = panel$weight_allpanel_2020Nov
)]
# income: 14% prefer not to say; keep them with a missing indicator and the median income
d[, inc_missing := as.numeric(is.na(faminc))]
d[is.na(faminc), faminc := median(d$faminc, na.rm = TRUE)]
d[, exposed := as.numeric(covid_exposure >= 1)]

# ---- Descriptives: expert-trust change, 2017 -> 2020 --------------------------------
expert_items <- c(trustexp = "Trust experts over ordinary people (disagree)",
                  facts    = "Scientific facts help on important questions (disagree)",
                  help     = "Experts help ordinary people understand science and health (agree)")
pct_pro <- function(x, w) 100 * weighted.mean(x >= 3, w, na.rm = TRUE)   # top two categories
party_grp <- fifelse(d$pid7 <= 3, "Democrat", fifelse(d$pid7 >= 5, "Republican", "Independent"))

expert_change <- rbindlist(lapply(names(expert_items), function(it) {
  a <- d[[paste0("x_", it, "_17")]]; b <- d[[paste0("x_", it, "_20")]]
  ok <- !is.na(a) & !is.na(b) & !is.na(d$w_allpanel)
  grp <- function(g) {
    s <- ok & party_grp == g
    c(pct_pro(a[s], d$w_allpanel[s]), pct_pro(b[s], d$w_allpanel[s]))
  }
  data.table(item = expert_items[[it]],
             all_2017 = pct_pro(a[ok], d$w_allpanel[ok]), all_2020 = pct_pro(b[ok], d$w_allpanel[ok]),
             dem_2017 = grp("Democrat")[1], dem_2020 = grp("Democrat")[2],
             rep_2017 = grp("Republican")[1], rep_2020 = grp("Republican")[2],
             r_within = cor(a[ok], b[ok]), n = sum(ok))
}))

n_panel <- nrow(d)

# ==== Models =========================================================================
# Design: research-design/expert-trust-covid-design.md (§3). All models: lavaan WLSMV,
# theta parameterization, ordinal indicators, pairwise missing, observed covariates
# conditional (conditional.x = TRUE; cases missing a covariate are dropped). Unweighted.
# Values and civic orientations are latent (trimmed M6); expert trust is latent at T1 (2017)
# and T2 (Nov 2020) with thresholds, loadings and intercepts equal across waves.
# Block 1 = values + civic orientations + controls; Block 2 adds party ID and ideology.
#
# Fitting takes several minutes, so results (tables only, not fit objects) are cached in
# output/model-results.rds and refit only when this script or the data file is newer.

library(lavaan)
library(semTools)

d[, age_dec := age_2020 / 10]
val_items <- list(
  ECON     = c("e_equalopp", "e_worryless", "e_chance", "e_fewerprob", "e_redist", "e_wealth",
               "e_econbias", "e_unfair", "i_govless", "i_freemkt", "i_overreg", "i_nohealth"),
  AUTH     = c("auth_respect", "auth_manners", "auth_obey", "auth_behaved"),
  RELIG    = c("relig_serv", "relig_imp"),
  DISTRUST = c("dist_careful", "dist_selfish", "dist_unfair"),
  INEFF    = c("ineff_nosay", "ineff_elecnot"))
vals <- names(val_items)
val_labels <- c(ECON = "Egalitarianism (vs. individualism)", AUTH = "Authoritarianism",
                RELIG = "Religiosity", DISTRUST = "Social distrust", INEFF = "Political inefficacy",
                pid7 = "Party ID (Republican high)", ideo5 = "Ideology (conservative high)")
et_items <- c("x_trustexp", "x_facts", "x_help")
et17 <- paste0(et_items, "_17"); et20 <- paste0(et_items, "_20")
ctrl <- c("age_dec", "female", "black", "hispanic", "other_race", "educ", "faminc",
          "inc_missing", "newsint")
blocks <- list(B1 = ctrl, B2 = c(ctrl, "pid7", "ideo5"))
ord_vals <- unlist(val_items, use.names = FALSE)

# ---- Syntax builders -----------------------------------------------------------------
# fx(): value fixed in group 1, free in later groups (multigroup identification)
fx <- function(v, ng) if (ng == 1) v else sprintf("c(%s)", paste(c(v, rep("NA", ng - 1)), collapse = ", "))
rhs <- function(x) paste(x, collapse = " + ")

meas_val <- function(ng = 1) paste(c(
  sapply(c("ECON", "AUTH", "DISTRUST"), function(f)
    paste0(f, " =~ NA*", val_items[[f]][1], " + ", rhs(val_items[[f]]))),
  "RELIG =~ NA*relig_serv + r*relig_serv + r*relig_imp",          # equal loadings: 2-item factors
  "INEFF =~ NA*ineff_nosay + q*ineff_nosay + q*ineff_elecnot",
  paste0(vals, " ~~ ", fx("1", ng), "*", vals),
  if (ng > 1) paste0(vals, " ~ ", fx("0", ng), "*1")), collapse = "\n")
val_cov <- paste(combn(vals, 2, function(p) paste(p, collapse = " ~~ ")), collapse = "\n")

# expert trust at T1 and T2: equal loadings (l), thresholds (a, b, c) and intercepts (0);
# T1 item residual variances fixed at 1, T2 free; same-item residuals correlated over time
meas_et <- function(ng = 1, t2 = TRUE) {
  th <- function(v, l) paste0(v, " | ", l, "1*t1 + ", l, "2*t2 + ", l, "3*t3")
  out <- c("ET17 =~ NA*x_trustexp_17 + l1*x_trustexp_17 + l2*x_facts_17 + l3*x_help_17",
           mapply(th, et17, c("a", "b", "c")),
           paste0("ET17 ~~ ", fx("1", ng), "*ET17"), paste0("ET17 ~ ", fx("0", ng), "*1"))
  if (t2) out <- c(out,
           "ET20 =~ NA*x_trustexp_20 + l1*x_trustexp_20 + l2*x_facts_20 + l3*x_help_20",
           mapply(th, et20, c("a", "b", "c")),
           paste0(et20, " ~~ NA*", et20), paste0(et17, " ~~ ", et20))
  paste(out, collapse = "\n")
}
lcs_struct <- "ET20 ~ 1*ET17\nD =~ 1*ET20\nET20 ~~ 0*ET20\nET20 ~ 0*1\nD ~ 1\nD ~~ D\nET17 ~~ D"

# LCS: baseline (ET17) and absolute latent change (D) on values + covariates (RQ1, RQ2)
m_lcs <- function(x, ng = 1, dlab = NULL) {
  dterms <- if (is.null(dlab)) rhs(c(vals, x)) else
    rhs(c(sprintf("c(%s)*%s", sapply(vals, function(v) paste0(v, "_g", seq_len(ng), collapse = ", ")), vals), x))
  paste(meas_val(ng), val_cov, meas_et(ng), lcs_struct,
        paste0("ET17 ~ ", rhs(c(vals, x))), paste0("D ~ ", dterms),
        paste0(vals, " ~ ", rhs(x), collapse = "\n"), sep = "\n")
}
# LDV: T2 on T1 + values + covariates (RQ2, conditional change)
m_ldv <- function(x) paste(meas_val(), val_cov, meas_et(),
  "ET20 ~~ ET20\nET20 ~ 1", paste0("ET20 ~ ET17 + ", rhs(c(vals, x))),
  paste0("ET17 ~ ", rhs(c(vals, x))), paste0(vals, " ~ ", rhs(x), collapse = "\n"), sep = "\n")
# single ordinal outcome with an observed lag (specificity and pre-trends, RQ3)
m_item <- function(y, lag, x) paste(meas_val(), val_cov,
  paste0(y, " ~ ", rhs(c(vals, lag, x))), paste0(vals, " ~ ", rhs(c(lag, x)), collapse = "\n"), sep = "\n")
# CDC confidence (Nov 2020 only) with latent T1 expert trust as the lag
m_cdc <- function(x) paste(meas_val(), val_cov, meas_et(t2 = FALSE),
  paste0("cdc_conf_20 ~ ", rhs(c("ET17", vals, x))), paste0("ET17 ~ ", rhs(c(vals, x))),
  paste0(vals, " ~ ", rhs(x), collapse = "\n"), sep = "\n")

# warnings are collected (with the model name) rather than printed, and saved with the results
fit_warnings <- list()
fit_sem <- function(model, ordered, data = d, name = "", ...) {
  withCallingHandlers(
    sem(model, data = as.data.frame(data), ordered = ordered, estimator = "WLSMV",
        parameterization = "theta", missing = "pairwise", ...),
    warning = function(w) {
      fit_warnings[[length(fit_warnings) + 1]] <<- data.table(model = name, warning = gsub("\\s+", " ", conditionMessage(w)))
      invokeRestart("muffleWarning")
    })
}

# ---- Extraction helpers -------------------------------------------------------------------
fit_row <- function(f) {
  fm <- fitMeasures(f, c("chisq.scaled", "df.scaled", "cfi.scaled", "tli.scaled", "rmsea.scaled", "srmr"))
  data.table(n = lavInspect(f, "ntotal"), t(round(fm, 3)))
}
paths <- function(f, y, rhs_vars = c(vals, "pid7", "ideo5")) {
  pe <- as.data.table(parameterEstimates(f, standardized = TRUE))
  pe[op == "~" & lhs %in% y & rhs %in% rhs_vars,
     .(lhs, rhs, group = if ("group" %in% names(pe)) group else 1L, label,
       est, se, p = pvalue, std = std.all)]
}
# effect of a 1 SD difference in a predictor on latent change, in T1 SD units
per_sd <- function(f, tab) {
  sdl <- sqrt(diag(lavInspect(f, "cov.lv")))
  sd_pred <- ifelse(tab$rhs %in% names(sdl), sdl[tab$rhs], sapply(tab$rhs, function(v) sd(d[[v]], na.rm = TRUE)))
  k <- sd_pred / sdl["ET17"]
  tab[, `:=`(sd_est = est * k, sd_lo = (est - 1.96 * se) * k, sd_hi = (est + 1.96 * se) * k)]
}

# ---- Fit (or load cached results) ------------------------------------------------------------
cache_file <- "output/model-results.rds"
cache_ok <- file.exists(cache_file) &&
  file.mtime(cache_file) > max(file.mtime(c("scripts/analysis.R", "data/voter_panel.csv")))

if (cache_ok) {
  res <- readRDS(cache_file)
} else {
  res <- list()
  ord_et <- c(et17, et20)

  # 1. Longitudinal invariance of expert trust (Wu & Estabrook 2016 identification)
  inv_dat <- as.data.frame(d[, c(et17, et20), with = FALSE])
  inv_fit <- function(eq) measEq.syntax(
    configural.model = "ET17 =~ x_trustexp_17 + x_facts_17 + x_help_17\nET20 =~ x_trustexp_20 + x_facts_20 + x_help_20",
    data = inv_dat, ordered = ord_et, parameterization = "theta", ID.fac = "std.lv",
    ID.cat = "Wu.Estabrook.2016", longFacNames = list(ET = c("ET17", "ET20")),
    longIndNames = setNames(lapply(et_items, function(i) paste0(i, c("_17", "_20"))), et_items),
    long.equal = eq, auto = 1L, return.fit = TRUE, estimator = "WLSMV", missing = "pairwise")
  inv <- list(Configural = inv_fit(""), Thresholds = inv_fit("thresholds"),
              `+ Loadings` = inv_fit(c("thresholds", "loadings")),
              `+ Intercepts` = inv_fit(c("thresholds", "loadings", "intercepts")))
  lrt <- lavTestLRT(inv$Thresholds, inv$`+ Loadings`, inv$`+ Intercepts`)
  res$invariance <- data.table(model = names(inv), rbindlist(lapply(inv, fit_row)),
                               dchisq = c(NA, NA, lrt$`Chisq diff`[2:3]), ddf = c(NA, NA, lrt$`Df diff`[2:3]),
                               p_diff = c(NA, NA, lrt$`Pr(>Chisq)`[2:3]))

  # 2. Unconditional latent change (mean and variance of change, T1 SD units)
  f0 <- fit_sem(paste(meas_et(), lcs_struct, sep = "\n"), ordered = ord_et, name = "unconditional")
  pe0 <- as.data.table(parameterEstimates(f0))
  res$uncond <- list(mean_D = pe0[lhs == "D" & op == "~1"], var_D = pe0[lhs == "D" & op == "~~" & rhs == "D"],
                     var_ET20 = lavInspect(f0, "cov.lv")["ET20", "ET20"],
                     cor_T1_T2 = cov2cor(lavInspect(f0, "cov.lv"))["ET17", "ET20"])

  # 3. RQ1 + RQ2: LCS and LDV, Blocks 1 and 2
  res$lcs <- lapply(names(blocks), function(b) {
    x <- blocks[[b]]
    f <- fit_sem(m_lcs(x), ordered = c(ord_vals, ord_et), name = paste("LCS", b))
    list(fit = fit_row(f), base = paths(f, "ET17"), change = per_sd(f, paths(f, "D")),
         ctrl = as.data.table(parameterEstimates(f, standardized = TRUE))[op == "~" & lhs %in% c("ET17", "D")])
  })
  names(res$lcs) <- names(blocks)
  res$ldv <- lapply(names(blocks), function(b) {
    f <- fit_sem(m_ldv(blocks[[b]]), ordered = c(ord_vals, ord_et), name = paste("LDV", b))
    list(fit = fit_row(f), change = paths(f, "ET20", c(vals, "pid7", "ideo5", "ET17")))
  })
  names(res$ldv) <- names(blocks)

  # 4. RQ3: specificity and pre-trends (single ordinal outcomes with observed lag), Block 1
  items <- data.table(
    outcome = c("Experts help (science, health)", "Scientific facts help", "Trust experts over ordinary people",
                "Trust federal government", "Confidence: military", "Confidence: Supreme Court",
                "Confidence: big business", "Media trust, pre (Jan to Nov 2019)", "Media trust, post (Nov 2019 to Nov 2020)"),
    y   = c("x_help_20", "x_facts_20", "x_trustexp_20", "trustgovt_20", "inst_military_20", "inst_court_20",
            "inst_business_20", "mediatrust_2019Nov", "mediatrust_2020Nov"),
    lag = c("x_help_17", "x_facts_17", "x_trustexp_17", "trustgovt_17", "inst_military_19", "inst_court_19",
            "inst_business_19", "mediatrust_2019Jan", "mediatrust_2019Nov"),
    window = c(rep("2017 to Nov 2020", 4), rep("Jan 2019 to Nov 2020", 3), "Jan to Nov 2019", "Nov 2019 to Nov 2020"))
  res$items <- rbindlist(lapply(seq_len(nrow(items)), function(i) {
    f <- fit_sem(m_item(items$y[i], items$lag[i], ctrl), ordered = c(ord_vals, items$y[i]), name = items$y[i])
    cbind(items[i, .(outcome, window)], n = lavInspect(f, "ntotal"), paths(f, items$y[i], vals))
  }))
  fc <- fit_sem(m_cdc(ctrl), ordered = c(ord_vals, et17, "cdc_conf_20"), name = "CDC")
  res$items <- rbind(res$items, cbind(data.table(outcome = "Confidence: CDC",
                                                 window = "Nov 2020"), n = lavInspect(fc, "ntotal"),
                                      paths(fc, "cdc_conf_20", vals)))

  # 5. RQ4: multigroup LCS by COVID exposure (no circle vs. at least one circle with a case), Block 1
  fe <- fit_sem(m_lcs(ctrl, ng = 2, dlab = TRUE), ordered = c(ord_vals, ord_et), group = "exposed",
                group.label = c("0", "1"), group.equal = c("loadings", "thresholds"), name = "exposure")
  expo <- paths(fe, "D", vals)
  expo[, wald_p := sapply(rhs, function(v)
    lavTestWald(fe, constraints = sprintf("%s_g1 == %s_g2", v, v))$p.value)]
  res$exposure <- list(fit = fit_row(fe), paths = expo,
                       n_group = setNames(lavInspect(fe, "nobs"), c("Not exposed", "Exposed")))

  # 6. RQ5: latent change -> Nov 2020 COVID attitudes, Block 2 + 2017 Trump approval
  att <- c("trump_covid_app_20", "gov_covid_app_20", "fear_lift_early_20")
  x5 <- c(blocks$B2, "trumpapp_17")
  m5 <- paste(m_lcs(x5), paste0(att, " ~ ", rhs(c("D", "ET17", vals, x5)), collapse = "\n"), sep = "\n")
  f5 <- fit_sem(m5, ordered = c(ord_vals, ord_et, att), name = "consequences")
  res$consequences <- list(fit = fit_row(f5),
    paths = as.data.table(parameterEstimates(f5, standardized = TRUE))[
      op == "~" & lhs %in% att & rhs %in% c("D", "ET17"), .(lhs, rhs, est, se, p = pvalue, std = std.all)])

  # 7. Robustness: Block 2 with party ID only (ideology overlaps heavily with ECON)
  fr <- fit_sem(m_lcs(c(ctrl, "pid7")), ordered = c(ord_vals, ord_et), name = "LCS party only")
  res$robust_party <- list(fit = fit_row(fr), base = paths(fr, "ET17"), change = per_sd(fr, paths(fr, "D")))
  res$warnings <- rbindlist(fit_warnings)
  dir.create("output", showWarnings = FALSE)
  saveRDS(res, cache_file)
}
# Notes on expected warnings (res$warnings): lavaan reports cases dropped for missing
# covariates (listwise on conditional covariates), and in two models a near-1.0 tetrachoric
# correlation between i_govless and e_wealth (binary economic items; see the measurement pass).

# ==== Tables and figures for the manuscript ===================================================
stars <- function(p) ifelse(p < .001, "***", ifelse(p < .01, "**", ifelse(p < .05, "*", "")))
f2 <- function(x) formatC(x, format = "f", digits = 2)
beta <- function(tab, v) { r <- tab[rhs == v]; if (nrow(r) == 0) "" else paste0(f2(r$std), stars(r$p)) }
row_labels <- c(val_labels, ET17 = "Expert trust, 2017")

# Inline numbers
chg_mean  <- res$uncond$mean_D$est              # mean latent change, 2017 SD units
chg_sd    <- sqrt(res$uncond$var_D$est)          # SD of latent change
et20_sd   <- sqrt(res$uncond$var_ET20)           # SD of 2020 expert trust, 2017 SD units
et_r      <- res$uncond$cor_T1_T2                # latent T1-T2 correlation
n_b1      <- res$lcs$B1$fit$n
n_b2      <- res$lcs$B2$fit$n

# Table: longitudinal invariance
tab_invariance <- res$invariance[, .(Model = model, `χ²` = f2(chisq.scaled), df = df.scaled,
  CFI = formatC(cfi.scaled, format = "f", digits = 3), RMSEA = formatC(rmsea.scaled, format = "f", digits = 3),
  SRMR = formatC(srmr, format = "f", digits = 3),
  `Δχ²` = ifelse(is.na(dchisq), "", f2(dchisq)), `Δdf` = ifelse(is.na(ddf), "", ddf),
  p = ifelse(is.na(p_diff), "", ifelse(p_diff < .001, "< .001", sub("^0", "", formatC(p_diff, format = "f", digits = 3)))))]

# Table: baseline and change (standardized coefficients)
main_rows <- c(vals, "pid7", "ideo5", "ET17")
tab_main <- data.table(Predictor = row_labels[main_rows],
  `Baseline B1` = sapply(main_rows, function(v) beta(res$lcs$B1$base, v)),
  `Baseline B2` = sapply(main_rows, function(v) beta(res$lcs$B2$base, v)),
  `Conditional change B1` = sapply(main_rows, function(v) beta(res$ldv$B1$change, v)),
  `Conditional change B2` = sapply(main_rows, function(v) beta(res$ldv$B2$change, v)),
  `Latent change B1` = sapply(main_rows, function(v) beta(res$lcs$B1$change, v)),
  `Latent change B2` = sapply(main_rows, function(v) beta(res$lcs$B2$change, v)))
fit_lab <- function(f) c(f$n, formatC(f$cfi.scaled, format = "f", digits = 3), formatC(f$rmsea.scaled, format = "f", digits = 3))
tab_main <- rbind(tab_main, data.table(Predictor = c("N", "CFI", "RMSEA"),
  `Baseline B1` = fit_lab(res$lcs$B1$fit), `Baseline B2` = fit_lab(res$lcs$B2$fit),
  `Conditional change B1` = fit_lab(res$ldv$B1$fit), `Conditional change B2` = fit_lab(res$ldv$B2$fit),
  `Latent change B1` = fit_lab(res$lcs$B1$fit), `Latent change B2` = fit_lab(res$lcs$B2$fit)))

# Table: specificity and pre-trends (Block 1)
short_labels <- c(ECON = "Egalitarian", AUTH = "Authoritarian", RELIG = "Religiosity",
                  DISTRUST = "Distrust", INEFF = "Inefficacy")
tab_items <- res$items[, c(list(Outcome = outcome[1], N = n[1]),
                           setNames(lapply(vals, function(v) beta(.SD, v)), short_labels[vals])), by = lhs][, !"lhs"]
item_order <- c("Experts help (science, health)", "Scientific facts help", "Trust experts over ordinary people",
                "Confidence: CDC", "Trust federal government",
                "Confidence: military", "Confidence: Supreme Court", "Confidence: big business",
                "Media trust, pre (Jan to Nov 2019)", "Media trust, post (Nov 2019 to Nov 2020)")
res$items[outcome == "Confidence: CDC (Nov 2020 only; lag = 2017 expert trust)", outcome := "Confidence: CDC"]
tab_items <- tab_items[match(item_order, Outcome)]

# Table: COVID exposure (multigroup latent change, Block 1)
ex <- res$exposure$paths
tab_exposure <- data.table(Predictor = val_labels[vals],
  `Not exposed` = sapply(vals, function(v) ex[rhs == v & group == 1, paste0(f2(est), " (", f2(se), ")", stars(p))]),
  Exposed = sapply(vals, function(v) ex[rhs == v & group == 2, paste0(f2(est), " (", f2(se), ")", stars(p))]),
  `Difference p` = sapply(vals, function(v) formatC(ex[rhs == v & group == 1, wald_p], format = "f", digits = 3)))

# Table: consequences (Block 2 + 2017 Trump approval)
cp <- res$consequences$paths
att_labels <- c(trump_covid_app_20 = "Approve of Trump's COVID handling",
                gov_covid_app_20 = "Approve of governor's COVID handling",
                fear_lift_early_20 = "Worry restrictions lifted too quickly")
tab_consequences <- data.table(Outcome = att_labels,
  `Change in expert trust` = sapply(names(att_labels), function(y) cp[lhs == y & rhs == "D", paste0(f2(std), stars(p))]),
  `Expert trust, 2017` = sapply(names(att_labels), function(y) cp[lhs == y & rhs == "ET17", paste0(f2(std), stars(p))]))

# Table: robustness, latent change per SD (2017 SD units)
rob <- function(tab, v) { r <- tab[rhs == v]; if (nrow(r) == 0) "" else paste0(f2(r$sd_est), stars(r$p)) }
rob_rows <- c(vals, "pid7", "ideo5")
tab_robust <- data.table(Predictor = val_labels[rob_rows],
  `Block 1` = sapply(rob_rows, function(v) rob(res$lcs$B1$change, v)),
  `Block 2: party only` = sapply(rob_rows, function(v) rob(res$robust_party$change, v)),
  `Block 2: party and ideology` = sapply(rob_rows, function(v) rob(res$lcs$B2$change, v)))

# Figure: percent pro-expert by party, 2017 and Nov 2020 (weighted)
fig_descriptive <- function() {
  op <- par(mar = c(4, 7, 1, 1)); on.exit(par(op))
  grp <- c(all = "All", dem = "Democrats", rep = "Republicans")
  cols <- c(all = "grey30", dem = "#2166ac", rep = "#b2182b")
  k <- nrow(expert_change); ypos <- matrix(rev(seq_len(k * 4)), nrow = 4)   # row 1 = item title
  plot(NA, xlim = c(0, 100), ylim = c(0.5, k * 4 + 0.3), yaxt = "n", xlab = "Percent pro-expert", ylab = "")
  for (i in seq_len(k)) {
    text(0, ypos[1, i], sub(" \\(.*", "", expert_change$item[i]), adj = 0, font = 2, cex = 0.85)
    for (j in seq_along(grp)) {
      g <- names(grp)[j]; yy <- ypos[j + 1, i]
      a <- expert_change[[paste0(g, "_2017")]][i]; b <- expert_change[[paste0(g, "_2020")]][i]
      arrows(a, yy, b, yy, length = 0.06, col = cols[g], lwd = 2); points(a, yy, pch = 16, col = cols[g])
      axis(2, at = yy, labels = grp[g], las = 1, tick = FALSE, cex.axis = 0.8)
    }
  }
}

# Figure: predicted latent change per SD of each predictor, Blocks 1 and 2
fig_change <- function() {
  op <- par(mar = c(4, 14, 1, 1)); on.exit(par(op))
  rows <- c(vals, "pid7", "ideo5"); k <- length(rows)
  plot(NA, xlim = c(-0.3, 0.5), ylim = c(0.5, k + 0.5), yaxt = "n",
       xlab = "Latent change per 1 SD of predictor (2017 SD units)", ylab = "")
  abline(v = 0, lty = 2, col = "grey60")
  axis(2, at = k:1, labels = val_labels[rows], las = 1, tick = FALSE, cex.axis = 0.85)
  for (b in c("B1", "B2")) {
    t <- res$lcs[[b]]$change; off <- if (b == "B1") 0.12 else -0.12; col <- if (b == "B1") "grey20" else "#2166ac"
    for (v in rows) if (v %in% t$rhs) {
      r <- t[rhs == v]; yy <- (k:1)[match(v, rows)] + off
      segments(r$sd_lo, yy, r$sd_hi, yy, col = col, lwd = 2); points(r$sd_est, yy, pch = if (b == "B1") 16 else 17, col = col)
    }
  }
  legend("bottomright", legend = c("Block 1", "Block 2 (+ party, ideology)"), pch = c(16, 17),
         col = c("grey20", "#2166ac"), bty = "n", cex = 0.85)
}

# ==== Accessors for inline numbers in the manuscript text ======================================
f3   <- function(x) sub("^(-?)0\\.", "\\1.", formatC(x, format = "f", digits = 3))   # .998
fp   <- function(p) ifelse(p < .001, "p < .001", paste0("p = ", f3(p)))
pct  <- function(x) formatC(x, format = "f", digits = 0)
nfmt <- function(x) format(x, big.mark = ",")
chg      <- function(v, b = "B1") res$lcs[[b]]$change[rhs == v]   # sd_est (2017 SD units), p
chg_pty  <- function(v) res$robust_party$change[rhs == v]
base_b   <- function(v, b = "B1") res$lcs[[b]]$base[rhs == v]     # std, p
ldv_b    <- function(v, b = "B1") res$ldv[[b]]$change[rhs == v]
item_b   <- function(o, v) res$items[outcome == o & rhs == v]
expo_b   <- function(v, g) res$exposure$paths[rhs == v & group == g]
cons_b   <- function(y, v = "D") res$consequences$paths[lhs == y & rhs == v]
ec       <- function(i, col) expert_change[[col]][i]                # weighted percent pro-expert
inv_full <- res$invariance[model == "+ Intercepts"]
