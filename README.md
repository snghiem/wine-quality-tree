# Tree-Based Methods for Wine Quality data

In this repository, I use these following methods:
* Fitting Classification Trees
* Bagging and Random Forests
* Boosting

Note: bagging does not lead to a substantial reduction in variance over 
a single tree. Random forests force each split to consider only a subset of the
predictors, so not only consider strong predictors; indeed, any predictor has more
chance. This decorrelates the trees.

boosting normally outperforms random forests because the growth of a particular
tree consider other trees that have already been grown, smaller trees
are generally enough. 
