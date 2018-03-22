if(!suppressWarnings(require("xgboost"))){
  install.packages("xgboost")
  require("xgboost")
}

library(xgboost)  
ind<-sample(2,nrow(data1),replace=TRUE,prob=c(0.7,0.3)) #�����ݷֳ������֣�70%ѵ�����ݣ�30%�������  
traindata<- data1 [ind==1,]  #ѵ����  
testdata<- data1[ind==2,]  #���Լ�  
traindatax=as.matrix(traindata[,c(1:7)])  
traindatay=as.matrix(traindata[,8])  
testdatax=as.matrix(testdata[,c(1:7)])  
testdatay=as.matrix(testdata[,8]) 
,,
bst <- xgboost(data = TrainData, label = TrainClasses, max.depth = 2, eta = 1,nround = 2) 
predbst<- predict(bst, testdatax)  
#table(pred, testdatay)  
preTablexgb<-table(round(predbst,0), testdatay) 
(accuracy<-sum(diag(preTablexgb))/sum(preTablexgb))


library(pROC)  
xgb<- roc(testdatay, predbst)  
plot(xgb,print.auc=TRUE,auc.polygon=TRUE,grid=c(0.1,0.2),  
     grid.col=c("green","red"),max.auc.polygon=TRUE,auc.polygon.col="skyblue",print.thres=TRUE) 


# ѵ������ȷ�ȡ��ٻ���  
preTablexgb[2,2]/(preTablexgb[1,2]+preTablexgb[2,2]) # ��ȷ��  
preTablexgb[2,2]/(preTablexgb[2,1]+preTablexgb[2,2]) # �ٻ���  




