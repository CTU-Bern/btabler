
dat0 <- data.frame(out_t = c("Total", "t1", "t1"))
dat1 <- data.frame(c1 = c( "","Var1", "Var2"),c2=c("Group1","10","10"),c3=c("Group2","10","10"))
dat2 <- data.frame(c1 = c("","","Var1", "Var2"),c2=c("Group1","mean (sd)","10 (3)","10 (3)"),
	c3=c("Group2","mean (sd)","10 (3)","10 (3)"))

	
test_that("runs through", {
	expect_error(r1<-btable(dat0, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE), NA)
	expect_error(r2<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE), NA)
	expect_error(r3<-btable(dat2, nhead = 2, nfoot = 0, caption = "Table1",print=FALSE), NA)
})

test_that("aggregates headers", {
	r2<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE)
	r3<-btable(dat2, nhead = 2, nfoot = 0, caption = "Table1",print=FALSE)
	expect_true(grepl("multicolumn{2}",r3,fixed=TRUE))
	expect_false(grepl("multicolumn{2}",r2,fixed=TRUE))
})

test_that("column alignment works", {
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",
		aggregate=FALSE,print=FALSE),NA)
	expect_true(grepl("lcc",r0,fixed=TRUE))	
	
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",alignp="2cm",
		aggregate=FALSE,print=FALSE),NA)
	expect_true(grepl("{p{2cm}cc",r0,fixed=TRUE))	
	
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE),NA)
	expect_true(grepl("multicolumn{1}{l}{}",r0,fixed=TRUE))
	
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",alignh1="c",print=FALSE),NA)
	expect_true(grepl("multicolumn{1}{c}{}",r0,fixed=TRUE))
	
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",aligntot="clc",
		aggregate=FALSE,print=FALSE),NA)
	expect_true(grepl("clc",r0,fixed=TRUE))	
	
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",aligntot="p{1cm}p{2cm}p{2cm}",
		aggregate=FALSE,print=FALSE),NA)
	expect_true(grepl("p{1cm}p{2cm}p{2cm}",r0,fixed=TRUE))
})

test_that("table environment works", {
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE),NA)
	expect_error(r1<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE,rephead=FALSE),NA)
	
	expect_error(r2<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE,tab.env="float"),NA)
	expect_error(r3<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",print=FALSE,tab.env="float",
		table.placement="H"),NA)

	expect_true(grepl("longtable",r0,fixed=TRUE))
	expect_true(grepl("continued on next page",r0,fixed=TRUE))
	
	expect_true(grepl("longtable",r1,fixed=TRUE))
	expect_false(grepl("continued on next page",r1,fixed=TRUE))
	
	expect_false(grepl("longtable",r2,fixed=TRUE))
	expect_false(grepl("continued on next page",r2,fixed=TRUE))
	expect_true(grepl("{table}[ht]",r2,fixed=TRUE))
	
	expect_true(grepl("{table}[H]",r3,fixed=TRUE))
	
})

test_that("throws error", {
	expect_error(btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",aligntot="cc",aggregate=FALSE))
})	


test_that("mergerow works", {
	expect_error(r0<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",mergerow=2,print=FALSE),NA)
	expect_error(r1<-btable(dat1, nhead = 1, nfoot = 0, caption = "Table1",mergerow=c(2,3),print=FALSE),NA)
	
	expect_true(grepl("multicolumn{3}{l}{Var1}",r0,fixed=TRUE))
	expect_false(grepl("multicolumn{3}{l}{Var2}",r0,fixed=TRUE))
	expect_true(grepl("multicolumn{3}{l}{Var1}",r1,fixed=TRUE))
	expect_true(grepl("multicolumn{3}{l}{Var2}",r1,fixed=TRUE))
})	












