# Author: Sony Nghiem
# Title: Boosting

setwd("~/GitHub/wine-quality-tree.R")
source("prep.R")

library(gbm)
set.seed(321)
train = sample(c(TRUE, FALSE), dim(wine)[1]/2, rep=TRUE)
# note that for classification problem, we shoudl address the distribution as "bernoulli"
# more than 2 classes, should be "multinomial"
# for the regression problem, I can address it "gaussian"
boost.wine = gbm(quality~., data=wine[train,], distribution = "multinomial", 
                 n.trees = 5000, interaction.depth = 4)
summary(boost.wine)
plot(boost.wine, i="color_intensity")
?plot.gbm
# 3 lines for 3 classes of quality of wine
names(boost.wine)
contrasts(wine$quality)
#   2 3
# 1 0 0
# 2 1 0
# 3 0 1
# we have more than 2 classes so I cannot just simply assign the probability for 
# each predicted value to a certain level of quality of wine
pred = predict(boost.wine, newdata=wine[!train,], n.trees=5000)
dim(pred)
pred = pred[,,1] 
# so I reduce the dimension of pred, instead of 91,3,1 just simply 91,3
dim(pred)
# so here each quality levvel has its own prediction
# we choose the one with highest prob
quality.pred = rep(NA, dim(pred)[1])
for (i in 1:dim(pred)[1])
  quality.pred[i] = which.max(pred[i,]) 
quality.pred
summary(quality.pred)
class(quality.pred)

# Now we are DONE!
