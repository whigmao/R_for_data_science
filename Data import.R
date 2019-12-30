#Data import
#read.csv()---comma delimited files
#read_csv2() reads semicolon separated files
#read_tsv() reads tab delimited files
#read_delim() reads in files with any delimiter
#---
#skip lines
#You can use skip = n to skip the first n lines; 
#or use comment = "#" to drop all lines that start with (e.g.) #
library(tidyverse)
read_csv("The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3", skip = 2)

read_csv("# A comment I want to skip
  x,y,z
  1,2,3", comment = "#")
#---
#The data might not have column names. 
#You can use col_names = FALSE to tell read_csv() not to treat the first row as headings
read_csv("1,2,3\n4,5,6", col_names = FALSE)
#"\n" is a convenient shortcut for adding a new line
#you can pass col_names a character vector which will be used as the column names
read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))
#represent missing values
read_csv("a,b,c\n1,2,.", na=".")
#---
#Parsing a factor
#These functions take a character vector and 
#return a more specialised vector like a logical, integer, or date
parse_logical(c("TRUE", "FALSE", "NA"))
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))
parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")
parse_number("$123,456,789")
parse_number("123.456.789", locale = locale(grouping_mark = "."))
parse_number("123'456'789", locale = locale(grouping_mark = "'"))
charToRaw("Hadley")
#---
#Strings
x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"
parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))
guess_encoding(charToRaw(x1))
#Generate the correct format string to parse each of the following dates and times
parse_datetime("2010-10-01T2010")
parse_datetime("20101010")
parse_date("2010-10-01")
parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("2015-Mar-07", "%Y-%b-%d")
#non-English month names,
parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))
#---
#Parsing a file
#How readr automatically guesses the type of each column.
guess_parser("2010-10-01")
guess_parser(c("12,352,561"))
challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_integer(),
    y = col_character()
  )
)
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_character()
  )
)
tail(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
tail(challenge)
#---
#Writing to a file
#readr also comes with two useful functions for writing data back to disk:
#write_csv() and write_tsv()
#Always encoding strings in UTF-8.
#Saving dates and date-times in ISO8601 format so they are easily parsed elsewhere.















































