context("info_geno")

test_that("info_geno works", {

    result <- info_geno("BXD")
    expect_true(is.list(result))

})
