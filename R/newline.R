#function for pretty separation

newline<-function(x,nmax=35,indent=1) {
  f2<-function(x,nmax=nmax) {
    w21<-paste(x[cumsum(nchar(x)+1)<=nmax],collapse=" ")
    w22<-paste(x[cumsum(nchar(x)+1)>nmax],collapse=" ")
    c(w21,w22)
  }
  w1<-paste(x[cumsum(nchar(x)+1)<=nmax],collapse=" ")
  w2<-paste(x[cumsum(nchar(x)+1)>nmax],collapse=" ")
  w1c<-w1
  w2c<-w2
  wcoll<-numeric(0)
  while (nchar(w2c)>nmax & w1c!="") {
    sp2<-strsplit(w2c," ")
    w2r<-lapply(sp2,function(x) f2(x,nmax=nmax))
    w2c<-unlist(w2r)[2]
    w1c<-unlist(w2r)[1]
    if (w1c!="") {
      wcoll<-append(wcoll,unlist(w2r)[1])
    }
  }
  if (length(wcoll)!=0) {
    wcoll<-append(wcoll,unlist(w2r)[2])
    w2<-wcoll
  }

  #to add whitespace after linebreak
  if (indent>0) {
    lbl<-strsplit(w1," ")[[1]]
    counter<-1
    while (nchar(lbl[counter])==0) {
      counter<-counter+1
    }
    nws<-counter-1
    ncm<-nws/2/10 + 0.1*indent
    wc<-paste(c(w1,w2),collapse=paste0(" \\newline ","\\hspace*{",ncm,"cm}"))

  } else {

    wc<-paste(c(w1,w2),collapse=" \\newline ")
  }

  wc
}
