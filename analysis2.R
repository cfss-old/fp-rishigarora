library(rvest)


## combine positions based on level of job security
library(forcats)

tenurestatus <- facultylist %>%
  mutate(Position = fct_collapse(Position,
                                 "Has Tenure" = c("Professor Emeritus", "Professor", "Named Professor", "Distinguished Service Professor", "Executive Director", "Visiting Professor", "Associate Professor"),
                                 "Tenure Track" = c("Clinical Professor", "Assistant Professor", "Assistant Clinical Professor"),
                                 "Non-Tenure" = c("Visiting Lecturer", "Senior Lecturer", "Provost's Postdoctoral Scholar", "Lecturer", "Harper Fellow")
  )) 
write_feather(tenurestatus, "groupbytenure.feather") 

## combine departments based on division
division <- facultylist %>%
  mutate(Department = fct_collapse(Department,
                                   "Biological Sciences" = c("Psychiatry", "Medicine", "Human Genetics", "Biology"),
                                   "Physical Sciences" = c("Statistics", "Computer Science", "Physics", "Mathematics", "Institute for Molecular Engineering"),
                                   "Social Sciences" = c("Young Center for Immigrant Children's Rights", "Anthropology", "Comparative Human Development", "History", "Human Rights", "Sociology", "Social Thought", "Social Sciences Division", "Psychology", "Political Science"),
                                   "Humanities" = c("Philosophy", "Comparative Literature", "Classics", "Art History", "Cinema and Media Studies", "Music", "Humanities", "East Asian Languages and Civilizations", "Divinity", "Creative Writing", "Germanic Studies", "French", "English", "Linguistics", "Visual Arts","Near East Languages and Civilizations", "South Asian Languages and Literatures", "Society of Fellows", "Slavic", "Romance Languages and Literatures"),
                                   "Professional" = c("Social Service Administration", "Public Policy", "Law", "Business")
  )) 
write_feather(division, "groupbydivision.feather") 

## new plots using generated groupings 
# grouped by tenure status
tenurestatus %>%
  mutate(Position = Position %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(Position)) +
  geom_bar() +
  theme_minimal() +
  labs(title="Faculty Signatories by Tenure Status", y="# of Signatories")  
ggsave("plot_bytenure.png", width = 5, height = 5)


# grouped by division 
division %>%
  mutate(Department = Department %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(Department)) +
  geom_bar() +
  theme_minimal() +
  labs(title="Faculty Signatories by Academic Division", y="# of Signatories")  
ggsave("plot_bydivision.png", width = 5, height = 5)



# REORDER = http://r4ds.had.co.nz/factors.html






