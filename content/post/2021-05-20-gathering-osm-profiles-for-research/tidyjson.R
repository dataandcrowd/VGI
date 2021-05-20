library(tidyjson)
library(tidyverse)


# 1. File import
# this should give you a character vector, with each file name represented by an entry
filenames <- list.files("Contributors/", pattern="*.json", full.names=TRUE) 

# Import data
osm_json <-filenames %>% 
  map(read_json) %>% 
  reduce(bind_rows) %>% 
  mutate(document.id = row_number())

# Check data type
class(osm_json)  


# Take a look at the data
osm_json %>%  
  spread_all() %>% 
  glimpse()

# browse Types 
osm_json %>% 
  gather_object %>% 
  json_types %>%
  count(name, type) %>% 
  print(n = Inf)


# Glance at the first index
osm_json %>% 
  enter_object('contributor') %>% 
  gather_object('index.1') %>% 
  spread_all() %>% 
  append_values_string() 


osm_json %>%
  as_tbl_json(drop.nulljson = T) %>% 
  enter_object('changesets') %>%
  spread_values(days = jstring(days)) 


# Now convert them to tibble
osm_json %>% 
  spread_all() %>% 
  as_data_frame.tbl_json() -> osm_tibble

class(osm_tibble)


# import Excel

survey_original <- readxl::read_xlsx("OSM survey data.xlsx") %>% select(-c(`(Found) Username`, ...6, `6.a. If you selected Other, please specify:`))

survey_original %>% 
  rename(username = `1. What is your OpenStreetMap Username?`,
         gender = `2. What gender do you identify as?`,
         age = `3. What is your age?`,
         country_residence = `4. What is your country of residence?`,
         nationality = `5. What is your nationality?`,
         education = `6. What is your highest level of education?`
         ) -> survey

survey %>% 
  slice(1:30) %>% 
  mutate(id = row_number()) %>% 
  select(id, gender, age) -> survey_profile



# Data Query
survey %>% 
  left_join(osm_tibble, by = c("username" = "contributor.name")) %>% 
  select(username, gender, age, country_residence, nationality, education, 
         starts_with("contributor")) %>% 
  View()
  

survey %>% 
  left_join(osm_tibble, by = c("username" = "contributor.name")) %>% 
  select(username, gender, age, country_residence, nationality, education, 
         starts_with("lastmodifier")) %>% 
  View()


osm_tibble %>% 
  select(contains("mapping"))


osm_tibble %>% 
  select(contains("changesets.days")) 


### Days
osm_json %>%
  as_tbl_json(drop.nulljson = T) %>% 
  enter_object('changesets') %>%
  spread_values(days = jstring(days)) %>% 
  as.data.frame() %>% 
  pull(2)-> days

data.frame(days) %>% 
  mutate(days = gsub("\\|$","", days)) %>%
  separate_rows(days, sep = "[|]") %>%
  separate(days, c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"), ",") -> days_df

survey_profile %>% 
  bind_cols(days_df)



### hours
osm_json %>%
  as_tbl_json(drop.nulljson = T) %>% 
  enter_object('changesets') %>%
  spread_values(hours = jstring(hours)) %>% 
  as.data.frame() %>% 
  pull(2)-> hours

data.frame(hours) %>% 
  mutate(hours = gsub("\\|$","", hours)) %>%
  separate_rows(hours, sep = "[|]") %>%
  separate(hours, c("h01", "h02", "h03", "h04", "h05", "h06",
                    "h07", "h08", "h09", "h10", "h11", "h12",
                    "h13", "h14", "h15", "h16", "h17", "h18",
                    "h19", "h20", "h21", "h22", "h23", "h24"
  ), ",") -> hours_df

survey_profile %>% 
  bind_cols(hours_df)

