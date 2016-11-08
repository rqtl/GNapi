context("info_dataset")

test_that("info_dataset works", {

    df <- info_dataset("HC_U_0304_R")
    expect_true(is.list(df))

})
