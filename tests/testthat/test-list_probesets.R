context("list_probesets")

test_that("list_probesets works", {

    result <- list_probesets("HC_U_0304_R")
    expect_true(is.list(result))

})
