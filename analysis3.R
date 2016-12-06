
# load dataset of all faculty from six selected departments
dept.rosters = read.csv("fullrosters.csv")

# explore data
summary(dept.rosters)

# convert variable types
dept.rosters$Status <- factor(dept.rosters$Status)
dept.rosters$Signed <- as.logical(dept.rosters$Signed)

sign.tenure <- glm(Signed ~ Status, data = dept.rosters)

summary(sign.tenure)



