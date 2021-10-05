
# example on how to lazyload r markdown cache into environment

library(qwraps2)
qwraps2::lazyload_cache_dir(
  path = "code/CAF_CRISPR_report_v3_cache/html",
  envir = parent.frame(),
  ask = FALSE,
  verbose = TRUE,
  full.names = TRUE
)
