context("check_gn")

test_that("check_gn works", {

    version <- check_gn()
    expect_true(length(version)==1)
    expect_true(is.character(version))

})
