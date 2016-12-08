############################## 
##                          ##    
##  Load and Explore Data   ##
##                          ##
##############################

# install packages and libraries
library(dplyr)
library(feather)
library(ggplot2)
library(knitr)
library(plyr)
library(tidyverse)

# create empty folders
paths <- c("data", "graphics", "output")

for(path in paths){
  unlink(path, recursive = TRUE)    # delete folder and contents
  dir.create(path)                  # create empty folder
}

# download csv file and read in data
facultylist = read.csv("starting_data/faculty.csv")
write_feather(facultylist, "data/faculty_list.feather") 

# explore data and determine unique values 
facultylist %>%
  head() %>% 
  knitr::kable()

summary(facultylist)
unique(facultylist$Department) 
unique(facultylist$Position) 

filter(facultylist, Department == "Physics")
filter(facultylist, Position == "Distinguished Service Professor")

# preliminary plots 
# plot number of faculty by position in each department
ggplot(data = facultylist) +
  geom_count(mapping = aes(x = Position, y = Department))  
ggsave("graphics/facultyposition.png")

# plot signatories by position
facultylist %>%
  mutate(Position = Position %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(Position)) +
  geom_bar() +
  coord_flip() + 
  theme_minimal() +
  labs(title="Figure 1: By Position", y="# of Signatories")  
ggsave("graphics/figure1.png")

# plot signatories by department 
facultylist %>%
  mutate(Department = Department %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(Department)) +
  geom_bar() +
  coord_flip() + 
  theme_minimal() +
  labs(title="Figure 2: By Department", y="# of Signatories")  
ggsave("graphics/figure2.png")
