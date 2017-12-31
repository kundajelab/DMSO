rm(list=ls())
library(ggplot2)
for(i in seq(1,6))
{
  data=read.table(paste(i,".dist",sep=""),header=FALSE,sep='\t')
  ks_result=ks.test(data$V1[data$V2=="foreground"],data$V1[data$V2=="background"],alternative="greater")
  p=ggplot(data,aes(x=data$V1,group=data$V2,color=data$V2))+
    stat_ecdf()+
    xlab("Distance to nearest peak/gene in bp")+
    ylab("CDF")+
    theme_bw()+
    ggtitle(paste("cluster",i," KS.stat=",round(ks_result$statistic,2), " ,ks.p-value=",formatC(ks_result$p.value, format = "e", digits = 2),sep=""))+
    guides(color=guide_legend(title="Dist."))
  png(paste(i,".png",sep=""))
  print(p)
  dev.off() 
}
