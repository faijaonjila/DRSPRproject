## load required packages
library(tidyr)
library(dplyr)
library(janitor)

starwars

## clean names
clean_names(starwars, case = "small_camel")
clean_names(starwars, case = "screaming_snake")
clean_names(starwars, case = "upper_lower")
new_starwars <- clean_names(starwars, case = "screaming_snake")

clean_names(new_starwars)

new_starwars <- rename('hair*color' = HAIR_COLOR)
clean_names(new_starwars)

## Combining Multiple Function Calls
## make a table of names and species of all female star wars characters by age

starwarswomen <- select(arrange(filter(starwars, sex == "female"), mass), name, species)

starwarswomen <- filter(starwars, sex == "female")
starwarswomen  <- arrange(starwarswomen, birth_year)
starwarswomen  <- select(starwarswomen, name, species)

## using pipes
starwarswomen <- starwars |> 
  filter(sex == "female") |>
  arrange(birth_year) |> 
  select(name, species)

## slice functions
## 10 tallest star wars characters
slice_max(starwars, height, n = 10 )
## 10 shortest star wars characters
slice_min(starwars, height, n = 10)
?slice

slice_max(starwars, height, n = 2, by = species, with_ties = F )

## tidy data ####
table4a

tidy_table4 <- pivot_longer(table4a,
             cols = c('1999','2000'),
             names_to = "year",
           values_to = "cases")

table4b # shows population data
## How would ,we pivot table4b to be in "tidy" format?
tidy_table4b <- pivot_longer(table4b,
             cols = c('1999', '2000') ,
             names_to = "year" ,
             values_to ="population")

## pivot wider
table2

pivot_wider(table2,
           names_from = type,
           values_from = count)

## seperate
table3

separate(table3,
         rate,
         into = c("cases","popualtion"), 
         sep = "/")

## unite
table5
tidy_table5  <- unite(table5,
      "year",
     c("century", "year"),
     sep = "")

tidy_table5 <- table5 |>
  unite("year", 
        c("century", "year"), sep = "") |>
  separate(rate,
           into = c("cases","popualtion"), 
           sep = "/")

## bind rows
new_data <- data.frame(country = "USA", year = 1999, cases = 1042, population = 2000000)

bind_rows(tidy_table5, new_data)
