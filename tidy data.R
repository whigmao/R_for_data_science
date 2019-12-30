library(tidyverse)
#There are three interrelated rules which make a dataset tidy:
#1.Each variable must have its own column.
#2.Each observation must have its own row.
#3.Each value must have its own cell.
#---
#That interrelationship leads to an even simpler set of practical instructions:
#1.Put each dataset in a tibble.
#2.Put each variable in a column.
#---
#The first step is always to figure out what the variables and observations are.
#The second step is to resolve one of two common problems:
#1.One variable might be spread across multiple columns.
#2.One observation might be scattered across multiple rows.
#---
#A common problem is a dataset where some of the column names are not names of variables, 
#but values of a variable.
tidy4a <- table4a %>%
  gather('1999','2000',key = "year", value = "cases")
tidy4b <- table4b %>%
  gather('1999','2000',key = "year", value = "population")
#To combine the tidied versions of table4a and table4b into a single tibble, 
#we need to use dplyr::left_join()
left_join(tidy4a,tidy4b)
#---
#Spreading is the opposite of gathering. 
#You use it when an observation is scattered across multiple rows
table2 %>%
  spread(key = type, value = count)
#---
#Separating and uniting
#separate() pulls apart one column into multiple columns
table3 %>%
  separate(rate, into = c("cases", "population"),sep = "/")
table3 %>%
  separate(rate, into = c("cases", "population"),sep = "/",convert = TRUE)
#notice the types of the two new vatiables are changed
table3 %>%
  separate(year,into = c("century","year"),sep = 2)
#unit
#unite() is the inverse of separate(): 
#it combines multiple columns into a single column. 
table5 %>%
  unite(year,century,year, sep = "")
#---
#missing value
#you can set na.rm = TRUE
#Another important tool for making missing values explicit in tidy data is complete()
#You can fill in these missing values with fill()
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)
treatment %>% 
  fill(person)
