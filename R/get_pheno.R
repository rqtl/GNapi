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

#' List probesets for a dataset, within some range
#'
#' List probesets for a dataset, within some range
#'
#' @param dataset Name or ID for dataset as a single character string
#' @param start Starting probeset
#' @param stop Ending probeset
#' @param url URL for GeneNetwork API
#'
#' @return Data frame with probeset info
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' list_probesets("HC_U_0304_R", 100, 101)
list_probesets <-
    function(dataset, start=NULL, stop=NULL, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # dataset should be a single character string
    stopifnot(!is.null(dataset), length(dataset) == 1,  is.character(dataset))

    # check that dataset is "probeset" type
    info <- info_dataset(dataset, url)
    if(!("dataset" %in% names(info)) || info$dataset != "probeset")
        stop(dataset, " not of probeset type")

    url <- paste0(url, "phenotypes/", dataset, ".json")
    result <- httr::GET(url, list(start=start, stop=stop))
    listresult <- httr::content(result)
    httr::stop_for_status(result)

    listresult
}

#' Get probeset data
#'
#' Get phenotype data for a given probeset within a dataset
#'
#' @param dataset Name or ID for dataset as a single character string
#' @param probeset Name of probeset
#' @param url URL for GeneNetwork API
#'
#' @return Data frame with strain id, name, phenotype value, and standard error
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' get_probeset("HC_U_0304_R", "104617_at")
#' get_probeset("HC_M2_0606_P", "1443823_s_at")
get_probeset <-
    function(dataset, probeset, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # dataset should be a single character string
    stopifnot(!is.null(dataset), length(dataset) == 1,  is.character(dataset))

    # probeset should be a single character string, too
    stopifnot(!is.null(probeset), length(probeset) == 1,  is.character(probeset))

    # check that dataset is "probeset" type
    info <- info_dataset(dataset, url)
    if(!("dataset" %in% names(info)) || info$dataset != "probeset")
        stop(dataset, " not of probeset type")

    url <- paste0(url, "trait/", dataset, "/", probeset, ".json")
    result <- httr::GET(url)
    listresult <- httr::content(result)
    httr::stop_for_status(result)

    data.frame(id=grab_elements(listresult, 1, as.numeric(NA)),
               strain=grab_elements(listresult, 2, as.character(NA)),
               value=grab_elements(listresult, 3, as.numeric(NA)),
               SE=grab_elements(listresult, 4, as.numeric(NA)),
               stringsAsFactors=FALSE)
}
