
# BCCC instalar paquete seqinr y usar comando getncbiseq para analizar secuencia de rRNA16s de vibrio 

install.packages("seqinr", repos="http://R-Forge.R-project.org")

library("seqinr")

getncbiseq <- function(accession) {
  require("seqinr") # tener instalado seqinr para que corra
  # Primero encuentre en qué base de datos ACNUC se almacena la accesión:
  dbs <- c("genbank","refseq","refseqViruses","bacterial")
  numdbs <- length(dbs)
  for (i in 1:numdbs) {
    db <- dbs[i]
    choosebank(db)
    # Comprobar si la secuencia está en la base de datos ACNUC Tdb T:
    resquery <- try(query(".tmpquery", paste("AC=", accession)), silent = TRUE) 
    if (!(inherits(resquery, "try-error")))
    {
      print(paste("trying: ",db))
      queryname <- "query2"
      thequery <- paste("AC=",accession,sep="") 
      print(thequery)
      # consulta("queryname","thequery")
      query2 <- query(`queryname`,`thequery`)
      # Ver si se recuperó una secuencia:
      seq <- getSequence(query2$req[[1]]) 
      closebank()
      return(seq) 
    }
    print(paste("accession not in: ",db))
    closebank()
  }
  print(paste("ERROR: accession",accession,"was not found"))
}

vibrio1 <- getncbiseq("FM204865")

vibrio1[1:50] 
length(vibrio1)
table(vibrio1)
(317+461)*100/(375+317+461+303)
GC(vibrio1)

