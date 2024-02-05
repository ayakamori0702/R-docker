 <- read.table("https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv",header= FALSE,sep =',')

#列名の変更
colnames(df) <- c("pregnant","glucose","diastolic_BP","subcutaneous_fat","serum_insulin","BMI"
                  ,"diabetes pedigree function","age","Diabetes")                 #9つの変数
#欠測データの削除
df2 <- df[df$glucose!=0 & df$diastolic_BP!=0 & df$subcutaneous_fat!=0 & df$serum_insulin!=0 & df$BMI!=0,]

#正規化
df_scale <- scale(df2[,c(1:8)])

#階層的クラスタリング

d <- dist(df_scale,method="euclidean") #サンプル間の距離を総当りで計算

hc <- hclust(d,method="ward.D2")        #Ward法を使ってクラスタリング

plot(hc)

hc.cluster <- cutree(hc,k=2)     #階層的クラスタリングで２つのクラスターに分割　

tab <- table(df2$Diabetes,hc.cluster)#それぞれのクラスターごとに５年以内に糖尿病を発症する人が何人いるのかを集計

#k-meansでクラスタリング
SSE <- c()

for(k in 2:20){

  km.cluster <- kmeans(df_scale, centers=k)
  SSE <- c(SSE, km.cluster$tot.withinss)
}

plot(x=2:20,y=SSE) 



#主成分分析
pc.res <- prcomp(df_scale)

summary(pc.res)

plot(pc.res$x[,c(1,2)])

#k-meansでクラスタリング
SSE <- c()

for(k in 2:20){

  km.cluster <- kmeans(df_scale, centers=k)
  SSE <- c(SSE, km.cluster$tot.withinss)
}

plot(x=2:20,y=SSE)   

#k=2で分割してシルエット分析
install.packages("factoextra")
library(cluster)
library(factoextra)

dis = dist(df_scale)^2                                                           
km.res <- kmeans(df_scale, centers = 2)
sil = silhouette(km.res$cluster, dis)

fviz_silhouette(sil)


#PCA
library(ggplot2)

df3 <- data.frame(df2,pc.res$x[,c(1,2)])

colnames(df3) <- c(colnames(df2),"PC1","PC2")
df3$Diabetes <- factor(df3$Diabetes)                                         

p <- ggplot(data=df3) + geom_point(aes(x=PC1,y=PC2,color=Diabetes))



#次元削減
#PCA
library(ggplot2)

df3 <- data.frame(df2,pc.res$x[,c(1,2)])

colnames(df3) <- c(colnames(df2),"PC1","PC2")
df3$Diabetes <- factor(df3$Diabetes)                                         

p <- ggplot(data=df3) + geom_point(aes(x=PC1,y=PC2,color=Diabetes))

#t-SNE

install.packages("Rtsne")

library(Rtsne)

tsne.res <- Rtsne(as.matrix(df_scale))

df3 <-data.frame(df2,tsne.res$Y[,c(1,2)])

colnames(df3)<- c(colnames(df2),"tSNE1","tSNE2")
df3$Diabetes <- factor(df3$Diabetes)

p <- ggplot(data=df3) + geom_point(aes(x=tSNE1,y=tSNE2,color=Diabetes))

#UMAP

install.packages("uwot")

library(uwot)

umap.res <- umap(as.matrix(df_scale)) 

df3 <- data.frame(df2,umap.res[,c(1,2)])

colnames(df3) <- c(colnames(df2),"UMAP1","UMAP2")
df3$Diabetes <- factor(df3$Diabetes)

p <- ggplot(data=df3) + geom_point(aes(x=UMAP1,y=UMAP2,color=Diabetes))