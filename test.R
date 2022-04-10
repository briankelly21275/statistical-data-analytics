# ��� Ȯ�� (��ǻ�� ȯ�漳������ �ٸ�)
# setwd("D:/Dropbox/MyDocuments/MD_4_1/4_R/����1")
setwd("C:/Users/pil/Dropbox/MyDocuments/MD_4_1/4_R/����1")
getwd()

# ������ �ҷ�����
data <- read.csv("test20.csv")

## ��ó�� ----------------------------------------------------------------------
# ù��° ���� ���ڸ� ����
names(data)[1] <- 'sid'

# ����ġ ó��
names_for_NA <- c("Y1S19_2","Y1S19_3", "Y1S19_5", 
                  "Y1S19_7", "Y2S14_2","Y2S14_3", "Y2S14_5", "Y2S14_7", "Y2S5_15",
                  "Y2S5_16", "Y2S5_17", "Y2S5_18", "Y2S5_19", "Y2S5_20", "Y2S5_21", 
                  "Y2S5_22", "Y2S5_23", "Y2S2_24","Y2S2_25", "Y2S2_26", "Y2S2_28", 
                  "Y2S2_29", "Y2S2_30", "Y2S27_1", "Y2S27_2", "Y2S27_3", "Y2S27_4", 
                  "Y2S27_5", "Y2S27_6", "Y2S27_7", "Y2S27_8", "Y2S27_9", "Y2S27_10")
for(name_for_NA in names_for_NA){
  data[name_for_NA][data[name_for_NA] <0] <- NA
}


# ������ Ÿ�� ����
data$GENDER = as.factor(data$GENDER)
data$PEDU = as.factor(data$PEDU)
data$MEDU = as.factor(data$MEDU)
data$REGION = as.factor(data$REGION)
data$SECTOR = as.factor(data$SECTOR)
data$COEDU = as.factor(data$COEDU)
data$Y1S15 = as.factor(data$Y1S15)
data$Y1S11_5 = as.factor(data$Y1S11_5)
data$Y1S11_6 = as.factor(data$Y1S11_6)

# ���� ����
levels(data$GENDER) <- c("����", "����")
levels(data$REGION) <- c("Ư����", "������", "�߼ҵ���", "��������")
levels(data$SECTOR) <- c("������", "�縳")
levels(data$COEDU) <- c("�������", "���б�", "���б�")
levels(data$Y1S15) <- c("������", "�ִ�", "����")
levels(data$Y1S11_5) <- c("������", "�����׷��� �ʴ�", "�׷��� �ʴ�", "�����̴�", "�׷���", "�ſ� �׷���")
levels(data$Y1S11_6) <- c("������", "�����׷��� �ʴ�", "�׷��� �ʴ�", "�����̴�", "�׷���", "�ſ� �׷���")


## ���� ���� -------------------------------------------------------------------

# �ұԸ� �б� 
data$SCLASS <- ifelse(data$CLASS1<3, 1, 0)
data$SCLASS = as.factor(data$SCLASS)

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

## ���� 1 (�� ����ǥ�� t����) ######################

#hist(data$Y1READ)
#boxplot(data$Y1READ)
# plot(data$Y1READ)
#summary(data$Y1READ)

#hist(data$Y2READ)
#boxplot(data$Y2READ)
# plot(data$Y2READ)
#summary(data$Y2READ)

# ������ ���� ��ſ� t����
model_READ <- t.test(data$Y1READ, data$Y2READ, paired = TRUE)
print(model_READ)
print("1,2�г� �� �л����� ������ ���� ��ſ� ������ ���̰� �ִ�.")

# ���� ���� t����
model_KOR <- t.test(data$Y1KOR_S, data$Y2KOR_S, paired = TRUE)
print(model_KOR) # => ���� ����
print("1,2�г� �� �л����� ���� ������ ���̰� �ִ�.")


## ���� 2 (�� ����ǥ�� t����) ######################

# �ұԸ� ���� ��л� ����
var.test(Y2SES~SCLASS, data) # �� �л��� ����. 
var.test(Y2SSC~SCLASS, data) # �� �л��� ����. 
var.test(Y2KOR_S~SCLASS, data) # �� �л��� ����. 
# install.packages("car")
library("car")
leveneTest(Y2SES~SCLASS, data) # �� �л��� ����.
leveneTest(Y2SSC~SCLASS, data) # �� �л��� ����. 
leveneTest(Y2KOR_S~SCLASS, data) # �� �л��� ����. 

# ���� ��л� ����
var.test(Y2SES~GENDER, data) # �� �л��� �ٸ��� 
var.test(Y2SSC~GENDER, data) # �� �л��� �ٸ��� 
var.test(Y2KOR_S~GENDER, data) # �� �л��� ����. 

leveneTest(Y2SES~GENDER, data) # �� �л��� ����.
leveneTest(Y2SSC~GENDER, data) # �� �л��� ����. 
leveneTest(Y2KOR_S~GENDER, data) # �� �л��� ����. 

# �ұԸ� ���� t����
model_S_SES <- t.test(Y2SES~SCLASS, data, var.equal=T)
model_S_SSC <- t.test(Y2SSC~SCLASS, data, var.equal=T)
model_S_KOR <- t.test(Y2KOR_S~SCLASS, data, var.equal=T)
print(model_S_SES)
print("�б��� �ұԸ� �б����� ���ο� ���� �б����� �������� ���̰� �ִ�.")
print(model_S_SSC)
print("�б��� �ұԸ� �б����� ���ο� ���� �о��ھư��信 ���̰� ����.")
print(model_S_KOR)
print("�б��� �ұԸ� �б����� ���ο� ���� ���� ������ ���̰� �ִ�.")

# ���� t����
model_G_SES <- t.test(Y2SES~GENDER, data, var.equal=T)
model_G_SSC <- t.test(Y2SSC~GENDER, data, var.equal=T)
model_G_KOR <- t.test(Y2KOR_S~GENDER, data, var.equal=T)
print(model_G_SES)
print("������ ���� �б����� �������� ���̰� ����.")
print(model_G_SSC)
print("������ ���� �о��ھư��信 ���̰� ����.")
print(model_G_KOR)
print("������ ���� ���� ������ ���̰� �ִ�.")


## ���� 3 (�Ͽ��л�м�) ######################

# ������� ���� ��л� ����
leveneTest(Y2SES~COEDU, data) # �� �л��� �ٸ���.

# �����Ը� ��л� ����
leveneTest(Y2SES~REGION, data) # �� �л��� ����.

# ������� ���� �л�м�
model_C_SES <- aov(Y2SES~COEDU, data)
summary(model_C_SES)
print("�б��� ����������� �ƴϸ� ���б� Ȥ�� ���б������� ���� �л�����
�б����� �������� ���̰� ����.")

# ������� ���� ���İ���
tukey_C_SES <- TukeyHSD(model_C_SES)
print(tukey_C_SES)
plot(tukey_C_SES)
print("��� ������ 0�� �����ϱ� ������ ��� ������ ����� ���ٰ� �� �� �ִ�.")

# �����Ը� �л�м�
model_R_SES <- aov(Y2SES~REGION, data)
summary(model_R_SES)
print("�����Ը� ���� �б����� �������� ���̰� ����.")

# �����Ը� ���İ���
tukey_R_SES <- TukeyHSD(model_R_SES)
print(tukey_R_SES)
plot(tukey_R_SES)
print("��� ������ 0�� �����ϱ� ������ ��� ������ ����� ���ٰ� �� �� �ִ�.")


## ���� 4 (�̿��л�м�) ######################

# �����Ը�, �л�ȸȰ������ �л�м�
model_RY_SES <- aov(Y2SES~REGION*Y1S15, data)
summary(model_RY_SES)
print("REGION:Y1S15�� ���̰� ������ ��ȣ�ۿ��� �����Ѵ�.")

model_RY_SES2 <- aov(Y2SES~REGION+Y1S15, data)
summary(model_RY_SES2)
print("�����Ը�, �л�ȸȰ�����迡 ���� �б����� �������� ���̰� ����.")

# �����Ը�, �л�ȸȰ������ ���İ���
tukey_RY_SES <- TukeyHSD(model_RY_SES2)
print(tukey_RY_SES)
plot(tukey_RY_SES)
print("��� ������ 0�� �����ϱ� ������ ��� ������ ����� ���ٰ� �� �� �ִ�.")

interaction.plot(x.factor=data$REGION,trace.factor=data$Y1S15,
                 response=data$Y2SES, fun=mean, type="b", lwd = 3,
                 pch=c(2,3,4),col=c(2,3,4),xlab="�����Ը�",ylab="�б����� ������")


## ���� 5 (�̿��л�м�) ######################

# ��������, �����Ը� �л�м�
model_SR_Y1H7 <- aov(Y1H7_2_1~SECTOR*REGION, data)
summary(model_SR_Y1H7)
print("SECTOR:REGION�� ���̰� ������ ��ȣ�ۿ��� �����Ѵ�.")
# print("��������, �����Ը� ���� ���غ� �̵������� �ϴ��� ���ο� ���̰� �ִ�.")

# ��������, �����Ը� ���İ���
tukey_SR_Y1H7 <- TukeyHSD(model_SR_Y1H7)
print(tukey_SR_Y1H7)
plot(tukey_SR_Y1H7)
# print("��� ������ 0�� �����ϱ� ������ ��� ������ ����� ���ٰ� �� �� �ִ�.")

interaction.plot(x.factor=data$SECTOR, trace.factor=data$REGION,
                 response=data$Y1H7_2_1, fun=mean, type="b", lwd = 3,
                 pch=c(2,3,4,5),col=c(2,3,4,5),xlab="��������",ylab="�̵���������")


## ���� 6 (�̿��л�м�) ######################

# �������� �����ϴ� �о����� �߿䵵, �μ����� �߿䵵 �л�м�
model_YY_Y1MAT <- aov(Y1MAT_S~Y1S11_5*Y1S11_6, data)
summary(model_YY_Y1MAT)
print("Y1S11_5:Y1S11_6�� ���̰� ������ ��ȣ�ۿ��� �������� �ʴ�.")

model_YY_Y1MAT2 <- aov(Y1MAT_S~Y1S11_5+Y1S11_6, data)
summary(model_YY_Y1MAT2)
# print("�������� �����ϴ� �о����� �߿䵵, �μ����� �߿䵵�� ���� ���غ� �̵������� �ϴ��� ���ο� ���̰� �ִ�.")

# �������� �����ϴ� �о����� �߿䵵, �μ����� �߿䵵 ���İ���
tukey_YY_Y1MAT <- TukeyHSD(model_YY_Y1MAT2)
print(tukey_YY_Y1MAT)
plot(tukey_YY_Y1MAT)
print("��� ������ 0�� �����ϱ� ������ ��� ������ ����� ���ٰ� �� �� �ִ�.")

interaction.plot(x.factor=data$Y1S11_5,trace.factor=data$Y1S11_6,
                 response=data$Y1MAT_S, fun=mean, type="b", lwd = 3,
                 pch=c(2,3,4,5,6,7),col=c(2,3,4,5,6,7),xlab="�������� �о����� �߿䵵",ylab="���м���")
