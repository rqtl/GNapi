context("list_datasets")

test_that("list_datasets works", {

    df <- list_datasets("BXD")
    expect_true(ncol(df)==3)
    expect_equal(colnames(df), c("id", "name", "description"))
    expect_true(is.numeric(df[,1]))
    expect_true(is.character(df[,2]))
    expect_true(is.character(df[,3]))

})
