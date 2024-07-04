#' onLoad function
#'
#' This function is called automatically during package loading.
#'
#' @param libname lib name
#' @param pkgname package name
#' @noRd
.onLoad <- function(libname, pkgname) { # nolint

  # Workaround for pkgload and plumber as a package
  system_file <- function (..., package = "base", lib.loc = NULL, mustWork = FALSE) {
    base_system_file <- attr(sys.function(), "orginal", exact = TRUE)
    dev_packages <- get("dev_packages", envir = asNamespace("pkgload"), inherits = FALSE)
    if (!(package %in% dev_packages()) && is.function(base_system_file)) {
      base_system_file(..., package = package, lib.loc = lib.loc,
                       mustWork = mustWork)
    }
    else {
      pkg_path <- find.package(package)
      files_inst <- file.path(pkg_path, "inst", ...)
      present_inst <- file.exists(files_inst)
      files_top <- file.path(pkg_path, ...)
      present_top <- file.exists(files_top)
      files <- files_top
      files[present_inst] <- files_inst[present_inst]
      files <- files[present_inst | present_top]
      if (length(files) > 0) {
        normalizePath(files, winslash = "/")
      }
      else {
        if (mustWork) {
          stop("No file found", call. = FALSE)
        }
        else {
          ""
        }
      }
    }
  }

  attr(system_file, "orginal") <- base::system.file


  if (!is.function(attr(base::system.file, "orginal", exact = TRUE))) {
    environment(system_file) <- asNamespace("pkgload")

    rlang::env_unlock(env = asNamespace("base"))
    rlang::env_binding_unlock(env = asNamespace("base"))

    assign("system.file", system_file, envir = asNamespace("base"))

    rlang::env_binding_lock(env = asNamespace("base"))
    rlang::env_lock(asNamespace("base"))
  }
}
