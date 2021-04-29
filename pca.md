Sample Code: Principal Component Analysis (PCA)
================
Ed Trujillo
April 28, 2021

``` r
# obtaining dataset
#--------------------------------------------------------------
setwd('C:/Users/User/Desktop/code_sample/R/pca')
d <- read.csv('GSS_2002_Health_PCA.csv', header = T)
head(d, 5)
```

    ##   X ADHDKNOW DOC16A DOC18A DOC15A GIVBLOOD DOC20A DOCVIG DOCRELY DOCASKME
    ## 1 1        1      1      1      1        6      1      6       7        2
    ## 2 2        1      1      1      1        4      1      1       5        3
    ## 3 3        5      2      2      6        1      2      1       5        2
    ## 4 4        5      2      3      6        1      5      2       7        2
    ## 5 5        5      3      2      3        1      6      2       2        2
    ##   DOCDECID DOCSAT DOCCOSTS HEALTH1 EVCRACK EVIDU HEALTH OUTSIDER DOC19A ILLPHYS
    ## 1        7      6        4       2       3     3      2        1      1       1
    ## 2        4      3        2       4       3     3      3        1      1       1
    ## 3        4      6        5       4       3     3      3        5      3       5
    ## 4        7      4        3       2       3     3      1        3      3       4
    ## 5        7      4        6       4       3     3      3        3      5       5
    ##   IMPRVMED MNTLILL IMPRVEAT ALLERGIC GENEPROB NATHEAL HEALTH30 MEDSYMPS
    ## 1        1       1        1        1        1       2        1        1
    ## 2        1       1        1        1        1       2        1        1
    ## 3        5       5        5        5        5       1        2        3
    ## 4        4       5        3        4        5       3        3        2
    ## 5        5       4        5        5        5       1        1        3
    ##   HLTHFREL HLTHMAG1 HLTHMAG2 HLTHPAPR HLTHWWW HLTHTV HLTHDOC PHYSHLTH MNTLHLTH
    ## 1        1        1        1        1       1      1       1        2        2
    ## 2        1        1        1        1       1      1       1        2        2
    ## 3        3        2        2        2       3      2       3        2       10
    ## 4        2        2        2        2       5      2       2        2        2
    ## 5        3        2        2        2       2      3       3        2       18

``` r
# defining missing values
#--------------------------------------------------------------
#df[df >8] = NA
describe(d)
```

    ##          vars    n    mean     sd median trimmed     mad min  max range  skew
    ## X           1 2765 1383.00 798.33   1383 1383.00 1024.48   1 2765  2764  0.00
    ## ADHDKNOW    2 2765    2.61   1.80      1    2.51    0.00   1    5     4  0.41
    ## DOC16A      3 2765    1.86   1.05      1    1.72    0.00   1    6     5  1.20
    ## DOC18A      4 2765    1.89   1.13      1    1.71    0.00   1    6     5  1.28
    ## DOC15A      5 2765    2.89   2.12      1    2.74    0.00   1    6     5  0.43
    ## GIVBLOOD    6 2765    3.35   2.42      1    3.31    0.00   1    6     5  0.10
    ## DOC20A      7 2765    2.06   1.40      1    1.79    0.00   1    6     5  1.32
    ## DOCVIG      8 2765    3.50   1.71      4    3.50    2.97   1    6     5  0.00
    ## DOCRELY     9 2765    4.73   1.84      5    4.80    2.97   1    7     6 -0.16
    ## DOCASKME   10 2765    2.41   0.85      2    2.22    0.00   1    7     6  2.63
    ## DOCDECID   11 2765    4.48   1.77      4    4.48    1.48   1    7     6  0.10
    ## DOCSAT     12 2765    4.61   1.20      5    4.70    1.48   1    6     5 -0.55
    ## DOCCOSTS   13 2765    4.01   1.37      4    4.04    1.48   1    6     5  0.01
    ## HEALTH1    14 2765    2.98   1.37      3    2.93    1.48   1    6     5  0.16
    ## EVCRACK    15 2765    2.60   0.77      3    2.75    0.00   1    3     2 -1.51
    ## EVIDU      16 2765    2.61   0.78      3    2.77    0.00   1    3     2 -1.55
    ## HEALTH     17 2765    2.32   1.16      2    2.23    1.48   1    5     4  0.38
    ## OUTSIDER   18 2765    2.29   1.49      1    2.12    0.00   1    5     4  0.59
    ## DOC19A     19 2765    1.93   1.16      1    1.74    0.00   1    6     5  1.10
    ## ILLPHYS    20 2765    2.17   1.37      1    1.99    0.00   1    5     4  0.70
    ## IMPRVMED   21 2765    1.96   1.21      1    1.77    0.00   1    5     4  1.03
    ## MNTLILL    22 2765    2.35   1.53      1    2.19    0.00   1    5     4  0.52
    ## IMPRVEAT   23 2765    2.26   1.43      1    2.10    0.00   1    5     4  0.55
    ## ALLERGIC   24 2765    2.23   1.42      1    2.06    0.00   1    5     4  0.62
    ## GENEPROB   25 2765    2.12   1.31      1    1.95    0.00   1    5     4  0.70
    ## NATHEAL    26 2765    1.62   0.74      1    1.51    0.00   1    4     3  1.01
    ## HEALTH30   27 2765    1.66   1.07      1    1.43    0.00   1    5     4  1.66
    ## MEDSYMPS   28 2765    1.89   1.04      1    1.78    0.00   1    5     4  0.74
    ## HLTHFREL   29 2765    1.45   0.93      1    1.22    0.00   1    5     4  2.20
    ## HLTHMAG1   30 2765    1.36   0.76      1    1.17    0.00   1    5     4  2.59
    ## HLTHMAG2   31 2765    1.41   0.86      1    1.18    0.00   1    5     4  2.41
    ## HLTHPAPR   32 2765    1.34   0.74      1    1.17    0.00   1    5     4  2.75
    ## HLTHWWW    33 2765    1.53   1.11      1    1.23    0.00   1    5     4  2.07
    ## HLTHTV     34 2765    1.36   0.77      1    1.17    0.00   1    5     4  2.60
    ## HLTHDOC    35 2765    1.54   1.07      1    1.28    0.00   1    5     4  1.87
    ## PHYSHLTH   36 2765    4.05   5.60      2    2.55    1.48   1   24    23  2.08
    ## MNTLHLTH   37 2765    4.50   6.02      2    3.08    1.48   1   24    23  1.80
    ##          kurtosis    se
    ## X           -1.20 15.18
    ## ADHDKNOW    -1.66  0.03
    ## DOC16A       1.31  0.02
    ## DOC18A       1.33  0.02
    ## DOC15A      -1.59  0.04
    ## GIVBLOOD    -1.94  0.05
    ## DOC20A       0.90  0.03
    ## DOCVIG      -1.27  0.03
    ## DOCRELY     -1.37  0.03
    ## DOCASKME     8.36  0.02
    ## DOCDECID    -1.33  0.03
    ## DOCSAT      -0.29  0.02
    ## DOCCOSTS    -0.99  0.03
    ## HEALTH1     -0.85  0.03
    ## EVCRACK      0.38  0.01
    ## EVIDU        0.47  0.01
    ## HEALTH      -0.81  0.02
    ## OUTSIDER    -1.21  0.03
    ## DOC19A       0.53  0.02
    ## ILLPHYS     -0.96  0.03
    ## IMPRVMED    -0.04  0.02
    ## MNTLILL     -1.34  0.03
    ## IMPRVEAT    -1.20  0.03
    ## ALLERGIC    -1.11  0.03
    ## GENEPROB    -0.82  0.02
    ## NATHEAL      0.44  0.01
    ## HEALTH30     1.94  0.02
    ## MEDSYMPS    -0.52  0.02
    ## HLTHFREL     4.21  0.02
    ## HLTHMAG1     7.12  0.01
    ## HLTHMAG2     5.58  0.02
    ## HLTHPAPR     8.43  0.01
    ## HLTHWWW      3.04  0.02
    ## HLTHTV       7.16  0.01
    ## HLTHDOC      2.36  0.02
    ## PHYSHLTH     2.89  0.11
    ## MNTLHLTH     1.70  0.11

``` r
d[,c(2:35)][     d[,c(2:35)]  == -1  | d[,c(2:35)]  == 8   ] = NA  # these variables missing values are -1, 8, and 9
d[,c(36:37)][    d[,c(36:37)] == -1  | 
                 d[,c(36:37)] == 98  |
                 d[,c(36:37)] == 99  ] = NA  # these variables missing values are -1, 98, and 99
```

``` r
# setting variable types
#--------------------------------------------------------------
d$ADHDKNOW <- as.factor(d$ADHDKNOW)
d$GIVBLOOD <- as.factor(d$GIVBLOOD)
d$DOCVIG   <- as.factor(d$DOCVIG)
d$HEALTH30 <- as.factor(d$HEALTH30)
d$HLTHFREL <- as.factor(d$HLTHFREL)
d$HLTHMAG1 <- as.factor(d$HLTHMAG1)
d$HLTHMAG2 <- as.factor(d$HLTHMAG2)
d$HLTHPAPR <- as.factor(d$HLTHPAPR)
d$HLTHWWW  <- as.factor(d$HLTHWWW)
d$HLTHTV   <- as.factor(d$HLTHTV)
d$HLTHDOC  <- as.factor(d$HLTHDOC)
```

``` r
# z-score scaling 
#--------------------------------------------------------------
d <- d %>% mutate_if(is.numeric, scale)  # scaling numeric variables
```

``` r
# getting only numeric variables
#--------------------------------------------------------------
num_cols <- unlist(lapply(d, is.numeric))
d_quant <- d[ , num_cols]   
describe(d_quant)
```

    ##          vars    n mean sd median trimmed  mad   min  max range  skew kurtosis
    ## X           1 2765    0  1   0.00    0.00 1.28 -1.73 1.73  3.46  0.00    -1.20
    ## DOC16A      2 2765    0  1  -0.82   -0.13 0.00 -0.82 3.95  4.76  1.20     1.31
    ## DOC18A      3 2765    0  1  -0.79   -0.16 0.00 -0.79 3.65  4.44  1.28     1.33
    ## DOC15A      4 2765    0  1  -0.89   -0.07 0.00 -0.89 1.46  2.36  0.43    -1.59
    ## DOC20A      5 2765    0  1  -0.76   -0.20 0.00 -0.76 2.81  3.57  1.32     0.90
    ## DOCRELY     6 2765    0  1   0.15    0.04 1.61 -2.03 1.24  3.27 -0.16    -1.37
    ## DOCASKME    7 2765    0  1  -0.48   -0.23 0.00 -1.66 5.38  7.04  2.63     8.36
    ## DOCDECID    8 2765    0  1  -0.27    0.00 0.84 -1.96 1.42  3.38  0.10    -1.33
    ## DOCSAT      9 2765    0  1   0.33    0.08 1.24 -3.01 1.16  4.17 -0.55    -0.29
    ## DOCCOSTS   10 2765    0  1  -0.01    0.02 1.08 -2.19 1.44  3.64  0.01    -0.99
    ## HEALTH1    11 2765    0  1   0.02   -0.03 1.09 -1.45 2.21  3.66  0.16    -0.85
    ## EVCRACK    12 2765    0  1   0.51    0.19 0.00 -2.07 0.51  2.59 -1.51     0.38
    ## EVIDU      13 2765    0  1   0.50    0.20 0.00 -2.08 0.50  2.58 -1.55     0.47
    ## HEALTH     14 2765    0  1  -0.28   -0.08 1.28 -1.14 2.31  3.46  0.38    -0.81
    ## OUTSIDER   15 2765    0  1  -0.87   -0.12 0.00 -0.87 1.82  2.69  0.59    -1.21
    ## DOC19A     16 2765    0  1  -0.81   -0.17 0.00 -0.81 3.52  4.32  1.10     0.53
    ## ILLPHYS    17 2765    0  1  -0.85   -0.13 0.00 -0.85 2.06  2.91  0.70    -0.96
    ## IMPRVMED   18 2765    0  1  -0.80   -0.16 0.00 -0.80 2.52  3.32  1.03    -0.04
    ## MNTLILL    19 2765    0  1  -0.88   -0.11 0.00 -0.88 1.73  2.61  0.52    -1.34
    ## IMPRVEAT   20 2765    0  1  -0.88   -0.11 0.00 -0.88 1.92  2.80  0.55    -1.20
    ## ALLERGIC   21 2765    0  1  -0.86   -0.12 0.00 -0.86 1.94  2.81  0.62    -1.11
    ## GENEPROB   22 2765    0  1  -0.86   -0.13 0.00 -0.86 2.20  3.05  0.70    -0.82
    ## NATHEAL    23 2765    0  1  -0.84   -0.16 0.00 -0.84 3.20  4.03  1.01     0.44
    ## MEDSYMPS   24 2765    0  1  -0.85   -0.11 0.00 -0.85 2.97  3.83  0.74    -0.52
    ## PHYSHLTH   25 2765    0  1  -0.37   -0.27 0.26 -0.54 3.56  4.11  2.08     2.89
    ## MNTLHLTH   26 2765    0  1  -0.42   -0.24 0.25 -0.58 3.24  3.82  1.80     1.70
    ##            se
    ## X        0.02
    ## DOC16A   0.02
    ## DOC18A   0.02
    ## DOC15A   0.02
    ## DOC20A   0.02
    ## DOCRELY  0.02
    ## DOCASKME 0.02
    ## DOCDECID 0.02
    ## DOCSAT   0.02
    ## DOCCOSTS 0.02
    ## HEALTH1  0.02
    ## EVCRACK  0.02
    ## EVIDU    0.02
    ## HEALTH   0.02
    ## OUTSIDER 0.02
    ## DOC19A   0.02
    ## ILLPHYS  0.02
    ## IMPRVMED 0.02
    ## MNTLILL  0.02
    ## IMPRVEAT 0.02
    ## ALLERGIC 0.02
    ## GENEPROB 0.02
    ## NATHEAL  0.02
    ## MEDSYMPS 0.02
    ## PHYSHLTH 0.02
    ## MNTLHLTH 0.02

``` r
summary(d_quant)
```

    ##          X.V1              DOC16A.V1           DOC18A.V1     
    ##  Min.   :-1.7311114   Min.   :-0.816866   Min.   :-0.794495  
    ##  1st Qu.:-0.8655557   1st Qu.:-0.816866   1st Qu.:-0.794495  
    ##  Median : 0.0000000   Median :-0.816866   Median :-0.794495  
    ##  Mean   : 0.0000000   Mean   : 0.000000   Mean   : 0.000000  
    ##  3rd Qu.: 0.8655557   3rd Qu.: 1.088350   3rd Qu.: 0.982834  
    ##  Max.   : 1.7311114   Max.   : 3.946175   Max.   : 3.648829  
    ##       DOC15A.V1            DOC20A.V1            DOCRELY.V1     
    ##  Min.   :-0.8917595   Min.   :-0.7596835   Min.   :-2.0310624  
    ##  1st Qu.:-0.8917595   1st Qu.:-0.7596835   1st Qu.:-0.9419734  
    ##  Median :-0.8917595   Median :-0.7596835   Median : 0.1471156  
    ##  Mean   : 0.0000000   Mean   : 0.0000000   Mean   : 0.0000000  
    ##  3rd Qu.: 0.9926233   3rd Qu.: 0.6697312   3rd Qu.: 1.2362046  
    ##  Max.   : 1.4637190   Max.   : 2.8138532   Max.   : 1.2362046  
    ##      DOCASKME.V1         DOCDECID.V1           DOCSAT.V1      
    ##  Min.   :-1.655795   Min.   :-1.9596814   Min.   :-3.0062711  
    ##  1st Qu.:-0.483082   1st Qu.:-0.8322326   1st Qu.:-0.5045638  
    ##  Median :-0.483082   Median :-0.2685082   Median : 0.3293387  
    ##  Mean   : 0.000000   Mean   : 0.0000000   Mean   : 0.0000000  
    ##  3rd Qu.: 0.689632   3rd Qu.: 0.8589407   3rd Qu.: 1.1632411  
    ##  Max.   : 5.380486   Max.   : 1.4226651   Max.   : 1.1632411  
    ##      DOCCOSTS.V1           HEALTH1.V1           EVCRACK.V1     
    ##  Min.   :-2.1918572   Min.   :-1.4465253   Min.   :-2.0733454  
    ##  1st Qu.:-0.7372826   1st Qu.:-0.7145263   1st Qu.: 0.5136582  
    ##  Median :-0.0099953   Median : 0.0174727   Median : 0.5136582  
    ##  Mean   : 0.0000000   Mean   : 0.0000000   Mean   : 0.0000000  
    ##  3rd Qu.: 0.7172921   3rd Qu.: 0.7494717   3rd Qu.: 0.5136582  
    ##  Max.   : 1.4445794   Max.   : 2.2134696   Max.   : 0.5136582  
    ##        EVIDU.V1            HEALTH.V1           OUTSIDER.V1     
    ##  Min.   :-2.0795102   Min.   :-1.1420180   Min.   :-0.8695685  
    ##  1st Qu.: 0.4971628   1st Qu.:-1.1420180   1st Qu.:-0.8695685  
    ##  Median : 0.4971628   Median :-0.2778473   Median :-0.8695685  
    ##  Mean   : 0.0000000   Mean   : 0.0000000   Mean   : 0.0000000  
    ##  3rd Qu.: 0.4971628   3rd Qu.: 0.5863234   3rd Qu.: 1.1492031  
    ##  Max.   : 0.4971628   Max.   : 2.3146647   Max.   : 1.8221269  
    ##       DOC19A.V1           ILLPHYS.V1          IMPRVMED.V1     
    ##  Min.   :-0.806062   Min.   :-0.8481903   Min.   :-0.7983882  
    ##  1st Qu.:-0.806062   1st Qu.:-0.8481903   1st Qu.:-0.7983882  
    ##  Median :-0.806062   Median :-0.8481903   Median :-0.7983882  
    ##  Mean   : 0.000000   Mean   : 0.0000000   Mean   : 0.0000000  
    ##  3rd Qu.: 0.923671   3rd Qu.: 0.6071284   3rd Qu.: 0.8601718  
    ##  Max.   : 3.518270   Max.   : 2.0624471   Max.   : 2.5187319  
    ##       MNTLILL.V1          IMPRVEAT.V1          ALLERGIC.V1     
    ##  Min.   :-0.8803950   Min.   :-0.8821635   Min.   :-0.8637630  
    ##  1st Qu.:-0.8803950   1st Qu.:-0.8821635   1st Qu.:-0.8637630  
    ##  Median :-0.8803950   Median :-0.8821635   Median :-0.8637630  
    ##  Mean   : 0.0000000   Mean   : 0.0000000   Mean   : 0.0000000  
    ##  3rd Qu.: 1.0753834   3rd Qu.: 0.5196653   3rd Qu.: 0.5402962  
    ##  Max.   : 1.7273095   Max.   : 1.9214940   Max.   : 1.9443553  
    ##      GENEPROB.V1          NATHEAL.V1          MEDSYMPS.V1     
    ##  Min.   :-0.8555647   Min.   :-0.838296   Min.   :-0.8543274  
    ##  1st Qu.:-0.8555647   1st Qu.:-0.838296   1st Qu.:-0.8543274  
    ##  Median :-0.8555647   Median :-0.838296   Median :-0.8543274  
    ##  Mean   : 0.0000000   Mean   : 0.000000   Mean   : 0.0000000  
    ##  3rd Qu.: 0.6706523   3rd Qu.: 0.506187   3rd Qu.: 1.0599475  
    ##  Max.   : 2.1968693   Max.   : 3.195151   Max.   : 2.9742224  
    ##      PHYSHLTH.V1         MNTLHLTH.V1    
    ##  Min.   :-0.544786   Min.   :-0.582206  
    ##  1st Qu.:-0.544786   1st Qu.:-0.582206  
    ##  Median :-0.366120   Median :-0.416059  
    ##  Mean   : 0.000000   Mean   : 0.000000  
    ##  3rd Qu.:-0.366120   3rd Qu.:-0.249912  
    ##  Max.   : 3.564532   Max.   : 3.239179

``` r
# dropping a numeric variable not needed
#--------------------------------------------------------------
d_quant <- subset(d_quant, select = - c(X)) 
```

``` r
# removing outliers; 
# removing records that contain atleast a Z-score value above 3 or below -3
#--------------------------------------------------------------
d_quant <- d_quant[!rowSums(d_quant > 3), ]
#d_quant <- d_quant[!rowSums(no_outliers < -3), ] # no outliers below -3
```

# Correlation

``` r
cor.d_quant <- cor(d_quant)
corrplot(cor.d_quant, method="ellipse")
```

![](pca_files/figure-markdown_github/unnamed-chunk-8-1.png)

``` r
M <- round(cor(d_quant, method="spearman",use = "complete.obs"), 2)
corrplot(M, method="number")
```

![](pca_files/figure-markdown_github/unnamed-chunk-9-1.png)

``` r
ggcorr(d_quant, method = c("pairwise","spearman"), label=TRUE)
```

![](pca_files/figure-markdown_github/unnamed-chunk-9-2.png)

``` r
options("scipen"=100, "digits"=5)
```

``` r
# significant correlations
#-----------------------------------------
MCorrTest <-  corr.test(d_quant, method = "pearson", adjust="none")
M <-  MCorrTest$p               # getting p-values
MTest <-  ifelse(M < .05, T, F) # getting significant (at 0.05) paired-variables


# total significant correlation pairs per variable
print("Number of significant correlation pairs per variable")
```

    ## [1] "Number of significant correlation pairs per variable"

``` r
colSums(MTest) - 1    # subtracting 1 to account for self correlation
```

    ##   DOC16A   DOC18A   DOC15A   DOC20A  DOCRELY DOCASKME DOCDECID   DOCSAT 
    ##       17       17       16       17       13        8       13       13 
    ## DOCCOSTS  HEALTH1  EVCRACK    EVIDU   HEALTH OUTSIDER   DOC19A  ILLPHYS 
    ##        9       17        8        8        2       17       17       15 
    ## IMPRVMED  MNTLILL IMPRVEAT ALLERGIC GENEPROB  NATHEAL MEDSYMPS PHYSHLTH 
    ##       13       13       13       14       15        1       15        7 
    ## MNTLHLTH 
    ##        8

# results:

# variables HEALTH and NATHEAL

# do not have many significant correlation pairs so I will remove them from PCA

# HEALTH has 2 pairs and NATHEAL has 1 pair

``` r
# dropping variables not correlated with many variables
d_quant <- subset(d_quant, select = - c(HEALTH, NATHEAL)) 
```

# PCA

``` r
# plotting principal components 

p <-  prcomp(d_quant, center=T, scale=F)       # we now have our PCP
plot(p)                                        # we get the stree plot
abline(1, 0)                                   # run this line with above line to get eigein value 1 line
```

![](pca_files/figure-markdown_github/unnamed-chunk-12-1.png)

``` r
summary(p)  
```

    ## Importance of components:
    ##                          PC1    PC2   PC3    PC4    PC5    PC6    PC7    PC8
    ## Standard deviation     3.147 1.4346 1.347 1.1526 1.1324 0.8420 0.8299 0.7622
    ## Proportion of Variance 0.458 0.0952 0.084 0.0614 0.0593 0.0328 0.0319 0.0269
    ## Cumulative Proportion  0.458 0.5531 0.637 0.6985 0.7578 0.7906 0.8224 0.8493
    ##                           PC9  PC10   PC11   PC12   PC13    PC14   PC15    PC16
    ## Standard deviation     0.6926 0.674 0.6122 0.5794 0.5017 0.45935 0.4387 0.41817
    ## Proportion of Variance 0.0222 0.021 0.0173 0.0155 0.0116 0.00976 0.0089 0.00809
    ## Cumulative Proportion  0.8715 0.892 0.9098 0.9253 0.9370 0.94673 0.9556 0.96372
    ##                           PC17    PC18    PC19   PC20    PC21    PC22    PC23
    ## Standard deviation     0.39494 0.38424 0.37590 0.3322 0.32049 0.28550 0.21191
    ## Proportion of Variance 0.00721 0.00683 0.00654 0.0051 0.00475 0.00377 0.00208
    ## Cumulative Proportion  0.97093 0.97776 0.98430 0.9894 0.99415 0.99792 1.00000

# choosing 5 principal components because they are above eigein value 1

``` r
# varimax assumes independence
pc <-  psych::principal(d_quant, rotate="varimax", nfactors=5, scores=TRUE) 
print(pc$loadings, cutoff=.4, sort=T) # loading cutoff value is at 0.4
```

    ## 
    ## Loadings:
    ##          RC1    RC3    RC2    RC5    RC4   
    ## DOC16A    0.880                            
    ## DOC18A    0.856                            
    ## DOC15A    0.868                            
    ## DOC20A    0.816                            
    ## OUTSIDER  0.874                            
    ## DOC19A    0.859                            
    ## ILLPHYS   0.908                            
    ## IMPRVMED  0.879                            
    ## MNTLILL   0.910                            
    ## IMPRVEAT  0.924                            
    ## ALLERGIC  0.914                            
    ## GENEPROB  0.906                            
    ## MEDSYMPS  0.876                            
    ## EVCRACK          0.986                     
    ## EVIDU            0.985                     
    ## DOCSAT                  0.893              
    ## DOCCOSTS                0.902              
    ## DOCRELY                        0.830       
    ## DOCDECID                       0.837       
    ## HEALTH1                               0.613
    ## PHYSHLTH                              0.766
    ## MNTLHLTH                              0.729
    ## DOCASKME                                   
    ## 
    ##                   RC1   RC3   RC2   RC5   RC4
    ## SS loadings    10.249 1.953 1.691 1.609 1.525
    ## Proportion Var  0.446 0.085 0.074 0.070 0.066
    ## Cumulative Var  0.446 0.531 0.604 0.674 0.740

``` r
#pc$loadings     # loadings
#pc$values       # eigen values
#pc$communality  # this is the shared variance--we can look at what variables are giving the most variance
#pc$rot.mat      # rotated matrix
```

""" Results:

Principal Components

RC1 &lt;- DOC16A \* 0.880 +
DOC18A \* 0.856 +
DOC15A \* 0.868 +
DOC20A \* 0.816 +
OUTSIDER \* 0.874 +
DOC19A \* 0.859 +
ILLPHYS \* 0.908 +
IMPRVMED \* 0.879 +
MNTLILL \* 0.910 +
IMPRVEAT \* 0.924 +
ALLERGIC \* 0.914 +
GENEPROB \* 0.906 +
MEDSYMPS \* 0.876 +

RC3 &lt;- EVCRACK \* 0.986 + EVIDU \* 0.985

RC2 &lt;- DOCSAT \* 0.893 +
DOCCOSTS \* 0.902

RC5 &lt;- DOCRELY \* 0.830 +
DOCDECID \* 0.837

RC4 &lt;- HEALTH1 \* 0.613 + PHYSHLTH \* 0.766 + MNTLHLTH \* 0.729

"""

``` r
# PCA_Plot functions
#########################################################################

PCA_Plot = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = data.frame(pcaData$rotation, .names = row.names(pcaData$rotation))
  p + geom_text(data=loadings, mapping=aes(x = PC1, y = PC2, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC1", y = "PC2")
}

PCA_Plot_Secondary = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = data.frame(pcaData$rotation, .names = row.names(pcaData$rotation))
  p + geom_text(data=loadings, mapping=aes(x = PC3, y = PC4, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC3", y = "PC4")
}

PCA_Plot_Psyc = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = as.data.frame(unclass(pcaData$loadings))
  s = rep(0, ncol(loadings))
  for (i in 1:ncol(loadings))
  {
    s[i] = 0
    for (j in 1:nrow(loadings))
      s[i] = s[i] + loadings[j, i]^2
    s[i] = sqrt(s[i])
  }
  
  for (i in 1:ncol(loadings))
    loadings[, i] = loadings[, i] / s[i]
  
  loadings$.names = row.names(loadings)
  
  p + geom_text(data=loadings, mapping=aes(x = PC1, y = PC2, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC1", y = "PC2")
}

PCA_Plot_Psyc_Secondary = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = as.data.frame(unclass(pcaData$loadings))
  s = rep(0, ncol(loadings))
  for (i in 1:ncol(loadings))
  {
    s[i] = 0
    for (j in 1:nrow(loadings))
      s[i] = s[i] + loadings[j, i]^2
    s[i] = sqrt(s[i])
  }
  
  for (i in 1:ncol(loadings))
    loadings[, i] = loadings[, i] / s[i]
  
  loadings$.names = row.names(loadings)
  
  print(loadings)
  p + geom_text(data=loadings, mapping=aes(x = PC3, y = PC4, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC3", y = "PC4")
}
```
