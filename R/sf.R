#sanitizing function:

sf<-function(str,sfile="") {
  s1<-gsub(pattern="    ",     replacement="\\\\hspace*{0.2cm}",x=as.character(str))
  s1<-gsub(pattern="  ",       replacement="\\\\hspace*{0.1cm}",x=as.character(s1))
  s1<-gsub(pattern="#",        replacement="\\\\#",x=as.character(s1))
  s1<-gsub(pattern="&",        replacement="\\\\&",x=as.character(s1))
  s1<-gsub(pattern="_",        replacement="\\\\_",x=as.character(s1))
  s1<-gsub(pattern="\u2020",   replacement="$\\\\dagger$",x=as.character(s1))
  s1<-gsub(pattern="\u2021",   replacement="$\\\\ddagger$",x=as.character(s1))
  s1<-gsub(pattern="%",        replacement="\\\\%",x=as.character(s1))
  s1<-gsub(pattern="\u00E4",   replacement='\\\\"a',x=as.character(s1))
  s1<-gsub(pattern="\u00C4",   replacement='\\\\"A',x=as.character(s1))
  s1<-gsub(pattern="\u00E2",   replacement="\\\\^{a}",x=as.character(s1))
  s1<-gsub(pattern="\u00E0",   replacement="\\\\`{a}",x=as.character(s1))
  s1<-gsub(pattern="\u00F6",   replacement='\\\\"o',x=as.character(s1))
  s1<-gsub(pattern="\u00D6",   replacement='\\\\"O',x=as.character(s1))
  s1<-gsub(pattern="\u00F4",   replacement="\\\\^{o}",x=as.character(s1))
  s1<-gsub(pattern="\u00F3",   replacement="\\\\'{o}",x=as.character(s1))
  s1<-gsub(pattern="\u00D3",   replacement="\\\\'{O}",x=as.character(s1))
  s1<-gsub(pattern="\u00D2",   replacement="\\\\`{O}",x=as.character(s1))
  s1<-gsub(pattern="\u00FC",   replacement='\\\\"u',x=as.character(s1))
  s1<-gsub(pattern="\u00DC",   replacement='\\\\"U',x=as.character(s1))
  s1<-gsub(pattern="\u00E7",   replacement='\\\\c{c}',x=as.character(s1))
  s1<-gsub(pattern="\u00E9",   replacement="\\\\'{e}",x=as.character(s1))
  s1<-gsub(pattern="\u00E8",   replacement="\\\\`{e}",x=as.character(s1))
  s1<-gsub(pattern="\u00EA",   replacement="\\\\^{e}",x=as.character(s1))
  s1<-gsub(pattern="\u00BAC",  replacement="\\\\textcelsius",x=as.character(s1))
  s1<-gsub(pattern="\u00BA",   replacement="$^\\\\circ$",x=as.character(s1))
  # s1<-gsub(pattern="°C",       replacement="\\\\textcelsius",x=as.character(s1))
  # s1<-gsub(pattern="°",        replacement="$^\\\\circ$",x=as.character(s1))
  s1<-gsub(pattern=">=",       replacement="$\\\\geq$",x=as.character(s1))
  s1<-gsub(pattern="<=",       replacement="$\\\\leq$",x=as.character(s1))
  s1<-gsub(pattern="\u00B1",   replacement="$\\\\pm$",x=as.character(s1))
  s1<-gsub(pattern="\u03BC",   replacement="{\\\\textmu}",x=as.character(s1))
  # s1<-gsub(pattern="µ",        replacement="{\\\\textmu}",x=as.character(s1))
  s1<-gsub(pattern="\u00A7",   replacement="{\\\\S}",x=as.character(s1))
  s1<-gsub(pattern="\u00B6",   replacement="{\\\\P}",x=as.character(s1))
  
  if (file.exists(sfile)) {
    sftempl<-read.csv(sfile,header=TRUE,encoding="UTF-8",colClasses = "character")
    for (i in 1:nrow(sftempl)) {
      s1<-gsub(pattern=sftempl[i,1], replacement=sftempl[i,2],x=as.character(s1),fixed=TRUE)
    }
  }
  s1
}
