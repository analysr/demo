library(analysr)
library(tidyverse)
library(ddpcr)
setup_new_env()

quiet({
  import_measures_csv(
    csv_path = "../test-25-11/csv_1000/measures_1000.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION",
    value = "VALUE")

  import_events_csv(
    csv_path = "../test-25-11/csv_1000/events_1000.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION")

  import_periods_csv(
    csv_path = "../test-25-11/csv_1000/periods_1000.csv",
    stat_unit = "PATIENT",
    begin = "START",
    end = "STOP",
    tag = "DESCRIPTION")
  import_stat_units_csv(
    csv_path = "../test-25-11/csv_1000/patients_1000.csv",
    stat_unit = "UserId",
    optional_data = c("BIRTHDATE","DEATHDATE","FIRST","LAST","RACE","ETHNICITY","GENDER","STATE","HEALTHCARE_EXPENSES","HEALTHCARE_COVERAGE"))
  

}, all = TRUE)
