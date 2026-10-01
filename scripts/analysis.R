# Core Values and Trust in Experts Before and After COVID-19
# Analysis code sourced by values-expert-trust-covid.qmd (run from the project root).
#
# Data: Democracy Fund VOTER Survey panel (data/voter_panel.csv; not tracked in git)
# Design: research-design/expert-trust-covid-design.md
#
# Analytic panel: respondents in both the Jul 2017 and Nov 2020 waves (n = 2,544).
# Values are measured pre-COVID (2011, 2016, 2017); expert trust in 2017 (T1) and
# Nov 2020 (T2); COVID mediators and exposure in Sep 2020.
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
  "govtreg_business_2017", "univhealthcov_2017", "sexism_roles_2016", "class_manlymen_2017",
  "fatalism2_2011",
  # AUTH, RELIG, DISTRUST, INEFF
  "sc1_independent_2016", "sc2_curiosity_2016", "sc3_obedience_2016", "sc4_considerate_2016",
  "religservice_2016", "religimp_2016",
  "people_trust_2016", "people_helpful_2016", "people_fair_2016",
  "nosay_2016", "electionsmatter_2016")
outcome_vars <- c(paste0("expert_", rep(c("trustordinary", "facts", "help", "struggle"), 2),
                         rep(c("_2017", "_2020Nov"), each = 4)),
                  "inst_cdc_2020Nov")
covid_vars <- c("trumpapp_covid_2020Sep", "govapp_covid_2020Sep", "covid_concern_2020Sep",
                "covid_endrestrictions_2020Sep",
                paste0("covid_restrict_", c("gathering", "business", "school", "wfh",
                                            "travel", "stayhome", "test"), "_2020Sep"),
                paste0("covid_sick", c("you", "family", "work", "friend"), "_2020Sep"))
placebo_vars <- c("trustgovt_2017", "trustgovt_2020Nov",
                  paste0("inst_", rep(c("military", "court", "business", "congress", "media"), 2),
                         rep(c("_2019Jan", "_2020Nov"), each = 5)),
                  paste0("beliefinmedia_", c("2016", "2019Jan", "2019Nov", "2020Nov")))
control_vars <- c("pid7_2017", "ideo5_2017", "educ_2017", "birthyr_2011", "gender_2011",
                  "race_2017", "faminc_2017", "newsint_2017", "inputstate_2020Nov", "cdid_2020Nov")
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
  e_equalopp  = rc(egalitarian_opportunities_2017, 1:5, rev_k(5)),
  e_worryless = rc(egalitarian_worryless_2017, 1:5),
  e_chance    = rc(egalitarian_chance_2017, 1:5),
  e_fewerprob = rc(egalitarian_fewerproblems_2017, 1:5, rev_k(5)),
  e_redist    = rc(income_redistribution_2017, 1:3, function(x) c(3, 1, 2)[x]),
  e_wealth    = rc(wealth_2016, 1:2, function(x) x - 1),
  e_econbias  = rc(economicbias_2016, 1:4, rev_k(4)),
  e_unfair    = rc(fairsociety_2016, 1:4),
  i_govless   = rc(govt_moreorless_2017, 1:2, function(x) x - 1),
  i_freemkt   = rc(govt_econinvolve_2016, 1:2, function(x) x - 1),
  i_overreg   = rc(govtreg_business_2017, 1:3, rev_k(3)),
  i_nohealth  = rc(univhealthcov_2017, 1:2, function(x) x - 1),
  h_womenrole = rc(sexism_roles_2016, 1:4, rev_k(4)),
  h_manlymen  = rc(class_manlymen_2017, 1:5, rev_k(5)),
  fw_outside  = rc(fatalism2_2011, 1:4, rev_k(4)),
  # AUTH (child-rearing)
  h_respect   = rc(sc1_independent_2016, 1:2, function(x) x - 1),
  h_manners   = rc(sc2_curiosity_2016, 1:2, function(x) x - 1),
  h_obey      = rc(sc3_obedience_2016, 1:2, function(x) 2 - x),
  h_behaved   = rc(sc4_considerate_2016, 1:2, function(x) x - 1),
  # RELIG
  h_relserv   = rc(religservice_2016, 1:6, rev_k(6)),
  h_relimp    = rc(religimp_2016, 1:4, rev_k(4)),
  # DISTRUST (2016 people_trust: 1 = "can't be too careful")
  fw_distrust = rc(people_trust_2016, 1:2, function(x) 2 - x),
  fw_selfish  = rc(people_helpful_2016, 1:2, function(x) x - 1),
  fw_unfair   = rc(people_fair_2016, 1:2, function(x) 2 - x),
  # INEFF
  fw_nosay    = rc(nosay_2016, 1:4, rev_k(4)),
  fw_elecnot  = rc(electionsmatter_2016, 1:4, rev_k(4))
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

# ---- Recode: COVID mediators and exposure (Sep 2020) -------------------------------
d[, trump_covid_app := rc(panel$trumpapp_covid_2020Sep, 1:4, rev_k(4))]
d[, gov_covid_app   := rc(panel$govapp_covid_2020Sep, 1:4, rev_k(4))]
d[, covid_concern   := rc(panel$covid_concern_2020Sep, 1:4, rev_k(4))]
d[, fear_lift_early := rc(panel$covid_endrestrictions_2020Sep, 1:2, function(x) 2 - x)]
restrict <- grep("^covid_restrict_", names(panel), value = TRUE)
d[, restrict_support := rowMeans(sapply(restrict, function(v) rc(panel[[v]], 1:4, rev_k(4)))
                                 , na.rm = TRUE)]
sick <- grep("^covid_sick", names(panel), value = TRUE)
d[, covid_exposure := rowSums(sapply(sick, function(v) rc(panel[[v]], 1:3, function(x) as.numeric(x == 1))),
                              na.rm = FALSE)]   # count of circles with a confirmed case (0-4)

# ---- Recode: placebo / pre-trend outcomes (higher = more trust) ---------------------
d[, trustgovt_17 := rc(panel$trustgovt_2017, 1:4, rev_k(4))]
d[, trustgovt_20 := rc(panel$trustgovt_2020Nov, 1:4, rev_k(4))]
for (inst in c("military", "court", "business", "congress", "media")) {
  d[, paste0("inst_", inst, "_19") := rc(panel[[paste0("inst_", inst, "_2019Jan")]], 1:4, rev_k(4))]
  d[, paste0("inst_", inst, "_20") := rc(panel[[paste0("inst_", inst, "_2020Nov")]], 1:4, rev_k(4))]
}
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
  faminc    = rc(panel$faminc_2017, 1:16),
  newsint   = rc(panel$newsint_2017, 1:4, rev_k(4)),
  state     = panel$inputstate_2020Nov,
  cdid      = panel$cdid_2020Nov,
  w_2020    = panel$weight_genpop_2020Nov,
  w_allpanel = panel$weight_allpanel_2020Nov
)]

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

# ---- Planned next steps (see research-design/expert-trust-covid-design.md §6) --------
# 1. Values measurement model (M6 from the measurement pass) on the full panel
# 2. Longitudinal invariance of the expert-trust factor, 2017 vs 2020N
# 3. RQ1 baseline, RQ2 LDV + latent change models (with/without pid7)
# 4. RQ3 placebo outcomes and pre-trends; RQ4 mediation and exposure interactions
