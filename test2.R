# ��� Ȯ�� (��ǻ�� ȯ�漳������ �ٸ�)
# setwd("C:/Users/82108/Dropbox/MyDocuments/MD_4_1/4_R/����2")
setwd("D:/Dropbox/MyDocuments/MD_4_1/4_R/����2")
# setwd("C:/Users/pil/Dropbox/MyDocuments/MD_4_1/4_R/����2")
getwd()

# ������ �ҷ�����
data <- read.csv("test20.csv")

## ��ó�� ----------------------------------------------------------------------
# ù��° ���� ���ڸ� ����
names(data)[1] <- 'sid'

# ����ġ ó��
data[data<0] <- NA


## ���� ���� -------------------------------------------------------------------

# �ұԸ� �б� 
data$SCLASS <- ifelse(data$CLASS1<3, 1, 0)
# data$SCLASS = as.factor(data$SCLASS)

# ������ ���� ��ſ�(1�г�, 2�г�)
data$Y1READ <- rowSums(data[c("Y1S19_2","Y1S19_3", "Y1S19_5", "Y1S19_7")], na.rm=T)
data$Y2READ <- rowSums(data[c("Y2S14_2","Y2S14_3", "Y2S14_5", "Y2S14_7")], na.rm=T)


# �б�����������(2�г�)
data$Y2SES <- rowSums(data[c("Y2S5_15","Y2S5_16", "Y2S5_17", "Y2S5_18", "Y2S5_19", 
                              "Y2S5_20", "Y2S5_21", "Y2S5_22", "Y2S5_23")], na.rm=T)

# �о��ھư���(2�г�)
data$Y2SSC <- rowSums(data[c("Y2S2_24","Y2S2_25", "Y2S2_26", "Y2S2_28", "Y2S2_29", 
                             "Y2S2_30")], na.rm=T)

# �θ��о�����(2�г�)
data$Y2PSS <- rowSums(data[c("Y2S27_1","Y2S27_2", "Y2S27_3", "Y2S27_4", "Y2S27_5", 
                             "Y2S27_6", "Y2S27_7", "Y2S27_8")], na.rm=T)

# �θ���������(2�г�)
data$Y2PES <- rowSums(data[c("Y2S27_9","Y2S27_10")], na.rm=T)


### ����Ǯ�� -------------------------------------------------------------------
attach(data)

## ���� 1 (ī����������) ######################
# ��Ű�� ��ġ
# install.packages("gmodels")
library(gmodels)

# �����µ� 1(������ �о����� �߿䵵)
hist(Y1S11_5)
hist(Y1S11_5, breaks=seq(0,5,by=1))
boxplot(Y1S11_5)
summary(Y1S11_5)
sd(Y1S11_5, na.rm=T)

# �����µ� 2(������ �μ����� �߿䵵)
hist(Y1S11_6)
hist(Y1S11_6, breaks=seq(0,5,by=1))
boxplot(Y1S11_6)
summary(Y1S11_6)
sd(Y1S11_6, na.rm=T)

# ��ǥ��
table(Y1S11_5,Y1S11_6)

# ī����������
# H0: �о������� �μ������� �����̴�. H1: �о������� �μ������� ������ �ƴϴ�.
CrossTable(Y1S11_5,Y1S11_6, chisq = T,
           expected = T, dnn=c("�米��","�б�������"),
           prop.r=F, prop.c=F, prop.t=F)
# p = 1.425563e-11 �̹Ƿ� �͹������� �Ⱒ. ���� �� ������ ������ �ƴϰ� ������ �ִ�.

# ���� ��ġ��
# �о����� �߿䵵
table(Y1S11_5)
# Y1S11_5[is.na(Y1S11_5)==F & (Y1S11_5=="���� �׷��� �ʴ�" | Y1S11_5=="��
# ���� �ʴ�")] <- "�׷��� �ʴ�"
Y1S11_5[is.na(Y1S11_5)==F & (Y1S11_5==1 | Y1S11_5==2)] <- 2
table(Y1S11_5)

# �μ����� �߿䵵
table(Y1S11_6)
# Y1S11_6[is.na(Y1S11_6)==F & (Y1S11_6=="���� �׷��� �ʴ�" | Y1S11_6=="��
# ���� �ʴ�")] <- "�׷��� �ʴ�"
Y1S11_6[is.na(Y1S11_6)==F & (Y1S11_6==1 | Y1S11_6==2)] <- 2
table(Y1S11_6)

# ī����������
# H0: �о������� �μ������� �����̴�. H1: �о������� �μ������� ������ �ƴϴ�.
CrossTable(Y1S11_5,Y1S11_6, chisq = T,
           expected = T, dnn=c("�米��","�б�������"),
           prop.r=F, prop.c=F, prop.t=F)
# p = 5.544237e-13 �̹Ƿ� �͹������� �Ⱒ. ���� �� ������ ������ �ƴϰ� ������ �ִ�.
# ���ָ� �ʹ� ������ ������ ���� ���� �񱳰� ����? ����! �׷��� �ʴ�!
# �ſ� �׷��� �ʴٿ� �׷��� �ʴٰ� ǥ���� ���� ���



## ���� 2 (�ܼ�ȸ�ͺм�) ######################
# �б����� ������ 
hist(Y2SES)
boxplot(Y2SES)
summary(Y2SES)
sd(Y2SES, na.rm=T)

# �о����� �߿䵵�� ���� �б� ������ ȸ�ͺм�
model_SES_5 <- lm(Y2SES~Y1S11_5)
summary(model_SES_5)
# p-value�� 0.9745�̹Ƿ� ȸ�͸��� �ǹ̰� ����.


# �μ����� �߿䵵�� ���� �б� ������ ȸ�ͺм�
model_SES_6 <- lm(Y2SES~Y1S11_6)
summary(model_SES_6)
# p-value�� 1.876e-05�̹Ƿ� ȸ�͸��� �ǹ̰� �ִ�.

# ȸ�Ͱ �׸���
plot(Y2SES~Y1S11_6)
abline(model_SES_6, col='red')



## ���� 3 (����м�) ######################
#���б� 2�г� ����� 
hist(Y2KOR_S)
boxplot(Y2KOR_S)
summary(Y2KOR_S)
sd(Y2KOR_S, na.rm=T)

# 1. �кθ� �����з�, ����� �����ҵ�, �θ��� �о����� �� ��������

cor(Y2KOR_S, PEDU, use="complete.obs", method="pearson")
plot(Y2KOR_S, PEDU)
abline(lm(Y2KOR_S~PEDU), col='red')

cor(Y2KOR_S, MEDU, use="complete.obs", method="pearson")
plot(Y2KOR_S, MEDU)
abline(lm(Y2KOR_S~MEDU), col='red')

cor(Y2KOR_S, INCOME, use="complete.obs", method="pearson")
plot(Y2KOR_S, INCOME)
abline(lm(Y2KOR_S~INCOME), col='red')

cor(Y2KOR_S, Y2PSS, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y2PSS)
abline(lm(Y2KOR_S~Y2PSS), col='red')

cor(Y2KOR_S, Y2PES, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y2PES)
abline(lm(Y2KOR_S~Y2PES), col='red')

# 2. ���� �Ը�, ��������, �������, �ұԸ��б�
cor(Y2KOR_S, REGION, use="complete.obs", method="pearson")
plot(Y2KOR_S, REGION)
abline(lm(Y2KOR_S~REGION), col='red')

cor(Y2KOR_S, SECTOR, use="complete.obs", method="pearson")
plot(Y2KOR_S, SECTOR)
abline(lm(Y2KOR_S~SECTOR), col='red')

cor(Y2KOR_S, COEDU, use="complete.obs", method="pearson")
plot(Y2KOR_S, COEDU)
abline(lm(Y2KOR_S~COEDU), col='red')

cor(Y2KOR_S, SCLASS, use="complete.obs", method="pearson")
plot(Y2KOR_S, SCLASS)
abline(lm(Y2KOR_S~SCLASS), col='red')

# 3. ����, 2�г� ������ſ�, �о��ھư���, �米������, 1�г� �����
cor(Y2KOR_S, GENDER, use="complete.obs", method="pearson")
plot(Y2KOR_S, GENDER)
abline(lm(Y2KOR_S~GENDER), col='red')

cor(Y2KOR_S, Y2READ, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y2READ)
abline(lm(Y2KOR_S~Y2READ), col='red')

cor(Y2KOR_S, Y2SSC, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y2SSC)
abline(lm(Y2KOR_S~Y2SSC), col='red')

cor(Y2KOR_S, Y2P31_1, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y2P31_1)
abline(lm(Y2KOR_S~Y2P31_1), col='red')

cor(Y2KOR_S, Y1KOR_S, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y1KOR_S)
abline(lm(Y2KOR_S~Y1KOR_S), col='red')


## ���� 4 (�ߴ�ȸ�ͺм�) ######################
# ��Ű�� ��ġ
# install.packages("car")
library(car)

# ��������: �� �������� ���� ���밪�� ���� �������� ������ ������ ��ǥ ������ ����
# 1. ��Ӵ� �����з�
cor(Y2KOR_S, MEDU, use="complete.obs", method="pearson")
plot(Y2KOR_S, MEDU)

# 2. �ұԸ� �б�
cor(Y2KOR_S, SCLASS, use="complete.obs", method="pearson")
plot(Y2KOR_S, SCLASS)

# 3. 1�г� �����
cor(Y2KOR_S, Y1KOR_S, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y1KOR_S)

model_KOR_MSY <- lm(Y2KOR_S~MEDU+SCLASS+Y1KOR_S)
summary(model_KOR_MSY)
# MEDU�� SCLAss�� ����Ȯ���� 0.134, 0.410���� 0.05���� ũ�Ƿ� �������� �ʴ�.
vif(model_KOR_MSY)
# vif���� 10�� ���� �����Ƿ� ���߰����� ������ ���� ������ ���δ�.
tail(sort(cooks.distance(model_KOR_MSY)))
tail(sort(hatvalues(model_KOR_MSY)))
# tail���� 1�� ���� �����Ƿ� �̻�ġ�� ���� ������ ���δ�.

model_KOR_MSY2 <- lm(Y2KOR_S~MEDU*SCLASS*Y1KOR_S)
summary(model_KOR_MSY2)


## ���� 5 (�ܼ�ȸ�ͺм�) ######################

# 1�г� ������� 2�г� ����� ������ �������� ����. 
# �̸� ���� ������ ���� ���� ����
# ���� 4���� ���ҵ��� �ߴ�ȸ�ͺм����� MEDU�� SCLAss�� ����Ȯ���� 0.134, 0.410���� 
# 0.05���� ũ�Ƿ� �������� �ʴ�. ���� Y1KOR_S�θ� �м��Ͽ� ������ ���� �����.
cor(Y2KOR_S, Y1KOR_S, use="complete.obs", method="pearson")
plot(Y2KOR_S, Y1KOR_S)
model_KOR_21 <- lm(Y2KOR_S~Y1KOR_S)
abline(model_KOR_21, col='red')
