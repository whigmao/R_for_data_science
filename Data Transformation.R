#Data Transformation
#create new variables and summaries, rename the variables or reorder the observations
library(nycflights13)
library(tidyverse)
flights
#Pick observations by their values (filter()).
#Reorder the rows (arrange()).
#Pick variables by their names (select()).
#Create new variables with functions of existing variables (mutate()).
#Collapse many values down to a single summary (summarise()).
#These can all be used in conjunction with group_by()
#---
#1.filter rows with filter()
(jan1 <- filter(flights, month == 1, day == 1))
#R either prints out the results, or saves them to a variable. 
#If you want to do both, you can wrap the assignment in parentheses.
#---
#Logical operators#you’ll need to use Boolean operators yourself: 
#& is “and”, | is “or”, and ! is “not”.
filter(flights,month == 11|month == 12)
filter(flights, arr_delay >= 2)
?between
#---
#2.Arrange rows with arrange()
#it changes their order.
arrange(flights,dep_time)
arrange(flights,desc(dep_time))
#---
#3.Select columns with select()
#select() allows you to rapidly zoom in on a useful subset 
#using operations based on the names of the variables.
select(flights,year,dep_time)
#Select all columns between
select(flights, year:dep_time)
#Select all columns except
select(flights,-(year:dep_time))
#There are a number of helper functions
#starts_with("abc"),ends_with("xyz"),contains("ijk"),matches("(.)\\1"), num_range("x", 1:3).
select(flights, time_hour, air_time, everything())
#---
#Add new variables with mutate()
#4first, we will create a small dataset based on flights.
flights_sml <- select(flights, 
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)
flights_sml1 <- mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time *60)
#If you only want to keep the new variables, use transmute():
transmute(flights_sml,
          gain = dep_delay - arr_delay,
          hours = air_time/60,
          gain_per_hour = gain / hours)
#---
#5. Grouped summaries with summarise()
#The last key verb is summarise(). 
#It collapses a data frame to a single row:
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
#---
#5,1 Combining multiple operations with the pipe
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
#There’s another way to tackle the same problem with the pipe
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")
#missing value
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))
#if there’s any missing value in the input, 
#the output will be a missing value
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay,na.rm = TRUE))

not_cancelled <- flights %>%
  filter(!is.na(dep_delay),!is.na(arr_delay))
not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))
#counts
not_cancelled %>% 
  count(dest)
#Grouping by multiple variables
#When you group by multiple variables, 
#each summary peels off one level of the grouping. 
#That makes it easy to progressively roll up a dataset












