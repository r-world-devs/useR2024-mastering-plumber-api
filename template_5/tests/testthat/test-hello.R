test_that("test hello", {
  expect_identical(hello(), list(msg = "Hello, world!"))
})

test_that("test echo", {
  expect_true(
    grepl(
      "custom_echo_message",
      echo("custom_echo_message")
    )
  )
})
