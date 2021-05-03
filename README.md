<!-- README.md is generated from README.Rmd. Please edit that file -->

btabler
=======

[![](https://img.shields.io/badge/dev%20version-0.0.1.9000-blue.svg)](https://github.com/CTU-Bern/btabler)
[![R-CMD-fullcheck](https://github.com/CTU-Bern/btabler/actions/workflows/R-CMD-full.yaml/badge.svg)](https://github.com/CTU-Bern/btabler/actions/workflows/R-CMD-full.yaml)

`btabler` is a package which adds wraps the `xtable` package, adding
additional functionality such as merging header columns.

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

Alignment can be changed via the `aligntot` argument. For example, we
could specify that all columns should be left aligned:

    btable(df, nhead = 1, nfoot = 0, caption = "Table1", aligntot = "llll")

![](man/figures/aligntot.png)

Column widths can also be modified using the `aligntot` argument:

    cwidths <- "p{3cm}p{1.5cm}p{1.5cm}p{1.5cm}"

    btable(df, nhead = 1, nfoot = 0, 
           caption = "Table1", 
           aligntot = cwidths, rulelength = "6cm")

![](man/figures/aligntot_width.png)

If the table is does not respect the widths entered in `aligntot`, the
`rulelength` argument can be used to fix the overall table width.

Where there are multiple header lines, the `nhead` argument can be used
and any neighboring cells in those first rows will be merged.

    df <- data.frame(name = c("", "", "Row 1", "Row2"),
                     out_t = c("Total", "mean (sd)", "t1", "t1"),
                     out_1 = c("Group 1", "mean (sd)", "g11", "g12"),
                     out_2 = c("Group 2", "mean (sd)", "g21", "g22"))
    btable(df, nhead = 2, nfoot = 0, caption = "Table1")

`btable` italicizes the second row of the header by default. This can be
changed via the `head_it` argument:

    btable(df, nhead = 2, nfoot = 0, caption = "Table1", head_it = NA)

![](man/figures/head_it.png)

Likewise, aggregation of the header can also be turned of

    btable(df, nhead = 2, nfoot = 0, caption = "Table1", head_it = NA, aggregate = FALSE)

![](man/figures/aggregate.png)

Footers can also be added

    df <- data.frame(name = c("", "Row 1", "Row2", "*Footer"),
                     out_t = c("Total", "t1", "t1", ""),
                     out_1 = c("Group 1", "g11", "g12", ""),
                     out_2 = c("Group 2", "g21", "g22", ""))
    btable(df, nhead=1, nfoot=1, caption="Table1")

![](man/figures/footer.png)

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
    \newcolumntype{L}[1]{>{\raggedright\arraybackslash}m{#1}}
    \newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}
    \newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}}

    # .Rmd
    header-includes:
      - \usepackage{longtable}
      - \usepackage{booktabs}
      - \usepackage{float}
      - \usepackage{array}
      - \newcolumntype{L}[1]{>{\raggedright\arraybackslash}m{#1}}
      - \newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}
      - \newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}}

Note that `btabler` does not produce HTML tables. If using `.Rmd`,
`output` should be `pdf_document`
