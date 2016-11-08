context("get_geno")

test_that("get_geno works", {

    df <- get_geno("BXD")
    expect_true(is.data.frame(df))

})
