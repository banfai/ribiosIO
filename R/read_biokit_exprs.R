#' qRead BioKit expression file into a data.frame
#' 
#' @param filename A BioKit expression file
#' 
#' The function uses an efficient C routine to read BioKit expression files.
#' An Roche NGS expression file is eseentially a tab-delimited file. THe
#' first six columns are mandatory (feature/tag name, multiple mapping
#' RPKM, multiple mapping read count, unique mapping RPKM, unique mapping
#' read count, and multiple mapping proportion). Right to these columns
#' there can be arbitrary numbers of columns appended to annotate the
#' features.

#' In the current output, rows may have different numbers of columns:
#' particularly for features without corresponding items in the
#' annotation file used in the pipeline, their rows will contain the
#' mandatory columns plus one extra column with the value
#' \dQuote{unknown}. This is handled automatically by the function.
#' 
#' @return 
#'  A \code{data.frame} contains both mandatory and additional
#' columns. The first column of the expression file will be used as the
#' row names of the \code{data.frame} object.
#' 
#' @seealso 
#' \code{\link{read_gct}} for reading gct files, a commonly used file format for
#' expression data.

#' @examples
#' biokitExampleFile <- system.file("extdata/biokit_expression_files/biokit-output-1.expression",
#' package="ribiosIO")
#' biokitExprs <- read_biokit_exprs(biokitExampleFile)
#' @export
read_biokit_exprs <- function(filename) {
  filename <- checkfile(filename)
  res <- .Call(C_c_read_biokit_exprs, filename)
  return(res)
}
