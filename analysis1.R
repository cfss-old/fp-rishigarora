library(dplyr)
library(feather)
library(ggplot2)
library(knitr)
library(plyr)
library(purrr)
library(rvest)
library(tidyverse)


## load dataset from csv
facultylist = read.csv("faculty.csv")

## explore data and determine unique values 
summary(facultylist)
unique(facultylist$Department) 
unique(facultylist$Position) 

filter(facultylist, Department == "Physics")
filter(facultylist, Position == "Distinguished Service Professor")

## preliminary plots 
# plot number of faculty by position in each department
ggplot(data = facultylist) +
  geom_count(mapping = aes(x = Position, y = Department))  

# plot signatories by position
ggplot(data = facultylist) +
  geom_bar(mapping = aes(x = Position)) +
  coord_flip() + 
  theme_minimal() +
  labs(title="Faculty Signatories by Position", y="# of Signatories")  
ggsave("plot_byposition.png", width = 5, height = 5)

# plot signatories by department 
ggplot(data = facultylist) +
  geom_bar(mapping = aes(x = Department)) +
  coord_flip() + 
  theme_minimal() +
  labs(title="Faculty Signatories by Department", y="# of Signatories")  
ggsave("plot_bydept.png", width = 5, height = 5)

# REORDER = http://r4ds.had.co.nz/factors.html

## combine positions based on level of job security
library(forcats)

tenurestatus <- facultylist %>%
  mutate(Position = fct_collapse(Position,
    "Has Tenure" = c("Professor Emeritus", "Professor", "Named Professor", "Distinguished Service Professor", "Executive Director", "Visiting Professor", "Associate Professor"),
    "Tenure Track" = c("Clinical Professor", "Assistant Professor", "Assistant Clinical Professor"),
    "Non-Tenure" = c("Visiting Lecturer", "Senior Lecturer", "Provost's Postdoctoral Scholar", "Lecturer", "Harper Fellow"
  ))) 

## combine departments based on division
biological sciences
humanities
social sciences
physical sciences 
professional schools (law, med, ssa, )






### group by sciences vs humanities vs social science 
### group by tenure no tenure (include clinical in no tenure, emeritus in tenure)
### experiment by language - tendency for some to participate vs not? regression