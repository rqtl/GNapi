context("get_gmap")

test_that("get_gmap works", {

    df <- get_gmap("BXD")
    expect_true(is.data.frame(df))
    expect_equal(ncol(df), 4)
    expect_equal(colnames(df), c("marker", "chr", "pos", "Mb"))

})
