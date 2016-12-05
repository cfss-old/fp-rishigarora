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

# plot number of faculty by position
ggplot(data = facultylist) +
  geom_bar(mapping = aes(x = Position)) +
  coord_flip() + 
  theme_classic()  


  
### group by sciences vs humanities vs social science 
### group by tenure no tenure (include clinical in no tenure, emeritus in tenure)
### experiment by language - tendency for some to participate vs not? regression