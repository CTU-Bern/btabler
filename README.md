<!-- README.md is generated from README.Rmd. Please edit that file -->

btabler
=======

[![](https://img.shields.io/badge/dev%20version-0.0.1.9000-blue.svg)](https://github.com/CTU-Bern/btabler)
[![R-CMD-fullcheck](https://github.com/CTU-Bern/btabler/actions/workflows/R-CMD-full.yaml/badge.svg)](https://github.com/CTU-Bern/btabler/actions/workflows/R-CMD-full.yaml)

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

    ## % latex table generated in R 4.0.5 by xtable 1.8-4 package
    ## % Mon May  3 07:18:41 2021
    ## \begingroup\fontsize{8pt}{12pt}\selectfont
    ## \begin{longtable}{lccc}
    ## \caption{Table1} \\ 
    ##   \toprule
    ##  \multicolumn{1}{l}{} & \multicolumn{1}{c}{Total} & \multicolumn{1}{c}{Group 1} & \multicolumn{1}{c}{Group 2} \\ 
    ##    \hline 
    ##  \endhead 
    ##  \hline 
    ## \multicolumn{4}{L{15cm}}{\textit{continued on next page}} 
    ##  \endfoot 
    ##  \endlastfoot 
    ## Row 1 & t1 & g11 & g21 \\ 
    ##   Row2 & t1 & g12 & g22 \\ 
    ##    \bottomrule
    ## \end{longtable}
    ## \endgroup

`btable` returns the latex code for the table you passed.

Alignement can be changed via the `aligntot` argument:

    btable(df,nhead=1,nfoot=0,caption="Table1",aligntot="llll")

    ## % latex table generated in R 4.0.5 by xtable 1.8-4 package
    ## % Mon May  3 07:18:41 2021
    ## \begingroup\fontsize{8pt}{12pt}\selectfont
    ## \begin{longtable}{llll}
    ## \caption{Table1} \\ 
    ##   \toprule
    ##  \multicolumn{1}{l}{} & \multicolumn{1}{c}{Total} & \multicolumn{1}{c}{Group 1} & \multicolumn{1}{c}{Group 2} \\ 
    ##    \hline 
    ##  \endhead 
    ##  \hline 
    ## \multicolumn{4}{L{15cm}}{\textit{continued on next page}} 
    ##  \endfoot 
    ##  \endlastfoot 
    ## Row 1 & t1 & g11 & g21 \\ 
    ##   Row2 & t1 & g12 & g22 \\ 
    ##    \bottomrule
    ## \end{longtable}
    ## \endgroup

Where there are multiple header lines, the `nhead` argument can be used
and any neighboring cells in those first rows will be merged.

    df<-data.frame(name=c("","","Row 1","Row2"),out_t=c("Total","mean (sd)","t1","t1"),
        out_1=c("Group 1","mean (sd)","g11","g12"),out_2=c("Group 2","mean (sd)","g21","g22"))
    btable(df,nhead=2,nfoot=0,caption="Table1")

    ## % latex table generated in R 4.0.5 by xtable 1.8-4 package
    ## % Mon May  3 07:18:41 2021
    ## \begingroup\fontsize{8pt}{12pt}\selectfont
    ## \begin{longtable}{lccc}
    ## \caption{Table1} \\ 
    ##   \toprule
    ##  \multicolumn{1}{l}{} & \multicolumn{1}{c}{Total} & \multicolumn{1}{c}{Group 1} & \multicolumn{1}{c}{Group 2} \\ 
    ##   \multicolumn{1}{l}{\textit{}} & \multicolumn{3}{c}{\textit{mean (sd)}}   \\ 
    ##    \hline 
    ##  \endhead 
    ##  \hline 
    ## \multicolumn{4}{L{15cm}}{\textit{continued on next page}} 
    ##  \endfoot 
    ##  \endlastfoot 
    ## Row 1 & t1 & g11 & g21 \\ 
    ##   Row2 & t1 & g12 & g22 \\ 
    ##    \bottomrule
    ## \end{longtable}
    ## \endgroup

`btable` italicizes the second row of the header by default. This can be
changed via the `head_it` argument:

    btable(df,nhead=2,nfoot=0,caption="Table1",head_it=NA)

    ## % latex table generated in R 4.0.5 by xtable 1.8-4 package
    ## % Mon May  3 07:18:41 2021
    ## \begingroup\fontsize{8pt}{12pt}\selectfont
    ## \begin{longtable}{lccc}
    ## \caption{Table1} \\ 
    ##   \toprule
    ##  \multicolumn{1}{l}{} & \multicolumn{1}{c}{Total} & \multicolumn{1}{c}{Group 1} & \multicolumn{1}{c}{Group 2} \\ 
    ##   \multicolumn{1}{l}{} & \multicolumn{3}{c}{mean (sd)}   \\ 
    ##    \hline 
    ##  \endhead 
    ##  \hline 
    ## \multicolumn{4}{L{15cm}}{\textit{continued on next page}} 
    ##  \endfoot 
    ##  \endlastfoot 
    ## Row 1 & t1 & g11 & g21 \\ 
    ##   Row2 & t1 & g12 & g22 \\ 
    ##    \bottomrule
    ## \end{longtable}
    ## \endgroup

Likewise, aggregation of the header can also be turned of

    btable(df,nhead=2,nfoot=0,caption="Table1",head_it=NA,aggregate=FALSE)

    ## % latex table generated in R 4.0.5 by xtable 1.8-4 package
    ## % Mon May  3 07:18:41 2021
    ## \begingroup\fontsize{8pt}{12pt}\selectfont
    ## \begin{longtable}{lccc}
    ## \caption{Table1} \\ 
    ##   \toprule
    ##   & Total & Group 1 & Group 2 \\ 
    ##    & mean (sd) & mean (sd) & mean (sd) \\ 
    ##    \hline 
    ##  \endhead 
    ##  \hline 
    ## \multicolumn{4}{L{15cm}}{\textit{continued on next page}} 
    ##  \endfoot 
    ##  \endlastfoot 
    ## Row 1 & t1 & g11 & g21 \\ 
    ##   Row2 & t1 & g12 & g22 \\ 
    ##    \bottomrule
    ## \end{longtable}
    ## \endgroup

Footers can also be added

    df<-data.frame(name=c("","Row 1","Row2","*Footer"),out_t=c("Total","t1","t1",""),
        out_1=c("Group 1","g11","g12",""),out_2=c("Group 2","g21","g22",""))
    btable(df,nhead=1,nfoot=1,caption="Table1")

    ## % latex table generated in R 4.0.5 by xtable 1.8-4 package
    ## % Mon May  3 07:18:41 2021
    ## \begingroup\fontsize{8pt}{12pt}\selectfont
    ## \begin{longtable}{lccc}
    ## \caption{Table1} \\ 
    ##   \toprule
    ##  \multicolumn{1}{l}{} & \multicolumn{1}{c}{Total} & \multicolumn{1}{c}{Group 1} & \multicolumn{1}{c}{Group 2} \\ 
    ##    \hline 
    ##  \endhead 
    ##  \hline 
    ## \multicolumn{4}{L{15cm}}{\textit{continued on next page}} 
    ##  \endfoot 
    ##  \endlastfoot 
    ## Row 1 & t1 & g11 & g21 \\ 
    ##   Row2 & t1 & g12 & g22 \\ 
    ##    \specialrule{1pt}{1pt}{1pt} \multicolumn{4}{L{15cm}}{\textit{*Footer}} \\\end{longtable}
    ## \endgroup
