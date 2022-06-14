###### READING DATA ############
bitdata<-read.csv("bitcoin1.csv",header=TRUE)
bitdata
str(bitdata)
par(mfrow=c(2,2))
###### CONVERTING DATA INTO A TIME SERIES (DAILY DATA) ###########
bitdata_ts_daily<-ts(bitdata$Close,start=c(2011,6),end=c(2021),frequency=365)
bit_log<-log(bitdata_ts_daily)
###### PLOTTING DAILY DATA ###############
plot(bitdata_ts_daily,main="BITCOIN PRICE DAILY DATA",xlab="DATES",ylab="PRICE",lw=1,col=12)
###### CONVERTING TO YEARLY DATA (YEARLY DATA) ###########
bitdata_ts_yearly<- aggregate(bitdata_ts_daily, frequency=1, FUN = sum)
###### PLOTTING YEARLY DATA ###############
plot(bitdata_ts_yearly,main="BITCOIN YEARLY DATA",xlab="YEARS",ylab="PRICE",lw=4,col=12)
######## seasonality#######
x<-stl(bitdata_ts_daily,s.window="periodic")
plot(x)
######### seasonally adjusted#######
bit_seson<-decompose(bitdata_ts_daily)
bit_seson<-bit_seson$x-bit_seson$seasonal
plot(bit_seson,ylab="SEASONALL ADJUSTED PRICE",col=12)
############### stationarity ###############
######## test for stationarity##############
library(urca)
close_kpss<-ur.kpss(bit_seson,type=c("tau"))
summary(close_kpss)
close_adf<-ur.df(bit_seson,type=c("trend"),selectlags="BIC")
summary(close_adf)
close_pp <-ur.pp(bit_seson, type=("Z-tau"), model=c("trend"))
summary(close_pp)
close_adfgls<-ur.ers(bit_seson,type="DF-GLS", model="trend")
summary(close_adfgls)
################ making it stationary #############
bitog<-diff(bit_seson)
plot(bitog,ylab="STATIONARY PRICE",lw=1,col=12)
bitlog<-na.omit(bitog)
cbind(bit_seson,bitlog)
close_adf2<-ur.df(bitlog,type=c("trend"),selectlags="BIC")
summary(close_adf2)
close_pp2<-ur.pp(bitlog, type=("Z-tau"), model=c("trend"))
summary(close_pp2)
close_kpss2<-ur.kpss(bitlog,type=c("tau"))
summary(close_kpss2)
close_adfgls2<-ur.ers(bitlog,type="DF-GLS", model="trend")
summary(close_adfgls2)
########## ACF AND PCF PLOTS #########
acf(bitog)
pacf(bitog)

######### ARIMA MODEL ########
??auto.arima
library(forecast)
arima(bitlog,order=c(13,3,2))
arima(bitlog,order=c(15,3,3))
arima(bitlog,order=c(15,3,1))
arima(bitlog,order=c(12,3,2))
arima(bitlog,order=c(12,3,1))
arima(bitlog,order=c(15,3,4))
arima(bitlog,order=c(13,3,1))
arima(bitlog,order=c(12,3,1))
arima(bitlog,order=c(12,3,3))
arima(bitlog,order=c(16,3,1))
arima.final<-arima(bitlog,order=c(11,3,3))
accuracy(arima.final)
tsdiag(arima.final)
fit<-arima.final
tsdisplay(residuals(fit,lagmax=20))
forecatw<-forecast(fit,h=365)
library(dygraphs)
plot(forecatw)
hist(c(forecatw$fitted),col=5,breaks=80,yaxt="none",xaxt="none",xlab="Years",main="Predicted Volume")
r<-bitdata
######### bitcoin prediction using prophet
install.packages('prophet')
library(prophet)
library(tidyverse)
r$Date<-dmy(r$Date)
library(lubridate)
library(ggplot2)
head(r)
ds<-r$Date
y<-na.omit(r$Volume_BTC)
df<-data.frame(ds,y)
m<-prophet(df)
future<-make_future_dataframe(m,period=365)
tail(future)
forecast<-predict(m)
plot(m,forecast)
dyplot.prophet(m,forecast)
prophet_plot_components(m,forecast)
str(forecast)
pred<-forecast$yhat[1:3470]
actual<-m$history$y
summary(lm(pred~actual))