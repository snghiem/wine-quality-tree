# Author: Sony Nghiem
# Title: Fitting classification trees
# Decision tree

setwd("~/GitHub/wine-quality-tree.R")
source("prep.R")

library(tree)
tree.wine = tree(quality~., data=wine)

summary(tree.wine)

# Classification tree:
#   tree(formula = quality ~ ., data = wine)
# Variables actually used in tree construction:
#   [1] "flavanoids"      "color_intensity" "malic_acid"      "proline"        
# [5] "alcohol"        
# Number of terminal nodes:  7 
# Residual mean deviance:  0.08831 = 15.01 / 170 
# Misclassification error rate: 0.01695 = 3 / 177

plot(tree.wine)
text(tree.wine)
tree.wine

# Now I need to evaluate the peformance of my decision tree
set.seed(1)
train = sample(c(TRUE, FALSE), dim(wine)[1]/2, rep=TRUE)
tree.wine = tree(quality~., data=wine, subset=train)
pred = predict(tree.wine, wine[!train,], type="class")
# note that for fitting classification, I need type "class"
# for fitting regression, I don't need that argument

table(pred, wine$quality[!train])
mean(pred==wine$quality[!train])
# pretty good

#let's do some cross-validation to determine the optimal level of tree complexity
set.seed(4)
cv.wine = cv.tree(tree.wine, FUN=prune.misclass)
cv.wine
plot(cv.wine$size, cv.wine$dev, type="l")
min(cv.wine$dev)
which.min(cv.wine$dev)

#so 3 terminal nodes provide the lowest cross-validation error rate
# let's prune the tree, which originally has 7 terminal nodes

prune.wine = prune.misclass(tree.wine, best=3)
plot(prune.wine)
text(prune.wine)
pred = predict(prune.wine, wine[!train,], type="class")
table(pred, wine$quality[!train])
mean(pred==wine$quality[!train])

# ehh not really good compared with the original tree