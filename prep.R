# Author: Sony Nghiem
# prepare the data wine from UCI - Machine learning archives

setwd("~/GitHub/wine-quality-tree.R")
wine = read.csv("wine.csv")
names(wine) = c("quality", "alcohol", "malic_acid", "ash","alcalinity_of_ash",
                "magnesium", "total_phenols", "flavanoids", "nonflavanoid_phenols",
                "proanthocyanins", "color_intensity", "hue", "OD280", "proline")
summary(wine)
wine$quality = as.factor(wine$quality)
