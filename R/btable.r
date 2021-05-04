#************************************#
#* btable function:
#* Wrapper for xtable to produce latex tables
#* Author: Lukas Buetikofer
#* Date created: January 2017
#* Last update: July 2020
#* **********************************#

#' btable
#'
#' btable is a wrapper for xtable and produces tables in latex format.
#'
#' Required arguments are a data.frame with the table (dat), the number of header and footer
#' lines (nhead, nfoot) and a caption for the table.
#'
#' @param dat				dataframe
#' @param nhead				number of header rows
#' @param nfoot				number of footer rows
#' @param caption			caption of table
#' @param label				label of table for referncing in latex
#' @param alignp			optional width of first column, to be entered with unit, e.g. "2cm"
#' @param aligntot			alignment of all columns, as string using latex syntax, e.g. "lccc"
#' @param alignh1			alignment of header of the first column (all other headers are centered)
#' @param nnewline			if given, a line break will be introduced for the first column before nnewline letters
#'							at a space (if possible)
#' @param indent			indent of line break
#' @param hlines			additional horizontal lines after specified rows
#' @param fonts1			font size of text, 8 by default
#' @param fonts2			font size of row, 12 by default
#' @param rulelength		optional width of footer
#' @param head_it			number of the header rows to be shown in italic, NA indicates none
#' @param head_bf			number of the header rows to be shown in bold, NA indicates none
#' @param foot_it			number of the footer rows to be shown in italic, NA indicates none
#' @param foot_bf       	number of the footer rows to be shown in bold, NA indicates none
#' @param tab.env			tabular environment, "long" or "float", use float to suppress breaking across pages
#' @param table.placement	table placement if tab.env==float, contain only elements of {"h","t","b","p","!","H"},
#'							default value is "ht".
#' @param middle_sep		empty_column in table
#' @param aggregate			aggregation of header names TRUE/FALSE
#' @param rephead			repeating header after page break
#' @param mergerow			merge indicated row, show only first entry
#' @param sfile				sanitizing file for latex, dataframe with two columns, pattern and replacement
#' @param print				logical, indicates whether table should be printed, TRUE by default
#' @param comment				logical, indicates whether xtable should print it's comment, FALSE by default
#' @param ...				further arguments passed to print.xtable()
#'
#' @return	table in latex format
#'
#' @export
#'
#' @importFrom xtable xtable
#' @importFrom utils read.csv
#'
#' @examples
#' df<-data.frame(name=c("","Row 1","Row2"),out_t=c("Total","t1","t1"),
#'     out_1=c("Group 1","g11","g12"),out_2=c("Group 2","g21","g22"))
#' btable(df,nhead=1,nfoot=0,caption="Table1")
#' btable(df,nhead=1,nfoot=0,caption="Table1",aligntot="llll")
#'
#' #two header lines
#' df<-data.frame(name=c("","","Row 1","Row2"),out_t=c("Total","mean (sd)","t1","t1"),
#'     out_1=c("Group 1","mean (sd)","g11","g12"),out_2=c("Group 2","mean (sd)","g21","g22"))
#' btable(df,nhead=2,nfoot=0,caption="Table1")
#' btable(df,nhead=2,nfoot=0,caption="Table1",head_it=NA)
#' btable(df,nhead=2,nfoot=0,caption="Table1",head_it=NA,aggregate=FALSE)
#'
#' #footer
#' df<-data.frame(name=c("","Row 1","Row2","*Footer"),out_t=c("Total","t1","t1",""),
#'     out_1=c("Group 1","g11","g12",""),out_2=c("Group 2","g21","g22",""))
#' btable(df,nhead=1,nfoot=1,caption="Table1")
#'
#' #floating table, no page break within table
#' df<-data.frame(name=c("","Row 1","Row2"),out_t=c("Total","t1","t1"),
#'     out_1=c("Group 1","g11","g12"),out_2=c("Group 2","g21","g22"))
#' btable(df,nhead=1,nfoot=1,caption="Table1",tab.env="float",table.placement="H")
#'
#' #save table and print later
#' df<-data.frame(name=c("","Row 1","Row2"),out_t=c("Total","t1","t1"),
#'     out_1=c("Group 1","g11","g12"),out_2=c("Group 2","g21","g22"))
#' saved_table<-btable(df,nhead=1,nfoot=1,caption="Table1",print=FALSE)
#' cat(saved_table)
#'
btable<-function(dat,
                 nhead,
                 nfoot,
                 caption,
                 label=NULL,
                 alignp=NA,
                 aligntot=NA,
                 alignh1="l",
                 nnewline=0,
                 indent=1,
                 hlines=NA,
                 fonts1=8,
                 fonts2=12,
                 rulelength=NULL,
                 head_it=c(2),
                 head_bf=NA,
                 foot_it=NULL,
                 foot_bf=NA,
                 tab.env="long",
                 table.placement="ht",
                 middle_sep=NA,
                 aggregate=TRUE,
                 rephead=TRUE,
                 mergerow=NA,
                 sfile="",
                 print=TRUE,
                 comment = FALSE,
                 ...) {


	#load data

	dat<-apply(dat,2,as.character)

	#prepare footers:
	if (nfoot>0) {
		subs<-numeric(0)

		if (sum(!is.null(foot_it))==0) {
			foot_it<-1:nfoot
		}

		for (i in 1:nfoot) {

			hfont<-c(i %in% foot_it, i %in% foot_bf)
			if (sum(hfont)==0) {
				subi<-dat[(nrow(dat)-nfoot+i),1]
			}
			if (hfont[1]==TRUE & hfont[2]==FALSE) {
				subi<-paste0("\\textit{",dat[(nrow(dat)-nfoot+i),1],"}")
			}
			if (hfont[1]==FALSE & hfont[2]==TRUE) {
				subi<-paste0("\\textbf{",dat[(nrow(dat)-nfoot+i),1],"}")
			}
			if (sum(hfont)==2) {
				subi<-paste0("\\textit{\\textbf{",dat[(nrow(dat)-nfoot+i),1],"}}")
			}

			subs<-append(subs,subi)
		}
		subs<-sf(subs,sfile=sfile)
		dat<-dat[1:(nrow(dat)-nfoot),]
	}

	#for pretty separation:

	if (nnewline>0) {
		lw<-dat[,1][nchar(dat[,1])>nnewline]
		sp<-strsplit(lw," ")
		tor<-lapply(sp,function(x) newline(x,nmax=nnewline,indent=indent))
		dat[,1][nchar(dat[,1])>nnewline]<-unlist(tor)
		dat<-data.frame(dat)
	}


	#prepare headers:

	spc<-numeric(0)
	if (nhead>0) {
		for (h in 1:nhead) {

			hfont<-c(h %in% head_it, h %in% head_bf)

			head1<-dat[h,]
			uh<-unique(head1)
			ms<-match(head1,uh)
			msum<-numeric(0)
			m<-1
			for (i in 2:length(head1)) {
				if (!is.na(head1[i]) & !is.na(head1[i-1]) & head1[i]==head1[i-1]) {
					m<-m+1
				} else {
				msum<-append(msum,m)
				m<-1
				}
				if (i==length(head1)) {
					msum<-append(msum,m)
				}
			}
			hft<-numeric(0)
			for (i in 1:length(msum)) {
				msi<-msum[i]
				ot<-head1[1+sum(msum[0:(i-1)])]
				horal<-ifelse(i==1,alignh1,"c")
				if (sum(hfont)==0) {
					ft<-paste0("\\multicolumn{",msum[i],"}{",horal,"}{",ot,"}")
				}
				if (hfont[1]==TRUE & hfont[2]==FALSE) {
					ft<-paste0("\\multicolumn{",msum[i],"}{",horal,"}{\\textit{",ot,"}}")
				}
				if (hfont[1]==FALSE & hfont[2]==TRUE) {
					ft<-paste0("\\multicolumn{",msum[i],"}{",horal,"}{\\textbf{",ot,"}}")
				}
				if (sum(hfont)==2) {
					ft<-paste0("\\multicolumn{",msum[i],"}{",horal,"}{\\textit{\\textbf{",ot,"}}}")
				}

				hft<-append(hft,ft)
			}
			if (aggregate==TRUE) {
				dat[h,]<-c(hft,rep("",ncol(dat)-length(hft)))
				sp1<-paste0(paste0(rep("&",ncol(dat)-length(hft)),collapse="  "),"  \\")
				spc<-append(spc,list(sp1))
			} else {
				if (hfont[1]==TRUE & hfont[2]==FALSE) {
					dat[h,]<-paste0("\\textit{",dat[h,],"}")
				}
				if (hfont[1]==FALSE & hfont[2]==TRUE) {
					dat[h,]<-paste0("\\textbf{",dat[h,],"}")
				}
				if (sum(hfont)==2) {
					dat[h,]<-paste0("\\textit{\\textbf{",dat[h,],"}}")
				}
			}
		}
	}

	#alignment:

	if (!is.na(alignp)) {
		aligns<-paste0(c("l","p{",alignp,"}",rep("c",ncol(dat)-1)),collapse="")
	} else {
		aligns<-paste0(c("ll",rep("c",ncol(dat)-1)),collapse="")
	}
	if (!is.na(aligntot)) {
		aligns<-paste0("l",aligntot,collapse="")
	}

	#merge rows
	if (sum(!is.na(mergerow))!=0) {
		for (r in 1:length(mergerow)) {
			dat[mergerow[r],1]<-paste0("\\multicolumn{",ncol(dat),"}{l}{",dat[mergerow[r],1],"}")
			dat[mergerow[r],2:ncol(dat)]<-rep("",ncol(dat)-1)
		}
	}

	#table
	xt<-xtable(dat, caption=caption,align=aligns,label=label)

	if (tab.env=="long") {
		float<-FALSE
		tabenv<-"longtable"
	}
	if (tab.env=="float") {
		float<-TRUE
		tabenv<-"tabular"
		rephead<-FALSE
	}

	if (nfoot==0) {

		#if no footers:

		#hlines
		if (!is.na(hlines[1])) {
			nl<-hlines
			if (nhead==0) {hlinea<-c(-1,nl,nrow(xt))} else {hlinea<-c(-1,nl,nhead,nrow(xt))}
		} else {
			if (nhead==0) {hlinea<-c(-1,nrow(xt))} else {hlinea<-c(-1,nhead,nrow(xt))}
		}

		#addtorow for repeating headers
		if (rephead) {
			hlinea<-hlinea[hlinea!=nhead]
			addtorow<-list()
			addtorow$pos<-list()
			addtorow$pos[[1]]<-c(nhead)
			pas1<-ifelse(nhead==0,"","\\hline")
			
			if (is.null(rulelength)) {
				psubr<-paste0("\\multicolumn{",ncol(dat),"}{l}{\\textit{continued on next page}} \n")
			} else {
				psubr<-paste0("\\multicolumn{",ncol(dat),"}{L{",rulelength,"}}{\\textit{continued on next page}} \n")
			}
	
			addtorow$command<-c(paste(pas1," \n",
				" \\endhead \n",
				" \\hline \n",
				psubr,
				" \\endfoot \n",
				" \\endlastfoot \n",sep=""))
		} else {
			addtorow<-NULL
		}

	} else {

		#if footers:

		#hlines
		if (!is.na(hlines[1])) {
			nl<-hlines
			if (nhead==0) {hlinea<-c(-1,nl)} else {hlinea<-c(-1,nhead,nl)}
		} else {
			if (nhead==0) {hlinea<-c(-1)} else {hlinea<-c(-1,nhead)}
		}

		#addtorow for repeating headers
		if (rephead) {
			hlinea<-hlinea[hlinea!=nhead]
			addtorow<-list()
			addtorow$pos<-list()
			addtorow$pos[[1]]<-c(nhead)
			pas1<-ifelse(nhead==0,"","\\hline")
			
			if (is.null(rulelength)) {
				psubr<-paste0("\\multicolumn{",ncol(dat),"}{l}{\\textit{continued on next page}} \n")
			} else {
				psubr<-paste0("\\multicolumn{",ncol(dat),"}{L{",rulelength,"}}{\\textit{continued on next page}} \n")
			}
			
			addtorow$command<-c(paste(pas1," \n",
				" \\endhead \n",
				" \\hline \n",
				psubr,
				" \\endfoot \n",
				" \\endlastfoot \n",sep=""))

			ari<-2
		} else {
			addtorow<-list()
			addtorow$pos<-list()
			ari<-1
		}

		#add footers via addtorow
		if (nfoot>0) {
			if (is.null(rulelength)) {
				psubs<-paste0("\\specialrule{1pt}{1pt}{1pt} \\multicolumn{",
					ncol(dat),"}{l}{",subs[1],"} \\\\")	
			} else {
				psubs<-paste0("\\specialrule{1pt}{1pt}{1pt} \\multicolumn{",
					ncol(dat),"}{L{",rulelength,"}}{",subs[1],"} \\\\")
			}		
			addtorow$pos[[ari]]<-nrow(xt)
			addtorow$command[ari]<-psubs

			if (nfoot>1) {
				for (i in 2:nfoot) {
					if (is.null(rulelength)) {
						psub<-paste0("\\multicolumn{",ncol(dat),"}{l}{",subs[i],"} \\\\")
					} else {
						psub<-paste0("\\multicolumn{",ncol(dat),"}{L{",rulelength,"}}{",subs[i],"} \\\\")
					}	
					psubs<-c(psubs,psub)
					addtorow$pos[[i-1+ari]]<-nrow(xt)
					addtorow$command[i-1+ari]<-psub
				}
			}
		}
	}

	#ptint xtable
	xtp<-print(xt,include.rownames=FALSE,include.colnames=FALSE,sanitize.text.function=sf,
		 booktabs = TRUE,hline.after=hlinea,
		 caption.placement = "top", latex.environments = "center",
		 table.placement=table.placement,
		 print.results=FALSE,floating=float,
		 tabular.environment = tabenv,
		 size=paste0("\\fontsize{",fonts1,"pt}{",fonts2,"pt}\\selectfont"),
		 add.to.row = addtorow, comment = comment, ...)


	#replace empty columns at the end of headers
	if (aggregate==TRUE) {
		if (nhead==1) {
			xtp<-gsub(spc[[1]],"  \\",xtp,fixed=TRUE)
		}

		if (nhead>1) {
			if (nchar(spc[[1]])>nchar(spc[[2]])) {
				xtp<-gsub(paste0("} ",spc[[1]]),"}  \\",xtp,fixed=TRUE)
			} else {
				xtp<-sub(spc[[1]],"  \\",xtp,fixed=TRUE)  #sub for cimifemin, gsub for others??
			}
			for (h in 2:nhead) {
				xtp<-gsub(spc[[h]],"  \\",xtp,fixed=TRUE)
			}
		}

		if (!is.na(middle_sep)) {
			xtp<-gsub("&    \\","  \\",xtp,fixed=TRUE)
		}
	}

	#replace empty columns in upon merge of columns
	if (sum(!is.na(mergerow))!=0) {
		for (r in 1:length(mergerow)) {
			xtp<-sub(paste0(paste0(rep("&  ",ncol(dat)-1),collapse=""),"\\"),"\\",xtp,fixed=TRUE)
		}
	}

	if (print==FALSE) {
		return(xtp)
	} else {
		cat(xtp)
	}
}



