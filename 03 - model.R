############################## 
##                          ##    
##          Model           ##
##                          ##
##############################

# install packages and libraries
install.packages("dummies")
library(dummies)


# download csv of all faculty from six selected departments
dept.rosters = read.csv("starting_data/fullrosters.csv")

# explore data
summary(dept.rosters)

# convert variable types
dept.rosters$Status <- factor(dept.rosters$Status)
dept.rosters$Signed <- as.logical(dept.rosters$Signed)

# create dummy variables for tenure status
dummystatus <- dummy.data.frame(data = dept.rosters, names = "Status")
names(dummystatus) <- c("name", "dTenure", "dNon", "dTT", "department", "signed")
                    # dTenure = Has Tenure 
                    # dNon = Non-Tenure
                    # dTT = Tenure-track

# logisitic regression 
sign.tenure <- glm(signed ~ dTenure + dNon, data = dummystatus, family = binomial)
sign.tenure2 <- glm(signed ~ dTenure + dTT, data = dummystatus, family = binomial)
summary(sign.tenure)
summary(sign.tenure2)
# neither of these models is significant. let's try including both department and tenure status

# group departments by division
tenuredivision <- dept.rosters %>%
  mutate(Department = fct_collapse(Department,
                                   "Sciences" = c("Psychiatry", "Medicine", "Human Genetics", "Biology", "Statistics", "Computer Science", "Physics", "Mathematics", "Institute for Molecular Engineering"),
                                   "Humanities" = c("Philosophy", "Comparative Literature", "Classics", "Art History", "Cinema and Media Studies", "Music", "Humanities", "East Asian Languages and Civilizations", "Divinity", "Creative Writing", "Germanic Studies", "French", "English", "Linguistics", "Visual Arts","Near East Languages and Civilizations", "South Asian Languages and Literatures", "Society of Fellows", "Slavic", "Romance Languages and Literatures"),
                                   "Professional" = c("Social Service Administration", "Public Policy", "Law", "Business")
  )) 

names(tenuredivision) <- c("Name", "Status", "Division", "Signed")
write_feather(tenuredivision, "data/tenuredivision.feather") 


# plot
# total faculty by division and status
full.roster.plot <- tenuredivision %>%
  ggplot(aes(x = Division)) + 
  geom_bar(aes(fill = Status)) +
  ylab("Number of Faculty") +
  ggtitle("Figure 6: Total Faculty by Division (n=235)")
full.roster.plot
ggsave("graphics/figure6.png")


# total faculty by division and signatories
signed.full <- tenuredivision %>%
  ggplot(aes(x = Division)) + 
  geom_bar(aes(fill = Signed)) +
  ylab("Number of Faculty") +
  ggtitle("Figure 7: Signatories by Division (n=235)")
signed.full
ggsave("graphics/figure7.png")


# create dummy variables for new dataset
dtenuredivision <- dummy.data.frame(data = tenuredivision, names = "Status")
dtenuredivision2 <- dummy.data.frame(data = dtenuredivision, names = "Division")

# fix column names
names(dtenuredivision2) <- c("name", "dTenure", "dNon", "dTT", "dSci", "dHum", "dProf", "signed")

# logistic regression model: division and tenure status on signed 
model <- glm(signed ~ dTT + dTenure + dProf + dHum, data = dtenuredivision2, family = binomial)
summary(model)

# check for interaction 
interaction <- glm(signed ~ dTT + dTenure + dProf + dTenure*dHum + dHum + dTT*dProf + dTT*dHum + dTenure*dProf, data = dtenuredivision2, family = binomial)
summary(interaction)
# none of the interactive terms are significant 

