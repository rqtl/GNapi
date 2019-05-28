#' Run gemma
#'
#' Perform a genome scan using gemma
#'
#' @param dataset ID for dataset being used (`Short_Abbreviation`)
#' @param trait ID for trait being mapped
#' @param use_loco Whether to use LOCO (leave one chromosome out)
#' @param maf Filter on minor allele frequency
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame
#'
#' @export
#'
#' @examples
#' out <- run_gemma("BXDPublish", "10015")
run_gemma <-
    function(dataset, trait, use_loco=FALSE, maf=0.01, url=gnapi_url())
{
    stopifnot(length(trait)==1)
    stopifnot(length(dataset)==1)

    use_loco <- ifelse(use_loco, "true", "false")

    result <- query_gn(paste0("mapping?trait_id=", trait,
                              "&db=", dataset,
                              "&method=gemma",
                              "&use_loco=", use_loco,
                              "&maf=", maf),
                       url, output="text")

    read.table(text=result, sep=",", header=TRUE, comment.char="#")
}


#' Run R/qtl
#'
#' Perform a genome scan using R/qtl
#'
#' @param dataset ID for dataset being used (`Short_Abbreviation`)
#' @param trait ID for trait being mapped
#' @param method Indicates whether to use the EM algorithm, imputation, Haley-Knott regression, the extended Haley-Knott method, or marker regression.
#' @param model The phenotype model: the usual normal model, a model for binary traits, a two-part model, or non-parametric analysis
#' @param n_perm Number of permutations
#' @param control_marker Name of marker to use as control
#' @param interval_mapping Whether to use interval mapping
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame
#'
#' @export
#'
#' @examples
#' out <- run_gemma("BXDPublish", "10015")
run_rqtl <-
    function(dataset, trait, method=c("hk", "ehk", "em", "imp", "mr", "mr-imp[", "mr-argmax"),
             model=c("normal", "binary", "2part", "np"),
             num_perm=0, control_marker=NULL, interval_mapping=FALSE,
             url=gnapi_url())
{
    stopifnot(length(trait)==1)
    stopifnot(length(dataset)==1)

    method <- match.arg(method)
    model <- match.arg(model)

    query <- paste0("mapping?trait_id=", trait,
                    "&db=", dataset,
                    "&method=rqtl",
                    "&rqtl_method=", method,
                    "&rqtl_model=", model,
                    "&interval_mapping=", interval_mapping)
    if(!is.null(control_marker)) {
        query <- paste0(query, "&control_marker=", control_marker)
    }
    stopifnot(num_perm >= 0)
    if(num_perm > 0) {
        query <- paste0(query, "&num_perm=", num_perm)
    }

    result <- query_gn(query, url, output="text")

    read.table(text=result, sep=",", header=TRUE, comment.char="#")
}