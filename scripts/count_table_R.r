genera_tabla_conteos<-function(fnPath,fnExt){
  fnPattern=paste(fnPath, fnExt,"$",sep="",collapse="")
  fnLista_archivos=dir(fnPath, fnExt)
  print(fnLista_archivos)
  fnNomExperimentos = sub(fnExt,'', fnLista_archivos)
  fnTablaConteos = data.frame(matrix(vector(), 0, length(fnLista_archivos)))
  names(fnTablaConteos)<-fnNomExperimentos
  for(i in fnNomExperimentos)
  {
    print(paste(fnPath, i, fnExt, sep = ""))
    fnColExp<-read.delim(paste(fnPath, i, fnExt, sep = ""), header = T,row.names = 1) 
    print(head(fnColExp))
    fnTablaConteos[row.names(fnColExp),i]<-fnColExp[,1]
  }
  fnTablaConteos[is.na(fnTablaConteos)]=0
  fnTablaConteos<-fnTablaConteos[rowSums(fnTablaConteos)>0,]
  return(fnTablaConteos)
}
myPath<-"Path/to/where/the/files/are"
myExt<-".txt"
t_d_c<-genera_tabla_conteos(myPath,myExt)
t_d_c
write.table(t_d_c,"Path/to/where/the/table/will/be/written", sep="\t", quote=F)

names(t_d_c)
