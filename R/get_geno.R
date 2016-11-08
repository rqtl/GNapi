#' Get genotype data
#'
#' Get genotype data for a given cross
#'
#' @param cross Cross name as a single character string
#' @param url URL for GeneNetwork API
#'
#' @return Data frame with genotypes; rows are markers, columns are strains
#'
#' @importFrom httr GET content stop_for_status
#' @importFrom readr read_csv
#' @export
#'
#' @examples
#' get_geno("BXD")
get_geno <-
    function(cross, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # call info_cross to determine species
    info <- info_cross(cross, url)
    if(!("species" %in% names(info)))
        stop("Can't find species for cross ", cross)
    species <- info$species

    # now call to get genotypes
    result <- httr::GET(paste0(url, "genotype/", species, "/",
                               cross, "/geno.csv"))
    stop_for_status(result)

    df <- httr::content(result, encoding="utf-8", col_types=list(.default="c"))
    df <- as.data.frame(df)
    rownames(df) <- df[,1]
    df[,-1,drop=FALSE]
}
