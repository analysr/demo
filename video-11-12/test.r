library(analysr) # Our package
library(tidyverse) # to have %>% function

setup_new_env()

# import 100 patients
import_stat_units_csv(
    csv_path = "./video-11-12/csv_100/patients_100.csv",
    stat_unit = "UserId",
    optional_data = c("BIRTHDATE","DEATHDATE","FIRST","LAST","RACE","ETHNICITY","GENDER","STATE","HEALTHCARE_EXPENSES","HEALTHCARE_COVERAGE"))

import_measures_csv(
    csv_path = "./video-11-12/csv_100/measures_100.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION",
    value = "VALUE")

import_events_csv(
    csv_path = "./video-11-12/csv_100/events_100.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION")

import_periods_csv(
    csv_path = "./video-11-12/csv_100/periods_100.csv",
    stat_unit = "PATIENT",
    begin = "START",
    end = "STOP",
    tag = "DESCRIPTION")

show_env()

result <- (
    analysr_env
    %>% observed(`Body Weight` < 80)
    %>% described_by(GENDER == "F")
    %>% at_least(5 * days)
    %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
    %>% add_description("Women who have Weight<80kg after cancer therapy")
)

# Print selection
print(result$selection)

result <- result %>% extract_feature("Women who have Weight<80kg after cancer therapy")

# Print stat_units
print(result$stat_units)

View(result)


