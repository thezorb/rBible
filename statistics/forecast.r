library(fpp2)
library(forecast)
library(expsmooth)
library(ggplot2)
library(seasonal)
library(prophet)
library(dplyr)
#source("R.utils")

setwd("~/Comcast/EBI Analytics - Finance Exec Flex - Documents/2020 Projects/Projects/04_29_20 HSD Usage (Loyack)")
#write.csv(elecequip,file = "elecequip.csv",row.names = FALSE)

df = read.csv("hsd_usage_rosetta_total.csv")[,1]

#length_test_set = 16
#length_test_set_real = 4
h = 12

#data = ts(df[1:(length(df)-length_test_set_real)],start = c(2018,1),frequency = h)
data = ts(df[1:26],start = c(2018,1),frequency = h)
#train_data = ts(df[1:22],start = c(2018,1), frequency = h)
data
#throwing a bunch of forecasts 
autoplot(data) +
  #autolayer(meanf(train_data, h=h),
  #          series = "Mean", PI=FALSE) +
  autolayer(naive(data, h=5),
            series = "Naive", PI=FALSE) +
  autolayer(snaive(data, h=5),
            series = "Seasonal naive", PI=FALSE) +
  autolayer(forecast(data, h=5),
            series = "Forecast", PI=FALSE) +
  autolayer(rwf(data, h=5, drift=TRUE),
            series = "Random", PI=FALSE) +
  autolayer(forecast(auto.arima(data, seasonal=TRUE), h=5),
            series = "SARIMA", PI=FALSE) +
  guides(colour=guide_legend(title='Forecast'))

#sarima
sarima_model <- forecast(auto.arima(data, seasonal=TRUE), h=5)
summary(sarima_model)
autoplot(sarima_model)
autoplot(data)
accuracy(sarima_model, data)
rs <- residuals(sarima_model)
checkresiduals(rs)

write.csv(summary(sarima_model),file = "elecequip.csv",row.names = FALSE)

#prophet (Facebook)
df_prophet = read.csv("video_connects_prophet.csv")
df_prophet <- dplyr::slice(df_prophet,1:94)
m <- prophet(df_prophet,seasonality.mode = 'multiplicative')
future <- make_future_dataframe(m, periods = 12, freq = 'month')
fcst <- predict(m, future)
plot(m, fcst)
tail(fcst)

data_real= ts(df,start = c(2011,1),frequency = h)
train_data_real = ts(df[1:(length(df)-length_test_set_real)],start = c(2011,1), frequency = h)

############################################# EXPLORATION
autoplot(train_data_real) +
  ggtitle("Video Connects") + 
  xlab("Year") + ylab("New Connects")
# non-linear trend, cycles, clear seasonality

ggseasonplot(train_data_real, year.labels=TRUE, year.labels.left=TRUE) + ylab("New Connects") +
  ggtitle("Seasonal plot: video connects")

ggseasonplot(train_data_real, polar=TRUE) + ylab("New Connects") +
  ggtitle("Polar seasonal plot: video connects")

ggsubseriesplot(train_data_real)  + ylab("New Connects") +
  ggtitle("Seasonal subseries plot: video connects")

ggAcf(train_data_real)

pacf(train_data_real)

# Decomposition
fit = stl(train_data_real,t.window=13, s.window="periodic", robust=TRUE)
autoplot(fit)

#sarima
sarima_model <- forecast(auto.arima(train_data_real, seasonal=TRUE), h=4)
summary(sarima_model)
autoplot(sarima_model)
autoplot(data_real)
accuracy(sarima_model, data_real)
rs <- residuals(sarima_model)
checkresiduals(rs)

autoplot(data_real) +
  autolayer(forecast(auto.arima(train_data_real, seasonal=TRUE), h=4),
            series = "SARIMA", PI=FALSE) +
  guides(colour=guide_legend(title='Forecast'))

