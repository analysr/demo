library(analysr) # Our package
library(tidyverse) # to have %>% function

setup_new_env()

View(analysr_env)

import_stat_units_csv(
  csv_path = "./demo-finale/csv1000/patients_1000.csv",
  stat_unit = "UserId",
  optional_data = c("BIRTHDATE","DEATHDATE","FIRST","LAST","RACE","ETHNICITY","GENDER","STATE","HEALTHCARE_EXPENSES","HEALTHCARE_COVERAGE"))

import_measures_csv(
  csv_path = "./demo-finale/csv1000/measures_1000.csv",
  stat_unit = "PATIENT",
  date = "DATE",
  tag = "DESCRIPTION",
  value = "VALUE")

import_events_csv(
  csv_path = "./demo-finale/csv1000/events_1000.csv",
  stat_unit = "PATIENT",
  date = "DATE",
  tag = "DESCRIPTION")

import_periods_csv(
  csv_path = "./demo-finale/csv1000/periods_1000.csv",
  stat_unit = "PATIENT",
  begin = "START",
  end = "STOP",
  tag = "DESCRIPTION")

#Visualize the changes in the selection table
View(analysr_env)


# Request
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% at_least(5 * days)
  %>% described_by(GENDER == "F")
  %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
  %>% add_description("Women who have lost weight after cancer therapy")
)

View(result)

#Extract_feature
result %>% extract_feature("Women who have lost weight after cancer therapy")

#Visualize the changes in the stat_units table
View(result)

create_feature(result, "Avg_Weight_2012", "Triglycerides", "2012-01-01", "2012-12-31")


# Save Env
save_env_csv('./demo-finale/after')

