#' Get phenotype data
#'
#' Get phenotype data for a dataset
#'
#' @param dataset Dataset name or ID as a single character string.
#' @param url URL for GeneNetwork API
#'
#' @return Data frame with strain ID, strain name, phenotype value, and standard error.
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' get_pheno("10001")
get_pheno <-
    function(dataset, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # dataset should be a single character string
    stopifnot(!is.null(dataset), length(dataset) == 1,  is.character(dataset))

    # first check that it's the proper kind
    info <- info_dataset(dataset, url)
    if(!("dataset" %in% names(info)) || info$dataset != "phenotype")
        stop(dataset, " not of classic type")

    # get dataset
    result <- httr::GET(paste0(url, "trait/", dataset, ".json"))
    listresult <- httr::content(result)
    httr::stop_for_status(result)

    data.frame(id=grab_elements(listresult, 1, as.numeric(NA)),
               strain=grab_elements(listresult, 2, as.character(NA)),
               value=grab_elements(listresult, 3, as.numeric(NA)),
               SE=grab_elements(listresult, 4, as.numeric(NA)),
               stringsAsFactors=FALSE)
}
