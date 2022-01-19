library(analysr) # Our package
library(tidyverse) # to have %>% function

setup_new_env()

import_stat_units_csv(
    csv_path = "./video-11-12/csv_1000/patients_1000.csv",
    stat_unit = "UserId",
    optional_data = c("BIRTHDATE","DEATHDATE","FIRST","LAST","RACE","ETHNICITY","GENDER","STATE","HEALTHCARE_EXPENSES","HEALTHCARE_COVERAGE"))

import_measures_csv(
    csv_path = "./video-11-12/csv_1000/measures_1000.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION",
    value = "VALUE")

import_events_csv(
    csv_path = "./video-11-12/csv_1000/events_1000.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION")

import_periods_csv(
     csv_path = "./video-11-12/csv_1000/periods_1000.csv",
     stat_unit = "PATIENT",
     begin = "START",
     end = "STOP",
     tag = "DESCRIPTION")


# Request
result <- (
   analysr_env
   %>% observed(`Body Weight` < 80)
   %>% at_least(5 * days)
   %>% described_by(GENDER == "F")
   %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
   %>% add_description("Women who have lost weight after cancer therapy")
)

# Print selection
print(result$selection)


result %>% extract_feature("Women who have lost weight after cancer therapy")

# Print stat_units
print(result$stat_units)

# Save Env
save_env_csv('./video-11-12/after')
