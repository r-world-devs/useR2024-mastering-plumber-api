#' Hello world
#'
#' @return single character vector
#' @export
#'
#' @examples
#' hello()
hello <- function() {
  print("Hello, world!")
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
