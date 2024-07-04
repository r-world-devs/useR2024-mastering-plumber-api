## ---- entrypoint

pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)

plumber::available_apis("Template4")

pr <- plumber::plumb_api("Template4", "api")

pr
