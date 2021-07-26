## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(btabler)

## -----------------------------------------------------------------------------
df <- data.frame(name = c("", "Row 1", "Row2"),
                 out_t = c("Total", "t1", "t1"),
                 out_1 = c("Group 1", "g11", "g12"), 
                 out_2 = c("Group 2", "g21", "g22"))

## -----------------------------------------------------------------------------
btable(df, nhead = 1, nfoot = 0, caption = "Table1")

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::include_graphics("fig/basic.png")

## ---- eval = FALSE------------------------------------------------------------
#  use_btabletemplate("report")             # creates report.Rmd in the working directory
#  use_btabletemplate("report", "Rnw")      # creates report.Rnw in the working directory
#  use_btabletemplate("code/report", "Rnw") # creates report.Rnw in the code directory

## ----nhead, echo = TRUE, results='asis'---------------------------------------
df <- data.frame(name = c("", "", "Row 1", "Row2"),
                 out_t = c("Total", "mean (sd)", "t1", "t1"),
                 out_1 = c("Group 1", "mean (sd)", "g11", "g12"),
                 out_2 = c("Group 2", "mean (sd)", "g21", "g22"))
btable(df, nhead = 2, nfoot = 0, caption = "Table1")

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::include_graphics("fig/header.png")

## ----head_it, echo = TRUE, results='asis'-------------------------------------
btable(df, nhead = 2, nfoot = 0, caption = "Table1", 
       head_it = NA)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::include_graphics("fig/head_it.png")

## ----aggregate, echo = TRUE, results='asis'-----------------------------------
btable(df, nhead = 2, nfoot = 0, caption = "Table1", 
       head_it = NA, aggregate = FALSE)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::include_graphics("fig/aggregate.png")

## ----footer, echo = TRUE, results='markup', eval = FALSE----------------------
#  df <- data.frame(name = c("", "Row 1", "Row2", "*Footer"),
#                   out_t = c("Total", "t1", "t1", ""),
#                   out_1 = c("Group 1", "g11", "g12", ""),
#                   out_2 = c("Group 2", "g21", "g22", ""))
#  btable(df, nhead=1, nfoot=1, caption="Table1",
#         rulelength = "6cm")

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("fig/footer.png")

## ----aligntot, echo = TRUE, eval = FALSE--------------------------------------
#  btable(df, nhead = 1, nfoot = 0, caption = "Table1", aligntot = "lccc")

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("fig/align.png")

## ----aligntot_width, echo = TRUE, eval = TRUE, results='asis', warning = FALSE----
btable(df, nhead = 1, nfoot = 0, 
       caption = "Table1", 
       aligntot = "P{3cm}P{1.5cm}P{1.5cm}P{1.5cm}")

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::include_graphics("fig/customcols.png")

