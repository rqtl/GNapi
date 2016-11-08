context("info_cross")

test_that("info_cross works", {

    df <- info_cross("BXD")
    expect_true(is.list(df))

})
