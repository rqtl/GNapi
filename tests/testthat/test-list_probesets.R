context("list_probesets")

test_that("list_probesets works", {

    result <- list_probesets("HC_U_0304_R", 100, 101)
    expect_true(is.list(result))

})
