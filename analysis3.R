install.packages("dummies")
library(dummies)

# load dataset of all faculty from six selected departments
dept.rosters = read.csv("fullrosters.csv")

# explore data
summary(dept.rosters)

# convert variable types
dept.rosters$Status <- factor(dept.rosters$Status)
dept.rosters$Signed <- as.logical(dept.rosters$Signed)

# create dummy variables for tenure status

dummytest <- dummy.data.frame(data = dept.rosters, names = "Status")


# logisitic regression 
sign.tenure <- glm(Signed ~ Status, data = dept.rosters, family = binomial)

summary(sign.tenure)

# cross validation 



# change status to dummys 

