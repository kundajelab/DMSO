#get colMeans and colSD, grouped by cluster, define some helper functions  
#means 
clust_colMeans<-function(data,cluster){
  data_subset=data[data$cluster==cluster,]
  data_subset$cluster=NULL
  return(colMeans(data_subset))
}

#standard deviation
clust_sd<-function(data,cluster){
  data_subset=data[data$cluster==cluster,]
  data_subset$cluster=NULL
  return(apply(data_subset,2,sd))
}

#cluster size 
clust_size<-function(data,cluster){
  data_subset=data[data$cluster==cluster,]
  df=data.frame(size=nrow(data_subset),
                cluster=cluster)
  return(df)
}

