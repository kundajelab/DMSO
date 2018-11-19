#connect to DAVID Web interface 
library("RDAVIDWebService")
david=DAVIDWebService(email="annashch@stanford.edu",url="https://david.ncifcrf.gov/webservice/services/DAVIDWebService.DAVIDWebServiceHttpSoap12Endpoint/")

#read in the gene lists 
args <- commandArgs(TRUE)

fname=args[1]
listname=args[2]
backgroundname=args[3]

genes=scan(fname,what="",sep="\n")
background=scan(backgroundname,what="",sep="\n")

#add gene list to david
result=addList(david,genes,listType="Gene",listName=listname,idType="ENSEMBL_GENE_ID")
#background=addList(david,background,listType="Background",listName="Background",idType="ENSEMBL_GENE_ID")
#set annotation categories
setAnnotationCategories(david,c("GOTERM_BP_FAT",
				"GOTERM_CC_FAT",
				"GOTERM_MF_FAT",
				"BIOCARTA",
				"KEGG_PATHWAY",
				"REACTOME_PATHWAY"))
outfname=paste('DAVID',listname,sep='.')
chart_object=getFunctionalAnnotationChart(david)
chart_object=chart_object[chart_object$FDR <=0.1,]
write.csv(chart_object,file=outfname,row.names=FALSE)

