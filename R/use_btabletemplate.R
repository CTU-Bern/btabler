#' Open a basic template suitable for use with btable
#'
#' @param name name to save the file under
#' @param fmt character defining format (\code{Rmd} or \code{Rnw} are accepted)
#' @param ... other options passed to \code{\link[usethis]{use_template}}
#' @param open logical, whether to open the file
#'
#' @return (by default) saves and opens a script of the chosen format
#' @export
#'
#' @examples
#' # Rmd file
#' use_btabletemplate("foo")
#' # Rnw file
#' use_btabletemplate("foo", fmt = "Rnw")
use_btabletemplate <- function(name
                               , fmt = c("Rmd", "Rnw")
                               , ...
                               , open = TRUE
                               ) {

  fmt <- match.arg(fmt)

  # add file extension
  if(!grepl(paste0(fmt, "$"), name)) name <- paste(name, fmt, sep = ".")


  usethis::use_template(template = paste0("template.", fmt)
                        , save_as = name
                        , package = "btabler"
                        , open = open
                        , ...
                        )

}
