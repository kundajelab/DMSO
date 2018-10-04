rm(list=ls())
data=read.table("bar_graph_input.txt",header=TRUE,sep='\t',stringsAsFactors = FALSE)
library(ggplot2)
bar_color_names=c("#e6194b",
                  "#3cb44b",
                  "#ffe119",
                  "#0082c8",
                  "#f58231",
                  "#911eb4",
                  "#46f0f0",
                  "#f032e6",
                  "#d2f53c",
                  "#fabebe",
                  "#008080",
                  "#e6beff",
                  "#aa6e28",
                  "#fffac8",
                  "#800000")
data=data[order(-data$X.10log10FDR,data$Group),]
data$Pathway <- factor(data$Pathway, levels = unique(data$Pathway))
p1=ggplot(data=data,aes(x=Pathway,y=X.10log10FDR,group=Group,fill=Group))+
  geom_bar(stat="identity",position="dodge")+
  scale_y_log10()+
  ylab("-10log10(FDR)")+
  xlab("Enriched Pathways")+
  geom_hline(yintercept=-10*log10(0.05),size=2)+
  
  coord_flip()+
  theme_bw()+
  scale_fill_manual(values=bar_color_names[c(1,2,3,4,5,6)])
png("pathways_fdr_top.png",height=10,width=8,res=600,units = "in")
print(p1)
dev.off() 
