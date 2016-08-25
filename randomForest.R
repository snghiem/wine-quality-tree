# Author: Sony Nghiem
# title: random forest & bagging

setwd("~/GitHub/wine-quality-tree.R")
source("prep.R")

library(randomForest)
set.seed(23)

# here I am going to perform different mtry (splits) and compare the MSEs
# Oops this is classification, so we cannot check MSEs
# but we can check Gini?
?randomForest
# actually Gini is within the tree library, not the randomForest one

bag.wine = randomForest(quality~., data=wine, mtry=13, importance=T)
bag.wine
#OOB error rate is 2.26% not bad at all

importance(bag.wine)
# the 3 most imporant ones are flavanoids, proline, and color_intensity

rf.wine = randomForest(quality~., data=wine, mtry=4, importance=T)
rf.wine# similar result
varImpPlot(rf.wine)
