############################## 
##                          ##    
##        Runfile           ##
##                          ##
##############################

# this script executes all data wrangling and analysis. 
# ensure the folder `starting_data` is located in your working directory before running the code 

# clean out any previous work
paths <- c("data", "graphics", "output")

for(path in paths){
  unlink(path, recursive = TRUE)    # delete folder and contents
  dir.create(path)                  # create empty folder
}

# run the scripts
source("01 - load data.R")
source("02 - data wrangling.R")
source("03 - model.R")

rmarkdown::render_site

