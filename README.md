<!-- README.md is generated from README.Rmd. Please edit that file -->

btabler <img src='man/figures/sticker.png' align="right" height="200">
======================================================================

[![](https://img.shields.io/badge/dev%20version-0.0.1.9004-blue.svg)](https://github.com/CTU-Bern/btabler)
[![R-CMD-fullcheck](https://github.com/CTU-Bern/btabler/actions/workflows/R-CMD-full.yaml/badge.svg)](https://github.com/CTU-Bern/btabler/actions/workflows/R-CMD-full.yaml)

`btabler` is a package which adds wraps the `xtable` package, adding
additional functionality such as merging header columns.

Note that `btabler` does not produce HTML tables. If using `.Rmd`,
`output` should be `pdf_document`.

Example usage
-------------

### Installing the package

The package can be installed from
[github](https://github.com/CTU-Bern/btabler) via the `remotes` package

    # install.packages("remotes")
    remotes::install_github("CTU-Bern/btabler")

Note that `remotes` treats any warnings (e.g. that a certain package was
built under a different version of R) as errors. If you see such an
error, run the following line and try again:

    Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS = "true")

### Using the package

Load it as usual:

    library(btabler)

Create your tables via whatever means and pass them to the `btable`
function:

    df <- data.frame(name = c("", "Row 1", "Row2"),
                     out_t = c("Total", "t1", "t1"),
                     out_1 = c("Group 1", "g11", "g12"), 
                     out_2 = c("Group 2", "g21", "g22"))
    btable(df, nhead = 1, nfoot = 0, caption = "Table1")

`btable` returns the latex code for the table you passed, which can be
easily used with sweave to create tables in reports.

![](man/figures/basic.png)

As an example for further modifications, column widths can also be
modified using the `aligntot` argument:

    btable(df, nhead = 1, nfoot = 0, 
           caption = "Table1", 
           aligntot = "p{3cm}p{1.5cm}p{1.5cm}p{1.5cm}")

![](man/figures/aligntot_width.png)

See the vignette for further examples of using `btabler`

    vignette("btabler")

Requirements for the header
---------------------------

`btabler` tables are only interpretable by LaTeX when a few packages are
loaded. It is recommended to place the following code in the header of
your `.tex` file or `.Rmd`

    # .tex
    \usepackage{longtable}
    \usepackage{booktabs}
    \usepackage{float}
    \usepackage{array}

    # .Rmd
    header-includes:
      - \usepackage{longtable}
      - \usepackage{booktabs}
      - \usepackage{float}
      - \usepackage{array}

Other things like custom column types can also be added to the header
(see the vignette for an example)

    vignette("btabler")

`btabler` provides basic templates in `Rmd` and `Rnw` formats:

    use_btabletemplate("filename", "Rmd")
