#' Run plumber object
#'
#' @param ... All parameters for run API.
#' @param pr Plumber object by default prepare_api()
#' @export
#'
#' @examples
#' run_api()
run_api <- function(..., pr = prepare_api()) {
  pr$run(...)
}


#' Create plumber object
#'
#' @return plumber object
#' @export
#'
#' @examples
#' pr <- prepare_api()
prepare_api <- function() {
  # The package needs to be installed for multisession.
  future::plan(future::sequential())

  plumber::pr() |>
    plumber::pr_handle(
      methods = "GET",
      path = "/echo",
      handler = echo,
      comments = "Echo back the input",
      description = "Returns message back to the user.",
      params = list(
        "msg" = list(
          type = "string",
          required = TRUE,
          desc = "The message to echo"
        )
      ),
      tags = "hello_world",
      serializer = plumber::serializer_unboxed_json()
    ) |>
    plumber::pr_handle(
      methods = "GET",
      path = "/hello",
      handler = promise_decorate(hello),
      comments = "Say hello!",
      description = "Your first function.",
      tags = "hello_world",
      serializer = plumber::serializer_unboxed_json()
    ) |>
    plumber::pr_handle(
      methods = "GET",
      path = "/slow",
      handler = promise_decorate(slow),
      comments = "Slow endpoint!",
      tags = "hello_world",
      serializer = plumber::serializer_unboxed_json()
    )
}
