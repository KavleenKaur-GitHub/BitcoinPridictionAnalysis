# Bitcoin Pridiction Analysis

The project focuses on predicting the price of Bitcoin using the ARIMA and the Prophet model by Facebook. The project demonstrates the implementation and the effectiveness of both the models stated above while predicting the price of Bitcoin. Bitcoin being a decentralized cryptocurrency, possed an altogether difficult challenge as the price of all cryptocurrencies is volatile. In addition, the paper also illustrates the market character of Bitcoin by also forecasting the volume of Bitcoin. Together, the predicted price and the volume can help us evaluate the predicted market character of Bitcoin. In the end of this project, we would be able to compare the two models and finally unveil the better model.

## Overview of the Project
To predict the price of the bitcoin, the data is collected from an API of the website quadln.com which mainly contains the closing price, the opening price, and the volume of BTC during a particular date. The data is collected daily from October of 2011 to March of 2021. The data also contains the high and the low price of the day. It also has data containing the volume of currencies combined which provided us with the weighted price of the day.
For the ARIMA  model, the data collected for the price and volume is made stationary by taking the log differencing and is made seasonally adjusted by removing the seasonal element from it. After making it stationary and seasonally adjusted, several models were applied to find models with minimum AIC value. The models found were then used for forecasting future price and volume. For the Prophet model by Facebook, we do not make the variables stationary or make it seasonally adjusted because Prophet detects the following trend and seasonality from the data first, then combine them to get the forecasted values. Prophet also requires a fixed format of the data frame. The format that Prophet is a ‘ds’ column that contains the date field (in our case date) and a ‘y’ column that contains the value we are wanting to model/forecast.( closing price and volume of the bitcoin). The prophet is though good at forecasting the data efficiently, it did not outperform the ARIMA model. 

![image](https://user-images.githubusercontent.com/38343820/173659246-cd9bb1d6-7bae-4602-8956-5cc5daf8e5d1.png)

## Data Analysis:
The data is collected from an API of the website quadln.com which mainly contains the data on Bitcoin converted into every currency. This data is collected in USD rate conversion. It has eight features namely-Date, opening price, closing price,  High and low price for the day, Volume of BTC, Volume of currency, and the Weighted Price of that particular date. The data is collected daily from October of 2011 to March of 2021. The following figure ( Fig 2)  shows few rows of the dataset sorted by date in descending order:

![image](https://user-images.githubusercontent.com/38343820/173659709-8abfdcbe-d422-438d-9f64-d892318817af.png)

Before we start implementing our proposed ARIMA model, we need to look at the trend of both the price and the volume of  Bitcoin (fig3). More importantly, we also need to understand all the variables in the given table to understand using what field will we try to forecast the price and the volume.

![image](https://user-images.githubusercontent.com/38343820/173659850-52476102-0a94-430a-aed5-1be376c8ee64.png)

### Table
|  VARIABLE   |    DEFINITION    | TYPE    |  
|-----------------|-----------------| -----------------| 
|     OPEN             | DEFINES THE OPENING PRICE ON THAT PARTICULAR DATE                | NUM| 
|     CLOSE            | DEFINES THE CLOSING PRICE ON THAT PARTICULAR DATE                | NUM| 
|     HIGH             | DEFINES THE HIGHEST PRICE ON THAT PARTICULAR DATE                | NUM| 
|     LOW              | DEFINES THE LOWEST PRICE ON THAT PARTICULAR DATE                 | NUM| 
|    VOLUME_BTC        | DEFINES THE VOLUME OF BITCOIN ON THAT PARTICULAR DATE            | NUM|
|  VOLUME_CURRENCY     | DEFINES THE VOLUME OF EVERY OTHER CYPTO ON THAT PARTICULAR DATE  | NUM| 
|  WEIGHTED_PRICE      | DEFINES THE WEIGHTED PRICE ON THAT PARTICULAR DATE               | NUM|

## Statiscal Analysis of the dataset:

The given figure illustrates some important parameters about the data. These parameters might be helpful when trying to analyze the dataset and understanding the dataset in debt.
Date                          Open                    High                   Low         
 Length:3470            Min.   :    0.0          Min.   :    0.0       Min.   :    0.0  
 Class :character       1st Qu.:  232.1         1st Qu.:  236.3        1st Qu.:  227.4  
 Mode  :character       Median :  648.9         Median :  663.4        Median :  628.8  
                        Mean   : 4253.6         Mean   : 4387.7        Mean   : 4104.2  
                        3rd Qu.: 6944.5         3rd Qu.: 7223.1        3rd Qu.: 6759.6  
                        Max.   :61177.0         Max.   :61781.8        Max.   :58959.6  

      Close                      Volume_BTC           Volume_Currency        Weighted_Price   
 Min.   :    0.0            Min.   :     0          Min.   :0.000e+00       Min.   :    0.0  
 1st Qu.:  232.2            1st Qu.:  3656          1st Qu.:1.504e+06       1st Qu.:  232.7  
 Median :  649.6            Median :  7100          Median :6.768e+06       Median :  646.4  
 Mean   : 4265.6            Mean   :  9657          Mean   :4.150e+07       Mean   : 4250.1  
 3rd Qu.: 6963.4            3rd Qu.: 12336          3rd Qu.:4.781e+07       3rd Qu.: 6983.9  
 Max.   :61165.2            Max.   :137070          Max.   :1.369e+09        Max.   :60429.1  

The data collected is daily data so the frequency used for this is 365.

## Theory and hypothesis

The market character of a Bitcoin is dependent on two variables namely- the price and the volume of the BTC. The price of the bitcoin illustrates the direction of the trend of the bitcoin while the volume of the bitcoin demonstrates the strength of the trend. Both together can only help us visualize the real market character. ***The market character is defined by two terms namely – the bullish character and the bearish character. The market is said to follow a bullish trend when both the price and the volume are showing a similar trajectory. But when the market is bearish, both the price and the volume will show a different trajectory.****
        Predicting both the price and volume together does not pose a challenge while applying the ARIMA model. Due to a specific requirement of data-frame by Prophet model, it was required to separately analyze the variables.
       For, this particular project, we intend to predict the price and volume of BTC by using two different models which will help us to get two conclusions namely- the market character of BTC and which model of the two performs better.

## Empirical Methology

Seasonality is variations at specific timeframes which should be removed. The mean of the data is not around zero so it means that the data is not even stationary. So, after removing the seasonality of the data by removing the seasonal part as done for both the price and the volume as shown in Fig 4(a),(b), we would have to make the data stationary too.
           ***Purely based on the figures, we cannot determine if it is stationary or not. To apply the ARIMA model, we need to make sure that the price and the volume of the dataset are stationary or not. We can make sure by performing stationarity tests like Augmented Dickey-Fuller, Kwiatkowski-Phillip-Schmidt-Shin, ADF-GLS, and Phillip-Perron test. These tests have been performed for both these variables to check the stationarity of these variables.***

 For the implementation of the ARIMA model, the dataset is stationary and is seasonally adjusted. For implementing the ARIMA model, we need p,d, and q values. ARIMA model is actually a type of model that explains a given time series based on its own past values, that is, its own lags and the lagged forecast errors, so that equation can be used to forecast future values. An ARIMA model is characterized by 3 terms: p, d, q where,p is the order of the AR term, d is the number of differencing required to make the time series stationary and q is the order of the MA term. To be precise ‘p’  is the number of lags that should be used as predictors. And ‘q’ is the order of the ‘Moving Average’ (MA) term which refers to the number of lagged forecast errors that should go into the ARIMA Model. After putting p, q, d values into the ARIMA model, we can find the model that best fits the data by finding the minimum AIC VALUE. In this particular case, the model that best fits the data is ARIMA(13,3,2). This model has the least AIC values among the rest for the price variable and the volume, the model that works best is ARIMA(16,3,2). For the price, lags that are used as predictors are p which is the order of AR term which is 13 and the order of Moving Average is 2. For the volume, lags that are used as predictors are p which is the order of AR term which is 16 and the order of Moving Average is 2. Now, we will fit the data into the models and then use it to forecast daily values for the next year and display the forecast with its Root Mean Square Error (RMSE) which is the evaluation metric for our models. The forecasted figure and their RMSE for both the price and the volume are given in figure 8(a)(b).
       For implementing the Prophet model, we need to make a data frame with ‘ds’ and  ‘y’ columns. The ‘ds’ column contains the dates of the entire dataset and the y column can contain only one field either the price or the volume of the BTC. This is the reason why we had to do it separately for each variable. One by one, we can add the variables into the y column and then would apply the prophet model to the data frame made. We have to keep in mind that the data is not seasonal or stationary. After the model is generated, we will try to predict future values and forecast 365 days ahead. We will use the metric library to find the mean error of the forecasted model and take its square root to get the RMSE of the model. The forecasted plots and their RMSE are given in figure 9(a)(b).
       The metric used to evaluate the models is RMSE which stands for Root Mean Square Error. RMSE is the square root of Mean Error (ME). Mean Error stands for the difference between the actual and the predicted values of the model. The lesser is the difference, the better the model is. Thus, the RMSE value should be lower for a model to have performed better. In this case, the ARIMA model has lesser RMSE so it outperforms the prophet model.
       
## FORECASTING USING ARIMA MODEL (FOR VOLUME)
![image](https://user-images.githubusercontent.com/38343820/173665532-7cfb7e9a-75fe-404e-8d66-251e10b69955.png)
## RMSE: 7404.244
## FORECASTING  USING ARIMA MODEL(FOR PRICE)
![image](https://user-images.githubusercontent.com/38343820/173665577-f3d37413-87df-4e63-be2f-acf64b635285.png)
## RMSE: 1067.921
## PREDICTION USING PROPHET (FOR VOLUME)  RMSE: 8495.901
![image](https://user-images.githubusercontent.com/38343820/173665627-b507987a-253d-43c8-8764-0c9d4c7112d2.png)
## PREDICTION USING PROPHET (FOR PRICE) RMSE: 3988.216 
![image](https://user-images.githubusercontent.com/38343820/173665706-743d8aa6-285c-4fba-add4-ee9b2dd8907b.png)

## Results
The study illustrates that according to the ARIMA and the Prophet models, the price of Bitcoin will go up but the volume of the bitcoin will show a downward trend. The market character of the BTC will witness a bearish trend meaning the overall market would see a downward trend. Forecasting these results, ***it would be wise to state that investing in Bitcoin would not be a suitable choice. We can say that because a bearish trend is seen when the price and the volume are showcasing a different trajectory curve in their graphs which apparently in this case they are.***
       ***Both the models produced have proven to be not the best for forecasting the price of Bitcoin and especially the volume of the Bitcoin. The RMSE values for both are very high though are higher for predicting the Volume of Bitcoin. But the Arima model has lower RMSE for both the variables so, we can say that the ARIMA model outperforms the Prophet model. RMSE, the Root Mean Square Error should be less as that demonstrates the square root of the difference between the actual and the predicted values.***
      The plots show 80% and 95% confidence level. The area inside the dark grey region shows an 80% confidence level and the area in the light grey region shows a  95% confidence level. The area where the confidence interval enlarges cannot be much trusted but the area where the confidence interval is narrow can be trusted. As the confidence interval enlarges, the model losses its ability to forecast.
      The plots show both the actual and the predicted values. The black line shows the actual values while the lines in blue show the predicted values. Both, the plots show that the actual and the predicted values follow the same trend.

## Conclusion 

The project is responsible for predicting the price and the volume of the bitcoin data to understand the market character of Bitcoin. It accomplishes the task by using two models namely the ARIMA and the Prophet model. The purpose of this project was to analyze the market character and also find the better model among the two models presented. ***To conclude, we would say that the market shows a bearish character that means that the overall market of the bitcoin will go down even if the price increases because the volume of the bitcoin shows a downward trajectory***. A comparison was made between the two models that showed the same results in general based on the error metric RMSE. ***The error metric clearly stated that the ARIMA model outperformed the Prophet model.***
For future works, models such as the stock to flow model created by Twitter could be researched upon. This model is considered as most accurate and is based on bitcoin scarcity and the halving events of bitcoin. The model has fairly accurately tracked the price of bitcoin in the past. The stock to flow is a number that shows how many years at the current production rate are required to achieve the current stock. The higher the number, the higher the price so the stock to flow model based on scarcity and the production rate of new bitcoin. Apart from this, models like RNN, LSTM  mainly machine learning, or deep learning models could do better as seen in many other research works. Research could also be done on finding better ARIMA models than the one presented in this project.



