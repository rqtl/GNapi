context("list_species")

test_that("list_species works", {

    sp <- list_species()
    expect_true(is.data.frame(sp))
    expect_true(ncol(sp) == 3)
    expect_equal(colnames(sp), c("id", "common", "species"))
    expect_true(is.numeric(sp[,1]))
    expect_true(is.character(sp[,2]))
    expect_true(is.character(sp[,3]))

})
