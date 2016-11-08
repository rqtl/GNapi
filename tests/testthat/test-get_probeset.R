context("get_probeset")

test_that("get_probeset works", {

    result <- get_probeset("HC_U_0304_R", "104617_at")
    expect_true(is.data.frame(result))
    expect_true(ncol(result) == 4)
    expect_equal(colnames(result), c("id", "strain", "value", "SE"))
    expect_true(is.numeric(result[,1]))
    expect_true(is.character(result[,2]))
    expect_true(is.numeric(result[,3]))
    expect_true(is.numeric(result[,4]))

})

test_that("get_probeset works again", {

    result <- get_probeset("HC_M2_0606_P", "1443823_s_at")
    expect_true(is.data.frame(result))
    expect_true(ncol(result) == 4)
    expect_equal(colnames(result), c("id", "strain", "value", "SE"))
    expect_true(is.numeric(result[,1]))
    expect_true(is.character(result[,2]))
    expect_true(is.numeric(result[,3]))
    expect_true(is.numeric(result[,4]))

})
