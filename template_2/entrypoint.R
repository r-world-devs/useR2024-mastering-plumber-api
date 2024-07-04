# entrypoint.R
library(plumber)

# Load the API
pr <- plumb("plumber.R") |>
  pr_set_api_spec(
    function(spec) {
      spec$paths[["/plot"]]$get$summary <- "Plot endpoint custom title"
      spec # Return the updated specification
    }
  )

# Must return a Plumber object when using `entrypoint.R`
pr
