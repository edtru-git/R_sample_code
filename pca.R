


# Ed Trujillo 
# Sample Code: Principal Component Analysis (PCA)


library(foreign) 
library(corrplot)
library(car)
library(QuantPsyc)
library(leaps)
library(MASS)
library(car)
library(foreign)  
library(DescTools)
library(RColorBrewer)
library(Hmisc) 
library(psych)
library (dplyr) 
library("GGally") 




# obtaining dataset
#--------------------------------------------------------------
setwd('C:/Users/User/Desktop/code_sample/R/pca')
d <- read.csv('GSS_2002_Health_PCA.csv', header = T)




# defining missing values
#--------------------------------------------------------------
#df[df >8] = NA
describe(d)
d[,c(2:35)][     d[,c(2:35)]  == -1  | d[,c(2:35)]  == 8   ] = NA  # these variables missing values are -1, 8, and 9
d[,c(36:37)][    d[,c(36:37)] == -1  | 
                 d[,c(36:37)] == 98  |
                 d[,c(36:37)] == 99  ] = NA  # these variables missing values are -1, 98, and 99



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



# z-score scaling 
#--------------------------------------------------------------
d <- d %>% mutate_if(is.numeric, scale)  # scaling numeric variables



# getting only numeric variables
#--------------------------------------------------------------
num_cols <- unlist(lapply(d, is.numeric))
d_quant <- d[ , num_cols]   
describe(d_quant)
summary(d_quant)
boxplot(d_quant)




# dropping a numeric variable not needed
#--------------------------------------------------------------
d_quant <- subset(d_quant, select = - c(X)) 





# removing outliers; 
# removing records that contain atleast a Z-score value above 3 or below -3
#--------------------------------------------------------------

d_quant <- d_quant[!rowSums(d_quant > 3), ]
d_quant <- d_quant[!rowSums(no_outliers < -3), ]




# Correlation
#--------------------------------------------------------------

# correlation heatmap -regular
cor.d_quant <- cor(d_quant)
corrplot(cor.d_quant, method="ellipse")




M <- round(cor(d_quant, method="spearman",use = "complete.obs"), 2)
corrplot(M, method="number")
ggcorr(d_quant, method = c("pairwise","spearman"), label=TRUE)
options("scipen"=100, "digits"=5)





# significant correlations
#-----------------------------------------

# http://www.sthda.com/english/wiki/correlation-test-between-two-variables-in-r


# "cor.test() test for association/correlation between paired samples. 
# It returns both the correlation coefficient and the significance level(or p-value) of the correlation."


MCorrTest <-  corr.test(d_quant, method = "pearson", adjust="none")
MCorrTest
M <-  MCorrTest$p               # getting p-values
MTest <-  ifelse(M < .05, T, F) # getting significant (at 0.05) paired-variables
MTest



# total significant correlation pairs per variable
# subtracting 1 to account for self correlation
colSums(MTest) - 1   



# results: 
# variables HEALTH and NATHEAL
# do not have many significant correlation pairs so I will remove them from PCA
# HEALTH has 2 pairs and NATHEAL has 1 pair


#--------------------------------------------------------------

# dropping variables not correlated with many variables
d_quant <- subset(d_quant, select = - c(HEALTH, NATHEAL)) 





# PCA
#--------------------------------------------------------------

# plotting principal components 

p <-  prcomp(d_quant, center=T, scale=F)       # we now have our PCP
plot(p)                                        # we get the stree plot
abline(1, 0)                                   # run this line with above line to get eigein value 1 line
summary(p)  



#---------------------------

# deciding how many principal components to use and getting loadings 


# varimax assumes independence
# choosing 5 principal components because they are above eigein value 1
pc <-  psych::principal(d_quant, rotate="varimax", nfactors=5, scores=TRUE) 
pc
print(pc$loadings, cutoff=.4, sort=T) # loading cutoff value is at 0.4


#pc$loadings     # loadings
#pc$values       # eigen values
#pc$communality  # this is the shared variance--we can look at what variables are giving the most variance
#pc$rot.mat      # rotated matrix


"""
Results:

Principal Components

RC1 <-  DOC16A   *  0.880 +                      
        DOC18A   *  0.856 +                      
        DOC15A   *  0.868 +                       
        DOC20A   *  0.816 +                      
        OUTSIDER *  0.874 +                       
        DOC19A   *  0.859 +                      
        ILLPHYS  *  0.908 +                      
        IMPRVMED *  0.879 +                     
        MNTLILL  *  0.910 +                        
        IMPRVEAT *  0.924 +                        
        ALLERGIC *  0.914 +                       
        GENEPROB *  0.906 +                        
        MEDSYMPS *  0.876 +


RC3 <-  EVCRACK * 0.986 + 
        EVIDU   * 0.985  


RC2 <-  DOCSAT   *  0.893 +            
        DOCCOSTS *  0.902   


RC5 <-  DOCRELY   *  0.830 +     
        DOCDECID  *  0.837    


RC4 <-  HEALTH1  *  0.613 +
        PHYSHLTH *  0.766 +
        MNTLHLTH *  0.729


"""










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





