#' Exit serialization from plumber
#' @param val val to serialize
#' @param req plumber req
#' @param res plumber res
#' @param errorHandler custom error handler
#' @export
do_not_serialize <- function (val, req, res, errorHandler) {
  tryCatch({
    res$body <- val
    return(res$toResponse())
  }, error = function(e) {
    errorHandler(req, res, e)
  })
}

#' Dummy function to avoid R CMD check note
dummy <- function() {
  pkgload::load_all
  NULL
}

