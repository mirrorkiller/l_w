if(!suppressWarnings(require("RSNNS"))){
  install.packages("RSNNS")
  require("RSNNS")#����֪��������
}
setwd("C:/Users/Zoey/Desktop")
data<-read.csv("UCI_Credit_Card.csv",header=T)

summary(data)
head(data1)
sum(is.na(data))
#��������

library(corrplot)
library(ggplot2)
corr <-cor(data1)
corrplot(corr=corr)

data1<-data[,c(2,7:12,25)]
#####################################������##################################
install.packages("RSNNS")
library(Rcpp)
library(RSNNS)
#������������ 

Values= data1[,1:7]

#��������������������ݽ��и�ʽת�� 

Targets = decodeClassLabels(data1[,8])

#���л��ֳ�ѵ�������ͼ������� 

data2 = splitForTrainingAndTest(Values, Targets, ratio=0.15)

#���ݱ�׼�� 
data2 = normTrainingAndTestSet(data2)


#����mlp����ִ��ǰ�����򴫲��������㷨 

model = mlp(data2$inputsTrain, data2$targetsTrain, size=3,maxit=500, inputsTest=data2$inputsTest, targetsTest=data2$targetsTest) 
# �����������
predmlp <- predict(model,data2$inputsTest,type = "class")
confusionMatrix(data2$targetsTrain,fitted.values(model))
preTablemlp<-confusionMatrix(data2$targetsTest,predmlp)

(accuracy<-sum(diag(preTablemlp))/sum(preTablemlp))

summary(model)
model
weightMatrix(model)
extractNetInfo(model)

par(mfrow=c(1,1))
plotIterativeError(model)

mlproc <- roc(data2$targetsTest,predmlp)  
plot(mlproc,print.auc=TRUE,auc.polygon=TRUE,grid=c(0.1,0.2),  
     grid.col=c("green","red"),max.auc.polygon=TRUE,auc.polygon.col="skyblue",print.thres=TRUE) 

# ѵ������ȷ�ȡ��ٻ���  
preTablemlp[2,2]/(preTablemlp[1,2]+preTablemlp[2,2]) # ��ȷ��  
preTablemlp[2,2]/(preTablemlp[2,1]+preTablemlp[2,2]) # �ٻ��� 
