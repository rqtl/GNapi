context("rbind_expand")

test_that("rbind_expand works", {

    x <- list(a=1, d=2, f=3)
    y <- list(a=5, e=4, c=3, d=8)

    expect_equal(rbind_expand(x, y),
                 data.frame(a=c(1,5),
                            d=c(2,8),
                            f=c(3,NA),
                            e=c(NA,4),
                            c=c(NA,3)))

    x <- data.frame(a=c("a", "b"),
                    d=c(1, 2),
                    e=c(FALSE, FALSE),
                    stringsAsFactors=FALSE)
    y <- data.frame(d=c(5, 6),
                    e=c(TRUE, TRUE),
                    f=c("x", "y"),
                    stringsAsFactors=FALSE)
    expect_equal(rbind_expand(x,y),
                 data.frame(a=c("a","b",NA,NA),
                            d=c(1,2,5,6),
                            e=c(FALSE,FALSE,TRUE,TRUE),
                            f=c(NA,NA,"x","y"),
                            stringsAsFactors=FALSE))


    x <- list(a=5, b=NULL)
    y <- list(a=6, b=7, d=NULL, e=8)
    expect_equal(rbind_expand(x,y),
                 data.frame(a=c(5,6),
                            b=c(NA,7),
                            d=c(NA,NA),
                            e=c(NA,8)))


})
