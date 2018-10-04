rm(list=ls())
data=read.table('r_input.txt',header=TRUE,sep='\t',allowEscapes = FALSE)

data$Tad=factor(data$Tad,levels=c("Same","Adjacent","Distal"))
library(ggplot2)
p=ggplot(data=data,aes(x=data$Dataset,y=data$Percent,group=data$Tad,fill=data$Tad))+
  geom_bar(  position = "stack",stat="identity")+
  scale_fill_manual(values=c("#1b9e77","#d95f02","#7570b3"),name="Tad")+
  ylab("Percent of Differential Peaks \n with Differential Gene in Same, Adjacent, or Distal Tad")+
  xlab("")+
  theme_bw(20)
print(p)