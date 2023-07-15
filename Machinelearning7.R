library(dplyr)

## Unsupervised learning ####
## Principal Components Analysis
head(iris)

## remove any non-numeric variables
iris_num <- select(iris, -Species)
iris_num

## do PCA
pcas <- prcomp(iris_num, scale. = T)
pcas
summary(pcas)
