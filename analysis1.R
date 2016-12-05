library(dplyr)
library(feather)
library(ggplot2)
library(knitr)
library(plyr)
library(tidyverse)


## load dataset from csv
facultylist = read.csv("faculty.csv")
write_feather(facultylist, "faculty_list.feather") 


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
facultylist %>%
  mutate(Position = Position %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(Position)) +
  geom_bar() +
  coord_flip() + 
  theme_minimal() +
  labs(title="Faculty Signatories by Position", y="# of Signatories")  
ggsave("plot_byposition.png", width = 5, height = 5)

# plot signatories by department 
facultylist %>%
  mutate(Department = Department %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(Department)) +
  geom_bar() +
  coord_flip() + 
  theme_minimal() +
  labs(title="Faculty Signatories by Department", y="# of Signatories")  
ggsave("plot_bydept.png", width = 5, height = 5)





### experiment by language - tendency for some to participate vs not? regression
### logistic model
  ### cross validate
### shiny app for searchable faculty