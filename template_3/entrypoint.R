# entrypoint.R
library(plumber)

# Load the API
pr <- pr() |>
  pr_handle(
    methods = "GET",
    path = "/echo",
    handler = function(msg="") {
      list(msg = paste0("The message is: '", msg, "'"))
    },
    comments = "Echo back the input",
    description = "Returns message back to the user.",
    params = list(
      "msg" = list(
        type = "string",
        required = TRUE,
        desc = "The message to echo"
      )
    ),
    tags = "echo",
    serializer = plumber::serializer_unboxed_json()
  )

# Must return a Plumber object when using `entrypoint.R`
pr
