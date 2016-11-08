context("get_pheno")

test_that("get_pheno works", {

    df <- get_pheno("10001")
    expect_true(is.data.frame(df))
    expect_true(ncol(df) == 4)
    expect_equal(colnames(df), c("id", "strain", "value", "SE"))
    expect_true(is.numeric(df[,1]))
    expect_true(is.character(df[,2]))
    expect_true(is.numeric(df[,3]))
    expect_true(is.numeric(df[,4]))

})

test_that("get_pheno gives error for mRNA data", {

    expect_error( get_pheno("HC_U_0304_R") )

})
