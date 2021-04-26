Sample Code: Regression analysis; Predicting house prices
================
Ed Trujillo

    ## Loading required package: carData

    ## corrplot 0.84 loaded

    ## 
    ## Attaching package: 'DescTools'

    ## The following object is masked from 'package:car':
    ## 
    ##     Recode

    ## Loading required package: boot

    ## 
    ## Attaching package: 'boot'

    ## The following object is masked from 'package:car':
    ## 
    ##     logit

    ## 
    ## Attaching package: 'QuantPsyc'

    ## The following objects are masked from 'package:DescTools':
    ## 
    ##     Kurt, Skew

    ## The following object is masked from 'package:base':
    ## 
    ##     norm

    ## Loading required package: lattice

    ## 
    ## Attaching package: 'lattice'

    ## The following object is masked from 'package:boot':
    ## 
    ##     melanoma

    ## Loading required package: survival

    ## 
    ## Attaching package: 'survival'

    ## The following object is masked from 'package:boot':
    ## 
    ##     aml

    ## Loading required package: Formula

    ## Loading required package: ggplot2

    ## 
    ## Attaching package: 'Hmisc'

    ## The following objects are masked from 'package:DescTools':
    ## 
    ##     %nin%, Label, Mean, Quantile

    ## The following objects are masked from 'package:base':
    ## 
    ##     format.pval, units

    ## 
    ## Attaching package: 'psych'

    ## The following object is masked from 'package:Hmisc':
    ## 
    ##     describe

    ## The following objects are masked from 'package:ggplot2':
    ## 
    ##     %+%, alpha

    ## The following object is masked from 'package:boot':
    ## 
    ##     logit

    ## The following objects are masked from 'package:DescTools':
    ## 
    ##     AUC, ICC, SD

    ## The following object is masked from 'package:car':
    ## 
    ##     logit

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:Hmisc':
    ## 
    ##     src, summarize

    ## The following object is masked from 'package:car':
    ## 
    ##     recode

    ## The following object is masked from 'package:MASS':
    ## 
    ##     select

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    ## Registered S3 method overwritten by 'mosaic':
    ##   method                           from   
    ##   fortify.SpatialPolygonsDataFrame ggplot2

    ## 
    ## The 'mosaic' package masks several functions from core packages in order to add 
    ## additional features.  The original behavior of these functions should not be affected by this.

    ## 
    ## Attaching package: 'mosaic'

    ## The following object is masked from 'package:Matrix':
    ## 
    ##     mean

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     count, do, tally

    ## The following objects are masked from 'package:psych':
    ## 
    ##     logit, rescale

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     stat

    ## The following object is masked from 'package:boot':
    ## 
    ##     logit

    ## The following object is masked from 'package:DescTools':
    ## 
    ##     MAD

    ## The following objects are masked from 'package:car':
    ## 
    ##     deltaMethod, logit

    ## The following objects are masked from 'package:stats':
    ## 
    ##     binom.test, cor, cor.test, cov, fivenum, IQR, median, prop.test,
    ##     quantile, sd, t.test, var

    ## The following objects are masked from 'package:base':
    ## 
    ##     max, mean, min, prod, range, sample, sum

    ## ------------------------------------------------------------------------------

    ## You have loaded plyr after dplyr - this is likely to cause problems.
    ## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
    ## library(plyr); library(dplyr)

    ## ------------------------------------------------------------------------------

    ## 
    ## Attaching package: 'plyr'

    ## The following object is masked from 'package:mosaic':
    ## 
    ##     count

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     arrange, count, desc, failwith, id, mutate, rename, summarise,
    ##     summarize

    ## The following objects are masked from 'package:Hmisc':
    ## 
    ##     is.discrete, summarize

    ## Loading required package: timeDate

    ## Loading required package: timeSeries

    ## 
    ## Attaching package: 'timeSeries'

    ## The following object is masked from 'package:psych':
    ## 
    ##     outlier

    ## 
    ## Attaching package: 'fBasics'

    ## The following object is masked from 'package:psych':
    ## 
    ##     tr

    ## The following object is masked from 'package:car':
    ## 
    ##     densityPlot

    ## 
    ## Attaching package: 'ggpubr'

    ## The following object is masked from 'package:plyr':
    ## 
    ##     mutate

    ## Registered S3 method overwritten by 'GGally':
    ##   method from   
    ##   +.gg   ggplot2

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v tibble  3.1.1     v purrr   0.3.4
    ## v tidyr   1.1.3     v stringr 1.4.0
    ## v readr   1.4.0     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x psych::%+%()               masks ggplot2::%+%()
    ## x psych::alpha()             masks ggplot2::alpha()
    ## x plyr::arrange()            masks dplyr::arrange()
    ## x purrr::compact()           masks plyr::compact()
    ## x plyr::count()              masks mosaic::count(), dplyr::count()
    ## x purrr::cross()             masks mosaic::cross()
    ## x mosaic::do()               masks dplyr::do()
    ## x tidyr::expand()            masks Matrix::expand()
    ## x tidyr::extract()           masks magrittr::extract()
    ## x plyr::failwith()           masks dplyr::failwith()
    ## x timeSeries::filter()       masks dplyr::filter(), stats::filter()
    ## x ggstance::geom_errorbarh() masks ggplot2::geom_errorbarh()
    ## x plyr::id()                 masks dplyr::id()
    ## x timeSeries::lag()          masks dplyr::lag(), stats::lag()
    ## x ggpubr::mutate()           masks plyr::mutate(), dplyr::mutate()
    ## x tidyr::pack()              masks Matrix::pack()
    ## x dplyr::recode()            masks car::recode()
    ## x plyr::rename()             masks dplyr::rename()
    ## x dplyr::select()            masks MASS::select()
    ## x purrr::set_names()         masks magrittr::set_names()
    ## x purrr::some()              masks car::some()
    ## x dplyr::src()               masks Hmisc::src()
    ## x mosaic::stat()             masks ggplot2::stat()
    ## x plyr::summarise()          masks dplyr::summarise()
    ## x plyr::summarize()          masks dplyr::summarize(), Hmisc::summarize()
    ## x mosaic::tally()            masks dplyr::tally()
    ## x tidyr::unpack()            masks Matrix::unpack()

``` r
# obtaning dataset
df <- read.csv('housedata.csv', header = T)
head(df,5)
```

    ##           id            date  price bedrooms bathrooms sqft_living sqft_lot
    ## 1 7129300520 20141013T000000 221900        3      1.00        1180     5650
    ## 2 6414100192 20141209T000000 538000        3      2.25        2570     7242
    ## 3 5631500400 20150225T000000 180000        2      1.00         770    10000
    ## 4 2487200875 20141209T000000 604000        4      3.00        1960     5000
    ## 5 1954400510 20150218T000000 510000        3      2.00        1680     8080
    ##   floors waterfront view condition grade sqft_above sqft_basement yr_built
    ## 1      1          0    0         3     7       1180             0     1955
    ## 2      2          0    0         3     7       2170           400     1951
    ## 3      1          0    0         3     6        770             0     1933
    ## 4      1          0    0         5     7       1050           910     1965
    ## 5      1          0    0         3     8       1680             0     1987
    ##   yr_renovated zipcode     lat     long sqft_living15 sqft_lot15
    ## 1            0   98178 47.5112 -122.257          1340       5650
    ## 2         1991   98125 47.7210 -122.319          1690       7639
    ## 3            0   98028 47.7379 -122.233          2720       8062
    ## 4            0   98136 47.5208 -122.393          1360       5000
    ## 5            0   98074 47.6168 -122.045          1800       7503

``` r
# chaging variable types
df$waterfront <- as.factor(df$waterfront) 
df$view       <- as.factor(df$view)
df$zipcode    <- as.factor(df$zipcode)
df$lat        <- as.factor(df$lat)
df$long       <- as.factor(df$long)
```

``` r
# dropping columns
df <- subset(df, select = - c(id,date)) 


# missing values
sum(is.na(df))    
```

    ## [1] 0

``` r
df = na.omit(df) #removing missing values
```

``` r
# z-score scaling 
#--------------------------------------------------------------
df <- df %>% mutate_if(is.numeric, scale) # scaling numeric variables
```

``` r
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
head(df, 5)
```

    ##         price   bedrooms   bathrooms sqft_living   sqft_lot     floors
    ## 1 -0.87951535 -0.4098577 -1.44850417  -0.9809155 -0.3125873 -0.8637988
    ## 3 -1.00284167 -1.5830608 -1.44850417  -1.4424447 -0.1624583 -0.8637988
    ## 4  0.24513822  0.7633453  1.32164307  -0.1028843 -0.3350204 -0.8637988
    ## 5 -0.03153657 -0.4098577 -0.06343055  -0.4180750 -0.2287222 -0.8637988
    ## 7 -0.77473213 -0.4098577  0.28283786  -0.3786762 -0.2722423  1.0688664
    ##   waterfront view  condition      grade  sqft_above sqft_basement   yr_built
    ## 1          0    0 -0.6736044 -0.5217437 -0.72138787    -0.6677351 -0.4975434
    ## 3          0    0 -0.6736044 -1.3832676 -1.24006866    -0.6677351 -1.2777238
    ## 4          0    0  2.2269594 -0.5217437 -0.88584763     1.3498985 -0.1429159
    ## 5          0    0 -0.6736044  0.3397802 -0.08885031    -0.6677351  0.6372645
    ## 7          0    0 -0.6736044 -0.5217437 -0.04457269    -0.6677351  0.9209664
    ##   yr_renovated zipcode     lat     long sqft_living15 sqft_lot15
    ## 1   -0.2067647   98178 47.5112 -122.257    -0.9643524 -0.3127060
    ## 3   -0.2067647   98028 47.7379 -122.233     1.0931274 -0.2166337
    ## 4   -0.2067647   98136 47.5208 -122.393    -0.9345339 -0.3385962
    ## 5   -0.2067647   98074 47.6168 -122.045    -0.2785258 -0.2388992
    ## 7   -0.2067647   98003 47.3097 -122.327     0.3745004 -0.2661436

``` r
summary(df)
```

    ##        price.V1           bedrooms.V1          bathrooms.V1    
    ##  Min.   :-1.1500091   Min.   :-2.7562638   Min.   :-1.7947726  
    ##  1st Qu.:-0.6512587   1st Qu.:-0.4098577   1st Qu.:-0.7559674  
    ##  Median :-0.2993813   Median :-0.4098577   Median :-0.0634305  
    ##  Mean   :-0.1515717   Mean   :-0.0515661   Mean   :-0.0797302  
    ##  3rd Qu.: 0.1892146   3rd Qu.: 0.7633453   3rd Qu.: 0.6291063  
    ##  Max.   : 2.8529452   Max.   : 1.9365484   Max.   : 3.0529851  
    ##                                                                
    ##     sqft_living.V1        sqft_lot.V1           floors.V1       waterfront
    ##  Min.   :-1.8814604   Min.   :-0.4851839   Min.   :-0.8637988   0:868     
    ##  1st Qu.:-0.7332657   1st Qu.:-0.3197832   1st Qu.:-0.8637988   1:  3     
    ##  Median :-0.2267092   Median :-0.2390759   Median :-0.8637988             
    ##  Mean   :-0.1240435   Mean   :-0.1546726   Mean   :-0.0771974             
    ##  3rd Qu.: 0.3699017   3rd Qu.:-0.1434075   3rd Qu.: 1.0688664             
    ##  Max.   : 2.6325206   Max.   : 2.7469386   Max.   : 2.0351991             
    ##                                                                           
    ##  view        condition.V1           grade.V1          sqft_above.V1    
    ##  0:802   Min.   :-2.1238863   Min.   :-2.2447915   Min.   :-1.7334479  
    ##  1: 10   1st Qu.:-0.6736044   1st Qu.:-0.5217437   1st Qu.:-0.7466894  
    ##  2: 34   Median :-0.6736044   Median :-0.5217437   Median :-0.3165638  
    ##  3: 19   Mean   : 0.0357183   Mean   :-0.0805960   Mean   :-0.0991481  
    ##  4:  6   3rd Qu.: 0.7766775   3rd Qu.: 0.3397802   3rd Qu.: 0.3602513  
    ##          Max.   : 2.2269594   Max.   : 2.9243519   Max.   : 2.9979329  
    ##                                                                        
    ##    sqft_basement.V1       yr_built.V1         yr_renovated.V1       zipcode   
    ##  Min.   :-0.6677351   Min.   :-2.4479944   Min.   :-0.20676469   98038  : 33  
    ##  1st Qu.:-0.6677351   1st Qu.:-0.5684689   1st Qu.:-0.20676469   98023  : 29  
    ##  Median :-0.6677351   Median : 0.1762488   Median :-0.20676469   98042  : 27  
    ##  Mean   :-0.0705526   Mean   : 0.0154246   Mean   :-0.20676469   98052  : 26  
    ##  3rd Qu.: 0.5073702   3rd Qu.: 0.7791154   3rd Qu.:-0.20676469   98058  : 26  
    ##  Max.   : 2.9240962   Max.   : 1.5947586   Max.   :-0.20676469   98006  : 24  
    ##                                                                  (Other):706  
    ##       lat            long       sqft_living15.V1      sqft_lot15.V1    
    ##  47.7073:  4   -122.191:  8   Min.   :-1.7247254   Min.   :-0.5114626  
    ##  47.3608:  3   -122.188:  8   1st Qu.:-0.7705319   1st Qu.:-0.3223053  
    ##  47.3663:  3   -122.372:  7   Median :-0.2487073   Median :-0.2258745  
    ##  47.4802:  3   -122.371:  7   Mean   :-0.0883188   Mean   :-0.1442715  
    ##  47.6597:  3   -122.198:  7   3rd Qu.: 0.4520286   3rd Qu.:-0.1393616  
    ##  47.3122:  2   -122.353:  6   Max.   : 2.8971495   Max.   : 2.6527103  
    ##  (Other):853   (Other) :828

``` r
#correlations
#------------------------------------------------------------

M <- cor(  df[ , unlist(lapply(df, is.numeric))  ],  method="spearman"   )  # correlation matrix for only numeric variables 
```

    ## Warning in stats::cor(x, y, ...): the standard deviation is zero

``` r
corrplot(M, method="number")
```

![](sample_code_regression_files/figure-markdown_github/unnamed-chunk-8-1.png)

``` r
# dropping highly correlated variables
df <- subset(df, select = - c(sqft_above, sqft_lot15, sqft_living15)) 
```

``` r
# not using zipcode, lat, and lon variables ---easier to look at modeling results
df <- subset(df, select = - c(zipcode, lat, long)) 
```

``` r
# splitting data
#------------------------------------------------------------
set.seed(33)
partition <- sample(2, nrow(df), replace=TRUE, prob = c(0.70, 0.30))
train <- df[partition==1 ,]
test <- df[partition==2 ,]
print('Number of records for training and test set')
```

    ## [1] "Number of records for training and test set"

``` r
nrow(train)
```

    ## [1] 621

``` r
nrow(test)
```

    ## [1] 250

``` r
# regression models
# predicting home price values
#------------------------------------------------------------
m.train = lm(train$price ~ ., data=train)
summary(m.train)
```

    ## 
    ## Call:
    ## lm(formula = train$price ~ ., data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.29639 -0.28926 -0.01744  0.24562  2.21372 
    ## 
    ## Coefficients: (1 not defined because of singularities)
    ##                 Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   -9.168e-02  2.034e-02  -4.508 7.86e-06 ***
    ## bedrooms      -6.579e-02  2.418e-02  -2.722  0.00669 ** 
    ## bathrooms      6.794e-02  3.242e-02   2.096  0.03650 *  
    ## sqft_living    3.264e-01  4.421e-02   7.384 5.11e-13 ***
    ## sqft_lot      -8.373e-02  5.413e-02  -1.547  0.12240    
    ## floors         2.956e-02  2.857e-02   1.035  0.30131    
    ## waterfront1    5.480e-01  2.695e-01   2.034  0.04243 *  
    ## view1          3.102e-01  1.646e-01   1.885  0.05996 .  
    ## view2          9.202e-03  9.321e-02   0.099  0.92139    
    ## view3          2.576e-01  1.134e-01   2.272  0.02346 *  
    ## view4          5.724e-01  2.273e-01   2.518  0.01207 *  
    ## condition      7.629e-03  1.933e-02   0.395  0.69329    
    ## grade          3.913e-01  3.128e-02  12.510  < 2e-16 ***
    ## sqft_basement  1.996e-05  2.812e-02   0.001  0.99943    
    ## yr_built      -2.961e-01  2.431e-02 -12.179  < 2e-16 ***
    ## yr_renovated          NA         NA      NA       NA    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4272 on 606 degrees of freedom
    ## Multiple R-squared:  0.6197, Adjusted R-squared:  0.6109 
    ## F-statistic: 70.54 on 14 and 606 DF,  p-value: < 2.2e-16

# stepwise elimination

# ------------------------------------------------------------

# The stepwise approach is useful because it reduces the number of predictors

# can resolve multicollinearity problem and overfitting

``` r
# backward elimination
# -----------------------------------
model_full <- lm(price ~ ., data=train)
back_step.train <- stepAIC(model_full, direction="backward")
```

    ## Start:  AIC=-1041.63
    ## price ~ bedrooms + bathrooms + sqft_living + sqft_lot + floors + 
    ##     waterfront + view + condition + grade + sqft_basement + yr_built + 
    ##     yr_renovated
    ## 
    ## 
    ## Step:  AIC=-1041.63
    ## price ~ bedrooms + bathrooms + sqft_living + sqft_lot + floors + 
    ##     waterfront + view + condition + grade + sqft_basement + yr_built
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## - sqft_basement  1    0.0000 110.57 -1043.63
    ## - condition      1    0.0284 110.60 -1043.47
    ## - floors         1    0.1953 110.77 -1042.53
    ## <none>                       110.57 -1041.63
    ## - sqft_lot       1    0.4366 111.01 -1041.18
    ## - waterfront     1    0.7546 111.33 -1039.40
    ## - bathrooms      1    0.8016 111.38 -1039.14
    ## - bedrooms       1    1.3514 111.92 -1036.08
    ## - view           4    2.5527 113.13 -1035.45
    ## - sqft_living    1    9.9478 120.52  -990.13
    ## - yr_built       1   27.0629 137.64  -907.67
    ## - grade          1   28.5569 139.13  -900.96
    ## 
    ## Step:  AIC=-1043.63
    ## price ~ bedrooms + bathrooms + sqft_living + sqft_lot + floors + 
    ##     waterfront + view + condition + grade + yr_built
    ## 
    ##               Df Sum of Sq    RSS      AIC
    ## - condition    1    0.0286 110.60 -1045.47
    ## - floors       1    0.2735 110.85 -1044.09
    ## <none>                     110.57 -1043.63
    ## - sqft_lot     1    0.4493 111.02 -1043.11
    ## - waterfront   1    0.7552 111.33 -1041.40
    ## - bathrooms    1    0.8494 111.42 -1040.88
    ## - bedrooms     1    1.3541 111.93 -1038.07
    ## - view         4    2.5607 113.14 -1037.41
    ## - sqft_living  1   12.1171 122.69  -981.05
    ## - yr_built     1   27.6842 138.26  -906.87
    ## - grade        1   29.2703 139.84  -899.79
    ## 
    ## Step:  AIC=-1045.47
    ## price ~ bedrooms + bathrooms + sqft_living + sqft_lot + floors + 
    ##     waterfront + view + grade + yr_built
    ## 
    ##               Df Sum of Sq    RSS      AIC
    ## - floors       1     0.251 110.85 -1046.06
    ## <none>                     110.60 -1045.47
    ## - sqft_lot     1     0.444 111.05 -1044.98
    ## - waterfront   1     0.782 111.38 -1043.09
    ## - bathrooms    1     0.907 111.51 -1042.40
    ## - bedrooms     1     1.350 111.95 -1039.93
    ## - view         4     2.630 113.23 -1038.87
    ## - sqft_living  1    12.203 122.81  -982.48
    ## - grade        1    29.265 139.87  -901.69
    ## - yr_built     1    31.698 142.30  -890.98
    ## 
    ## Step:  AIC=-1046.06
    ## price ~ bedrooms + bathrooms + sqft_living + sqft_lot + waterfront + 
    ##     view + grade + yr_built
    ## 
    ##               Df Sum of Sq    RSS      AIC
    ## <none>                     110.85 -1046.06
    ## - sqft_lot     1    0.5649 111.42 -1044.90
    ## - waterfront   1    0.8079 111.66 -1043.55
    ## - bathrooms    1    1.2103 112.06 -1041.32
    ## - bedrooms     1    1.3215 112.17 -1040.70
    ## - view         4    2.5162 113.37 -1040.12
    ## - sqft_living  1   12.3777 123.23  -982.33
    ## - grade        1   30.8492 141.70  -895.59
    ## - yr_built     1   31.5286 142.38  -892.62

``` r
back_step.train$anova    # display inital and final model
```

    ## Stepwise Model Path 
    ## Analysis of Deviance Table
    ## 
    ## Initial Model:
    ## price ~ bedrooms + bathrooms + sqft_living + sqft_lot + floors + 
    ##     waterfront + view + condition + grade + sqft_basement + yr_built + 
    ##     yr_renovated
    ## 
    ## Final Model:
    ## price ~ bedrooms + bathrooms + sqft_living + sqft_lot + waterfront + 
    ##     view + grade + yr_built
    ## 
    ## 
    ##              Step Df     Deviance Resid. Df Resid. Dev       AIC
    ## 1                                       606   110.5738 -1041.627
    ## 2  - yr_renovated  0 0.000000e+00       606   110.5738 -1041.627
    ## 3 - sqft_basement  1 9.196039e-08       607   110.5738 -1043.627
    ## 4     - condition  1 2.862502e-02       608   110.6024 -1045.467
    ## 5        - floors  1 2.508412e-01       609   110.8533 -1046.060

``` r
summary(back_step.train) # details about final model; lower AIC is a better
```

    ## 
    ## Call:
    ## lm(formula = price ~ bedrooms + bathrooms + sqft_living + sqft_lot + 
    ##     waterfront + view + grade + yr_built, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.29173 -0.29127 -0.01068  0.24492  2.19267 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -0.092117   0.019876  -4.635 4.38e-06 ***
    ## bedrooms    -0.064974   0.024114  -2.694  0.00724 ** 
    ## bathrooms    0.078163   0.030313   2.579  0.01016 *  
    ## sqft_living  0.329242   0.039926   8.246 1.01e-15 ***
    ## sqft_lot    -0.092763   0.052658  -1.762  0.07864 .  
    ## waterfront1  0.564961   0.268172   2.107  0.03555 *  
    ## view1        0.292931   0.163177   1.795  0.07312 .  
    ## view2        0.001002   0.091713   0.011  0.99128    
    ## view3        0.250179   0.111784   2.238  0.02558 *  
    ## view4        0.578374   0.226372   2.555  0.01086 *  
    ## grade        0.396914   0.030489  13.018  < 2e-16 ***
    ## yr_built    -0.295513   0.022454 -13.161  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4266 on 609 degrees of freedom
    ## Multiple R-squared:  0.6187, Adjusted R-squared:  0.6119 
    ## F-statistic: 89.85 on 11 and 609 DF,  p-value: < 2.2e-16

``` r
# forward elimination
# ------------------------------------
model_full <- lm(price ~ ., data=train)
model_empty <- lm(price ~ 1, data=train)
forw_step.train <- stepAIC(model_empty, scope=list(upper=model_full, lower=model_empty, direction="forward"))
```

    ## Start:  AIC=-469.24
    ## price ~ 1
    ## 
    ##                 Df Sum of Sq    RSS     AIC
    ## + grade          1   117.453 173.31 -788.56
    ## + sqft_living    1   117.000 173.76 -786.94
    ## + bathrooms      1    51.498 239.26 -588.29
    ## + floors         1    24.767 265.99 -522.52
    ## + bedrooms       1    22.343 268.42 -516.89
    ## + view           4    21.222 269.54 -508.30
    ## + sqft_basement  1    18.094 272.67 -507.14
    ## + condition      1     3.652 287.11 -475.09
    ## + waterfront     1     2.863 287.90 -473.38
    ## + sqft_lot       1     1.764 289.00 -471.02
    ## <none>                       290.76 -469.24
    ## + yr_built       1     0.001 290.76 -467.24
    ## 
    ## Step:  AIC=-788.56
    ## price ~ grade
    ## 
    ##                 Df Sum of Sq    RSS     AIC
    ## + yr_built       1    33.824 139.48 -921.40
    ## + sqft_living    1    17.851 155.46 -854.07
    ## + sqft_basement  1    10.794 162.51 -826.50
    ## + view           4    12.005 161.30 -825.14
    ## + condition      1     9.042 164.26 -819.84
    ## + waterfront     1     2.548 170.76 -795.76
    ## + bedrooms       1     1.013 172.29 -790.20
    ## <none>                       173.31 -788.56
    ## + bathrooms      1     0.374 172.93 -787.90
    ## + floors         1     0.060 173.25 -786.78
    ## + sqft_lot       1     0.021 173.29 -786.64
    ## - grade          1   117.453 290.76 -469.24
    ## 
    ## Step:  AIC=-921.4
    ## price ~ grade + yr_built
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + sqft_living    1    20.540 118.94 -1018.32
    ## + bathrooms      1    10.138 129.34  -966.26
    ## + view           4     6.963 132.52  -945.20
    ## + sqft_basement  1     4.618 134.87  -940.30
    ## + floors         1     1.935 137.55  -928.07
    ## + waterfront     1     1.803 137.68  -927.48
    ## + bedrooms       1     1.328 138.16  -925.34
    ## + condition      1     1.050 138.43  -924.09
    ## <none>                       139.48  -921.40
    ## + sqft_lot       1     0.002 139.48  -919.41
    ## - yr_built       1    33.824 173.31  -788.56
    ## - grade          1   151.276 290.76  -467.24
    ## 
    ## Step:  AIC=-1018.32
    ## price ~ grade + yr_built + sqft_living
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + view           4     4.411 114.53 -1033.79
    ## + waterfront     1     2.138 116.81 -1027.58
    ## + bedrooms       1     1.469 117.47 -1024.04
    ## + bathrooms      1     1.212 117.73 -1022.68
    ## + sqft_lot       1     0.512 118.43 -1019.00
    ## + floors         1     0.474 118.47 -1018.80
    ## <none>                       118.94 -1018.32
    ## + condition      1     0.215 118.73 -1017.44
    ## + sqft_basement  1     0.017 118.93 -1016.41
    ## - sqft_living    1    20.540 139.48  -921.40
    ## - grade          1    35.471 154.41  -858.24
    ## - yr_built       1    36.513 155.46  -854.07
    ## 
    ## Step:  AIC=-1033.79
    ## price ~ grade + yr_built + sqft_living + view
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + bathrooms      1     1.090 113.44 -1037.73
    ## + bedrooms       1     0.996 113.53 -1037.21
    ## + waterfront     1     0.777 113.75 -1036.02
    ## + floors         1     0.686 113.85 -1035.52
    ## + sqft_lot       1     0.474 114.06 -1034.36
    ## <none>                       114.53 -1033.79
    ## + condition      1     0.036 114.50 -1031.98
    ## + sqft_basement  1     0.012 114.52 -1031.85
    ## - view           4     4.411 118.94 -1018.32
    ## - sqft_living    1    17.987 132.52  -945.20
    ## - yr_built       1    32.156 146.69  -882.12
    ## - grade          1    34.866 149.40  -870.75
    ## 
    ## Step:  AIC=-1037.73
    ## price ~ grade + yr_built + sqft_living + view + bathrooms
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + bedrooms       1     1.425 112.02 -1043.58
    ## + waterfront     1     0.705 112.74 -1039.60
    ## <none>                       113.44 -1037.73
    ## + sqft_lot       1     0.338 113.10 -1037.58
    ## + floors         1     0.336 113.11 -1037.57
    ## + sqft_basement  1     0.040 113.40 -1035.94
    ## + condition      1     0.009 113.43 -1035.78
    ## - bathrooms      1     1.090 114.53 -1033.79
    ## - view           4     4.290 117.73 -1022.68
    ## - sqft_living    1    10.190 123.63  -986.31
    ## - yr_built       1    31.256 144.70  -888.60
    ## - grade          1    33.695 147.14  -878.22
    ## 
    ## Step:  AIC=-1043.58
    ## price ~ grade + yr_built + sqft_living + view + bathrooms + bedrooms
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + waterfront     1     0.598 111.42 -1044.90
    ## + floors         1     0.372 111.64 -1043.64
    ## <none>                       112.02 -1043.58
    ## + sqft_lot       1     0.355 111.66 -1043.55
    ## + sqft_basement  1     0.065 111.95 -1041.94
    ## + condition      1     0.010 112.01 -1041.63
    ## - bedrooms       1     1.425 113.44 -1037.73
    ## - bathrooms      1     1.519 113.53 -1037.21
    ## - view           4     3.691 115.71 -1031.45
    ## - sqft_living    1    11.585 123.60  -984.46
    ## - grade          1    31.362 143.38  -892.29
    ## - yr_built       1    32.274 144.29  -888.35
    ## 
    ## Step:  AIC=-1044.9
    ## price ~ grade + yr_built + sqft_living + view + bathrooms + bedrooms + 
    ##     waterfront
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + sqft_lot       1     0.565 110.85 -1046.06
    ## + floors         1     0.372 111.05 -1044.98
    ## <none>                       111.42 -1044.90
    ## - waterfront     1     0.598 112.02 -1043.58
    ## + sqft_basement  1     0.049 111.37 -1043.17
    ## + condition      1     0.001 111.42 -1042.91
    ## - bedrooms       1     1.318 112.74 -1039.60
    ## - bathrooms      1     1.422 112.84 -1039.03
    ## - view           4     2.656 114.07 -1038.27
    ## - sqft_living    1    11.827 123.25  -984.25
    ## - grade          1    31.003 142.42  -894.45
    ## - yr_built       1    32.077 143.50  -889.79
    ## 
    ## Step:  AIC=-1046.06
    ## price ~ grade + yr_built + sqft_living + view + bathrooms + bedrooms + 
    ##     waterfront + sqft_lot
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## <none>                       110.85 -1046.06
    ## + floors         1    0.2508 110.60 -1045.47
    ## - sqft_lot       1    0.5649 111.42 -1044.90
    ## + sqft_basement  1    0.0691 110.78 -1044.45
    ## + condition      1    0.0059 110.85 -1044.09
    ## - waterfront     1    0.8079 111.66 -1043.55
    ## - bathrooms      1    1.2103 112.06 -1041.32
    ## - bedrooms       1    1.3215 112.17 -1040.70
    ## - view           4    2.5162 113.37 -1040.12
    ## - sqft_living    1   12.3777 123.23  -982.33
    ## - grade          1   30.8492 141.70  -895.59
    ## - yr_built       1   31.5286 142.38  -892.62

``` r
forw_step.train$anova 
```

    ## Stepwise Model Path 
    ## Analysis of Deviance Table
    ## 
    ## Initial Model:
    ## price ~ 1
    ## 
    ## Final Model:
    ## price ~ grade + yr_built + sqft_living + view + bathrooms + bedrooms + 
    ##     waterfront + sqft_lot
    ## 
    ## 
    ##            Step Df    Deviance Resid. Df Resid. Dev        AIC
    ## 1                                    620   290.7596  -469.2361
    ## 2       + grade  1 117.4530268       619   173.3065  -788.5631
    ## 3    + yr_built  1  33.8238300       618   139.4827  -921.3954
    ## 4 + sqft_living  1  20.5398485       617   118.9429 -1018.3191
    ## 5        + view  4   4.4110237       613   114.5318 -1033.7870
    ## 6   + bathrooms  1   1.0901728       612   113.4417 -1037.7263
    ## 7    + bedrooms  1   1.4252848       611   112.0164 -1043.5780
    ## 8  + waterfront  1   0.5982552       610   111.4181 -1044.9035
    ## 9    + sqft_lot  1   0.5648716       609   110.8533 -1046.0599

``` r
summary(forw_step.train) 
```

    ## 
    ## Call:
    ## lm(formula = price ~ grade + yr_built + sqft_living + view + 
    ##     bathrooms + bedrooms + waterfront + sqft_lot, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.29173 -0.29127 -0.01068  0.24492  2.19267 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -0.092117   0.019876  -4.635 4.38e-06 ***
    ## grade        0.396914   0.030489  13.018  < 2e-16 ***
    ## yr_built    -0.295513   0.022454 -13.161  < 2e-16 ***
    ## sqft_living  0.329242   0.039926   8.246 1.01e-15 ***
    ## view1        0.292931   0.163177   1.795  0.07312 .  
    ## view2        0.001002   0.091713   0.011  0.99128    
    ## view3        0.250179   0.111784   2.238  0.02558 *  
    ## view4        0.578374   0.226372   2.555  0.01086 *  
    ## bathrooms    0.078163   0.030313   2.579  0.01016 *  
    ## bedrooms    -0.064974   0.024114  -2.694  0.00724 ** 
    ## waterfront1  0.564961   0.268172   2.107  0.03555 *  
    ## sqft_lot    -0.092763   0.052658  -1.762  0.07864 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4266 on 609 degrees of freedom
    ## Multiple R-squared:  0.6187, Adjusted R-squared:  0.6119 
    ## F-statistic: 89.85 on 11 and 609 DF,  p-value: < 2.2e-16

``` r
#backward and forward elimination
# ------------------------------------
model_full <- lm(price ~ ., data=train)
model_empty <- lm(price ~ 1, data=train)
bothdirection.train = step(model_empty, scope = list(upper=model_full ), direction="both")
```

    ## Start:  AIC=-469.24
    ## price ~ 1
    ## 
    ##                 Df Sum of Sq    RSS     AIC
    ## + grade          1   117.453 173.31 -788.56
    ## + sqft_living    1   117.000 173.76 -786.94
    ## + bathrooms      1    51.498 239.26 -588.29
    ## + floors         1    24.767 265.99 -522.52
    ## + bedrooms       1    22.343 268.42 -516.89
    ## + view           4    21.222 269.54 -508.30
    ## + sqft_basement  1    18.094 272.67 -507.14
    ## + condition      1     3.652 287.11 -475.09
    ## + waterfront     1     2.863 287.90 -473.38
    ## + sqft_lot       1     1.764 289.00 -471.02
    ## <none>                       290.76 -469.24
    ## + yr_built       1     0.001 290.76 -467.24
    ## 
    ## Step:  AIC=-788.56
    ## price ~ grade
    ## 
    ##                 Df Sum of Sq    RSS     AIC
    ## + yr_built       1    33.824 139.48 -921.40
    ## + sqft_living    1    17.851 155.46 -854.07
    ## + sqft_basement  1    10.794 162.51 -826.50
    ## + view           4    12.005 161.30 -825.14
    ## + condition      1     9.042 164.26 -819.84
    ## + waterfront     1     2.548 170.76 -795.76
    ## + bedrooms       1     1.013 172.29 -790.20
    ## <none>                       173.31 -788.56
    ## + bathrooms      1     0.374 172.93 -787.90
    ## + floors         1     0.060 173.25 -786.78
    ## + sqft_lot       1     0.021 173.29 -786.64
    ## - grade          1   117.453 290.76 -469.24
    ## 
    ## Step:  AIC=-921.4
    ## price ~ grade + yr_built
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + sqft_living    1    20.540 118.94 -1018.32
    ## + bathrooms      1    10.138 129.34  -966.26
    ## + view           4     6.963 132.52  -945.20
    ## + sqft_basement  1     4.618 134.87  -940.30
    ## + floors         1     1.935 137.55  -928.07
    ## + waterfront     1     1.803 137.68  -927.48
    ## + bedrooms       1     1.328 138.16  -925.34
    ## + condition      1     1.050 138.43  -924.09
    ## <none>                       139.48  -921.40
    ## + sqft_lot       1     0.002 139.48  -919.41
    ## - yr_built       1    33.824 173.31  -788.56
    ## - grade          1   151.276 290.76  -467.24
    ## 
    ## Step:  AIC=-1018.32
    ## price ~ grade + yr_built + sqft_living
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + view           4     4.411 114.53 -1033.79
    ## + waterfront     1     2.138 116.81 -1027.58
    ## + bedrooms       1     1.469 117.47 -1024.04
    ## + bathrooms      1     1.212 117.73 -1022.68
    ## + sqft_lot       1     0.512 118.43 -1019.00
    ## + floors         1     0.474 118.47 -1018.80
    ## <none>                       118.94 -1018.32
    ## + condition      1     0.215 118.73 -1017.44
    ## + sqft_basement  1     0.017 118.93 -1016.41
    ## - sqft_living    1    20.540 139.48  -921.40
    ## - grade          1    35.471 154.41  -858.24
    ## - yr_built       1    36.513 155.46  -854.07
    ## 
    ## Step:  AIC=-1033.79
    ## price ~ grade + yr_built + sqft_living + view
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + bathrooms      1     1.090 113.44 -1037.73
    ## + bedrooms       1     0.996 113.53 -1037.21
    ## + waterfront     1     0.777 113.75 -1036.02
    ## + floors         1     0.686 113.85 -1035.52
    ## + sqft_lot       1     0.474 114.06 -1034.36
    ## <none>                       114.53 -1033.79
    ## + condition      1     0.036 114.50 -1031.98
    ## + sqft_basement  1     0.012 114.52 -1031.85
    ## - view           4     4.411 118.94 -1018.32
    ## - sqft_living    1    17.987 132.52  -945.20
    ## - yr_built       1    32.156 146.69  -882.12
    ## - grade          1    34.866 149.40  -870.75
    ## 
    ## Step:  AIC=-1037.73
    ## price ~ grade + yr_built + sqft_living + view + bathrooms
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + bedrooms       1     1.425 112.02 -1043.58
    ## + waterfront     1     0.705 112.74 -1039.60
    ## <none>                       113.44 -1037.73
    ## + sqft_lot       1     0.338 113.10 -1037.58
    ## + floors         1     0.336 113.11 -1037.57
    ## + sqft_basement  1     0.040 113.40 -1035.94
    ## + condition      1     0.009 113.43 -1035.78
    ## - bathrooms      1     1.090 114.53 -1033.79
    ## - view           4     4.290 117.73 -1022.68
    ## - sqft_living    1    10.190 123.63  -986.31
    ## - yr_built       1    31.256 144.70  -888.60
    ## - grade          1    33.695 147.14  -878.22
    ## 
    ## Step:  AIC=-1043.58
    ## price ~ grade + yr_built + sqft_living + view + bathrooms + bedrooms
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + waterfront     1     0.598 111.42 -1044.90
    ## + floors         1     0.372 111.64 -1043.64
    ## <none>                       112.02 -1043.58
    ## + sqft_lot       1     0.355 111.66 -1043.55
    ## + sqft_basement  1     0.065 111.95 -1041.94
    ## + condition      1     0.010 112.01 -1041.63
    ## - bedrooms       1     1.425 113.44 -1037.73
    ## - bathrooms      1     1.519 113.53 -1037.21
    ## - view           4     3.691 115.71 -1031.45
    ## - sqft_living    1    11.585 123.60  -984.46
    ## - grade          1    31.362 143.38  -892.29
    ## - yr_built       1    32.274 144.29  -888.35
    ## 
    ## Step:  AIC=-1044.9
    ## price ~ grade + yr_built + sqft_living + view + bathrooms + bedrooms + 
    ##     waterfront
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## + sqft_lot       1     0.565 110.85 -1046.06
    ## + floors         1     0.372 111.05 -1044.98
    ## <none>                       111.42 -1044.90
    ## - waterfront     1     0.598 112.02 -1043.58
    ## + sqft_basement  1     0.049 111.37 -1043.17
    ## + condition      1     0.001 111.42 -1042.91
    ## - bedrooms       1     1.318 112.74 -1039.60
    ## - bathrooms      1     1.422 112.84 -1039.03
    ## - view           4     2.656 114.07 -1038.27
    ## - sqft_living    1    11.827 123.25  -984.25
    ## - grade          1    31.003 142.42  -894.45
    ## - yr_built       1    32.077 143.50  -889.79
    ## 
    ## Step:  AIC=-1046.06
    ## price ~ grade + yr_built + sqft_living + view + bathrooms + bedrooms + 
    ##     waterfront + sqft_lot
    ## 
    ##                 Df Sum of Sq    RSS      AIC
    ## <none>                       110.85 -1046.06
    ## + floors         1    0.2508 110.60 -1045.47
    ## - sqft_lot       1    0.5649 111.42 -1044.90
    ## + sqft_basement  1    0.0691 110.78 -1044.45
    ## + condition      1    0.0059 110.85 -1044.09
    ## - waterfront     1    0.8079 111.66 -1043.55
    ## - bathrooms      1    1.2103 112.06 -1041.32
    ## - bedrooms       1    1.3215 112.17 -1040.70
    ## - view           4    2.5162 113.37 -1040.12
    ## - sqft_living    1   12.3777 123.23  -982.33
    ## - grade          1   30.8492 141.70  -895.59
    ## - yr_built       1   31.5286 142.38  -892.62

``` r
bothdirection.train$anova 
```

    ##            Step Df    Deviance Resid. Df Resid. Dev        AIC
    ## 1               NA          NA       620   290.7596  -469.2361
    ## 2       + grade -1 117.4530268       619   173.3065  -788.5631
    ## 3    + yr_built -1  33.8238300       618   139.4827  -921.3954
    ## 4 + sqft_living -1  20.5398485       617   118.9429 -1018.3191
    ## 5        + view -4   4.4110237       613   114.5318 -1033.7870
    ## 6   + bathrooms -1   1.0901728       612   113.4417 -1037.7263
    ## 7    + bedrooms -1   1.4252848       611   112.0164 -1043.5780
    ## 8  + waterfront -1   0.5982552       610   111.4181 -1044.9035
    ## 9    + sqft_lot -1   0.5648716       609   110.8533 -1046.0599

``` r
summary(bothdirection.train)
```

    ## 
    ## Call:
    ## lm(formula = price ~ grade + yr_built + sqft_living + view + 
    ##     bathrooms + bedrooms + waterfront + sqft_lot, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.29173 -0.29127 -0.01068  0.24492  2.19267 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -0.092117   0.019876  -4.635 4.38e-06 ***
    ## grade        0.396914   0.030489  13.018  < 2e-16 ***
    ## yr_built    -0.295513   0.022454 -13.161  < 2e-16 ***
    ## sqft_living  0.329242   0.039926   8.246 1.01e-15 ***
    ## view1        0.292931   0.163177   1.795  0.07312 .  
    ## view2        0.001002   0.091713   0.011  0.99128    
    ## view3        0.250179   0.111784   2.238  0.02558 *  
    ## view4        0.578374   0.226372   2.555  0.01086 *  
    ## bathrooms    0.078163   0.030313   2.579  0.01016 *  
    ## bedrooms    -0.064974   0.024114  -2.694  0.00724 ** 
    ## waterfront1  0.564961   0.268172   2.107  0.03555 *  
    ## sqft_lot    -0.092763   0.052658  -1.762  0.07864 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4266 on 609 degrees of freedom
    ## Multiple R-squared:  0.6187, Adjusted R-squared:  0.6119 
    ## F-statistic: 89.85 on 11 and 609 DF,  p-value: < 2.2e-16

# all regression models essentially produce the same results

# choosing backforward model to analyze

# waterfront is the strongest predictor with a beta coefficient of 0.56

# followed by view 4 with 0.57 (other view levels have weaker beta coefficients)

``` r
# all regression models essentially produce the same results
# choosing backforward model to analyze

# waterfront is the strongest predictor with a beta coefficient of 0.56
# followed by view 4 with 0.57 (other view levels have weaker beta coefficients)
```

``` r
#residuals for backforward model
#------------------------------------------------------------
hist(bothdirection.train$residuals, breaks=100)  # 1.Normality: 
```

![](sample_code_regression_files/figure-markdown_github/unnamed-chunk-16-1.png)

``` r
qqnorm(bothdirection.train$residuals)            # 1.Normality:run set
qqline(bothdirection.train$residuals)            # 1.Normality:run set
```

![](sample_code_regression_files/figure-markdown_github/unnamed-chunk-16-2.png)

``` r
plot(bothdirection.train$residuals)              # 2.Homoscedasticity
```

![](sample_code_regression_files/figure-markdown_github/unnamed-chunk-16-3.png)

``` r
sum(bothdirection.train$residuals)               # 3.Sum & mean equals zero:
```

    ## [1] 4.320329e-15

``` r
mean(bothdirection.train$residuals)              # 3.Sum & mean equals zero: 
```

    ## [1] 6.971673e-18

``` r
vif(bothdirection.train)                         # 4.Multicollinearity: 
```

    ##                 GVIF Df GVIF^(1/(2*Df))
    ## grade       2.480557  1        1.574978
    ## yr_built    1.642615  1        1.281646
    ## sqft_living 3.574459  1        1.890624
    ## view        1.265243  4        1.029845
    ## bathrooms   2.656376  1        1.629839
    ## bedrooms    1.596467  1        1.263514
    ## waterfront  1.179540  1        1.086066
    ## sqft_lot    1.090717  1        1.044374

``` r
durbinWatsonTest(bothdirection.train)            # 5.Independence:
```

    ##  lag Autocorrelation D-W Statistic p-value
    ##    1       0.0431296      1.911739   0.266
    ##  Alternative hypothesis: rho != 0

``` r
# tests are passed
```

``` r
#residuals -scaling
#------------------------------------------------------------

mean = mean(bothdirection.train$residuals)  
sd = sd(bothdirection.train$residuals)
resid_zscore = (bothdirection.train$residuals - mean)/sd   

hist(resid_zscore, breaks=100)  
```

![](sample_code_regression_files/figure-markdown_github/unnamed-chunk-17-1.png)

``` r
qqnorm(resid_zscore)         
qqline(resid_zscore)         
```

![](sample_code_regression_files/figure-markdown_github/unnamed-chunk-17-2.png)

``` r
# predicting home price values using the training model on the test dataset
#------------------------------------------------------------
prediction = predict(bothdirection.train, test) # using test dataset for predictions
actual <- test$price
cor(prediction,actual) # good results
```

    ##           [,1]
    ## [1,] 0.7765008
