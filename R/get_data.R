#' Get phenotype data
#'
#' Get phenotype data
#'
#' @param dataset Short abbreviation for a dataset, or name of a group
#' @param trait Optional trait name
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame, with samples as rows and either traits as columns or
#' with the columns being detailed information for a single trait
#'
#' @seealso [get_geno()]
#'
#' @importFrom utils read.table
#' @export
#'
#' @examples
#' \donttest{ph1 <- get_pheno("BXDPublish")}
#' ph2 <- get_pheno("BXD", "10002")
#' ph3 <- get_pheno("HC_M2_0606_P", "1436869_at")
get_pheno <-
    function(dataset, trait=NULL, url=gnapi_url())
{
    stopifnot(length(dataset)==1)

    if(is.null(trait)) {
        result <- query_gn(paste0("sample_data/", dataset), url=url, output="text")
        result <- read.table(text=result, sep=",", header=TRUE,
                             na.strings="x", stringsAsFactors=FALSE )

        # trait names as row names
        if(length(unique(result[,1])) != nrow(result)) {
            warning("trait IDs are not unique")
        }
        rownames(result) <- result[,1]

        # samples as rows, traits as columns
        result <- t(result[,-1])

    } else {
        stopifnot(length(trait)==1)
        result <- query_gn(paste0("sample_data/", dataset, "/", trait), url=url)
        result <- list2df(result)

        # sample IDs as row names?
        if("sample_name" %in% colnames(result)) {
            if(length(unique(result$sample_name)) == nrow(result)) {
                rownames(result) <- result$sample_name
            } else {
                warning("sample_name values are not distinct")
            }
        }
    }

    result
}

#' Get genotype data
#'
#' Get genotype data
#'
#' @param group Name of group
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame
#'
#' @importFrom utils read.table
#' @export
#'
#' @seealso [get_pheno()], [list_groups()]
#'
#' @examples
#' g <- get_geno("QSM")
get_geno <-
    function(group, url=gnapi_url())
{
    stopifnot(length(group) == 1)

    result <- query_gn(paste0("genotypes/", group), url=url, output="text")

    # replace @ with #
    result <- gsub("@", "#", result, fixed=TRUE)

    # check if there's any input
    lines <- strsplit(result, "\\r*\\n")[[1]]
    if(all(grepl("^#", lines))) {
        message("The results have no data.")
        return(NULL)
    }

    # read into a data frame
    read.table(text=result, comment.char="#", sep="\t", header=TRUE)
}
