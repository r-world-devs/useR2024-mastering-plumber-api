#' Hello world
#'
#' @return single character vector
#' @export
#'
#' @examples
#' hello()
hello <- function(req, res) {
  list(msg = "Hello, world!")
}

#' Hello world
#'
#' @return single chacrater vector
#' @export
#'
#' @examples
#' echo("abc")
echo <- function(msg="", req, res) {
  list(msg = paste0("The message is: '", msg, "'"))
}

#' Slow endpoint with 10sec sleep
#'
#' @export
#'
slow <- function(req, res) {
  Sys.sleep(10)
  list(msg = "Done!")
}

#' Decorate function with future_promise
#' @param fun Function to decorate
#' @return The input function decorated with future_promise
promise_decorate <- function(fun) {
  # Define
  if (isFALSE(getOption("plumber.use.promises", TRUE))) fun

  # Create new function with future_promise evaluation
  rlang::new_function(alist(... = ), rlang::expr({
    promises::future_promise({
      fun(...)
    })
  }), env = rlang::current_env())

}
