# Bitcoin Pridiction Analysis

The project focuses on predicting the price of Bitcoin using the ARIMA and the Prophet model by Facebook. The paper demonstrates the implementation and the effectiveness of both the models stated above while predicting the price of Bitcoin. Bitcoin being a decentralized cryptocurrency, possed an altogether difficult challenge as the price of all cryptocurrencies is volatile. In addition, the paper also illustrates the market character of Bitcoin by also forecasting the volume of Bitcoin. Together, the predicted price and the volume can help us evaluate the predicted market character of Bitcoin. In the end of this project, we would be able to compare the two models and finally unveil the better model.

## Overview of the Project
To predict the price of the bitcoin, the data is collected from an API of the website quadln.com which mainly contains the closing price, the opening price, and the volume of BTC during a particular date. The data is collected daily from October of 2011 to March of 2021. The data also contains the high and the low price of the day. It also has data containing the volume of currencies combined which provided us with the weighted price of the day.
For the ARIMA  model, the data collected for the price and volume is made stationary by taking the log differencing and is made seasonally adjusted by removing the seasonal element from it. After making it stationary and seasonally adjusted, several models were applied to find models with minimum AIC value. The models found were then used for forecasting future price and volume. For the Prophet model by Facebook, we do not make the variables stationary or make it seasonally adjusted because Prophet detects the following trend and seasonality from the data first, then combine them to get the forecasted values. Prophet also requires a fixed format of the data frame. The format that Prophet is a ‘ds’ column that contains the date field (in our case date) and a ‘y’ column that contains the value we are wanting to model/forecast.( closing price and volume of the bitcoin). The prophet is though good at forecasting the data efficiently, it did not outperform the ARIMA model. 

![image](https://user-images.githubusercontent.com/38343820/173659246-cd9bb1d6-7bae-4602-8956-5cc5daf8e5d1.png)

## Data Analysis:
The data is collected from an API of the website quadln.com which mainly contains the data on Bitcoin converted into every currency. This data is collected in USD rate conversion. It has eight features namely-Date, opening price, closing price,  High and low price for the day, Volume of BTC, Volume of currency, and the Weighted Price of that particular date. The data is collected daily from October of 2011 to March of 2021. The following figure ( Fig 2)  shows few rows of the dataset sorted by date in descending order:

![image](https://user-images.githubusercontent.com/38343820/173659709-8abfdcbe-d422-438d-9f64-d892318817af.png)

Before we start implementing our proposed ARIMA model, we need to look at the trend of both the price and the volume of  Bitcoin (fig3). More importantly, we also need to understand all the variables in the given table to understand using what field will we try to forecast the price and the volume.
