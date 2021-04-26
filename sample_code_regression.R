
# Ed Trujillo 
# Sample Code: Regression analysis; Predicting house prices

library(MASS)
library(car)
library(foreign)  
library(corrplot)
library(DescTools)
library(QuantPsyc)
library(leaps)
library(RColorBrewer)
library(Hmisc)
library(psych)

library (magrittr) 
library (dplyr)    
library (reshape2)
library (mosaic) 
library (ggplot2)
library (plyr)
library (fBasics)
library (car)
library (ggpubr)
library (corrplot)
library (GGally)
library (tidyverse)




getwd()
df <- read.csv('housedata.csv', header = T)


# chaging variable types
df$waterfront <- as.factor(df$waterfront) 
df$view       <- as.factor(df$view)
df$zipcode    <- as.factor(df$zipcode)
df$lat        <- as.factor(df$lat)
df$long       <- as.factor(df$long)



# dropping columns
df <- subset(df, select = - c(id,date)) 


# missing values
sum(is.na(df))    
df = na.omit(df) #removing missing values


# z-score scaling 
#--------------------------------------------------------------
df <- df %>% mutate_if(is.numeric, scale) # scaling numeric variables


# filtering out records with z-scores above 3 and below -3
df <- subset(df,df$price         <= 3 & df$price         >= -3)
df <- subset(df,df$bedrooms      <= 3 & df$bedrooms      >= -3) 
df <- subset(df,df$sqft_living   <= 3 & df$sqft_living   >= -3) 
df <- subset(df,df$sqft_lot      <= 3 & df$sqft_lot      >= -3) 
df <- subset(df,df$floors        <= 3 & df$floors        >= -3) 
df <- subset(df,df$condition     <= 3 & df$condition     >= -3) 
df <- subset(df,df$grade         <= 3 & df$grade         >= -3) 
df <- subset(df,df$sqft_above    <= 3 & df$sqft_above    >= -3)
df <- subset(df,df$sqft_basement <= 3 & df$sqft_basement >= -3) 
df <- subset(df,df$yr_built      <= 3 & df$yr_built      >= -3) 
df <- subset(df,df$yr_renovated  <= 3 & df$yr_renovated  >= -3) 
df <- subset(df,df$sqft_living15 <= 3 & df$sqft_living15 >= -3) 
df <- subset(df,df$sqft_lot15    <= 3 & df$sqft_lot15    >= -3) 
head(df, 3)

summary(df)



#correlations
#------------------------------------------------------------

M <- cor(  df[ , unlist(lapply(df, is.numeric))  ],  method="spearman"   )  # correlation matrix for only numeric variables 
corrplot(M, method="number")

# dropping highly correlated variables
df <- subset(df, select = - c(sqft_above, sqft_lot15, sqft_living15)) 

# not using zipcode, lat, and lon variables ---easier to look at modeling results
df <- subset(df, select = - c(zipcode, lat, long)) 



# splitting data
#------------------------------------------------------------
set.seed(33)
partition <- sample(2, nrow(df), replace=TRUE, prob = c(0.70, 0.30))
train <- df[partition==1 ,]
test <- df[partition==2 ,]
nrow(train)
nrow(test)



# regression models
#------------------------------------------------------------
m.train = lm(train$price ~ ., data=train)
summary(m.train)
prediction = predict(m.train, test)
#actual = test$X1..Overall.Experience.
#cor(prediction,actual)





# stepwise elimination
#------------------------------------------------------------
# The stepwise approach is useful because it reduces the number of predictors
# can resolve multicollinearity problem and overfitting



# backward elimination
# -----------------------------------
model_full <- lm(price ~ ., data=train)
back_step.train <- stepAIC(model_full, direction="backward")

back_step.train$anova    # display inital and final model
summary(back_step.train) # details about final model; lower AIC is a better




# forward elimination
# ------------------------------------
model_full <- lm(price ~ ., data=train)
model_empty <- lm(price ~ 1, data=train)
forw_step.train <- stepAIC(model_empty, scope=list(upper=model_full, lower=model_empty, direction="forward"))

forw_step.train$anova 
summary(forw_step.train) 




#backward and forward elimination
# ------------------------------------
model_full <- lm(price ~ ., data=train)
model_empty <- lm(price ~ 1, data=train)
bothdirection.train = step(model_empty, scope = list(upper=model_full ), direction="both")

bothdirection.train$anova 
summary(bothdirection.train)



# all models essentially produce the same results
# choosing backforward model to analyze



#residuals for backforward model
#------------------------------------------------------------
hist(bothdirection.train$residuals, breaks=100)   # 1.Normality: 
qqnorm(bothdirection.train$residuals)             # 1.Normality:run set
qqline(bothdirection.train$residuals)             # 1.Normality:run set
plot(bothdirection.train$residuals)               # 2.Homoscedasticity: The residuals have constant variance at every level of x.
sum(bothdirection.train$residuals)                # 3.Sum & mean equals zero:
mean(bothdirection.train$residuals)               # 3.Sum & mean equals zero: 
vif(bothdirection.train)                          # 4.Multicollinearity: VIF > 5: mc maybe present; VIF > 10: mc present
durbinWatsonTest(bothdirection.train)             # 5.Independence: DW statistic  has a value between 0 and 4
                                                  # H0 (null hypothesis): There is no correlation among the residuals.
                                                  # HA (alternative hypothesis): The residuals are autocorrelated.


#residuals -scaling
#------------------------------------------------------------

mean = mean(bothdirection.train$residuals)  
sd = sd(bothdirection.train$residuals)
resid_zscore = (bothdirection.train$residuals - mean)/sd   

hist(resid_zscore, breaks=100)  
qqnorm(resid_zscore)         
qqline(resid_zscore)         


# predicting 
#------------------------------------------------------------
prediction = predict(bothdirection.train, test) # using test dataset for predictions
actual <- test$price
cor(prediction,actual)


