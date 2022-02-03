library(analysr)
library(tidyverse)
setup_new_env()

library(tictoc)

tic("Import measures")
import_measures_csv(
  csv_path = "./csv/10k/measures_10000.csv",
  stat_unit = "PATIENT",
  date = "DATE",
  tag = "DESCRIPTION",
  value = "VALUE")
toc()

tic("Import events")
import_events_csv(
  csv_path = "./csv/10k/events_10000.csv",
  stat_unit = "PATIENT",
  date = "START",
  tag = "DESCRIPTION")
toc()

tic("Import periods")
import_periods_csv(
  csv_path = "./csv/10k/periods_10000.csv",
  stat_unit = "PATIENT",
  begin = "START",
  end = "STOP",
  tag = "DESCRIPTION")
toc()

tic("Import stat_units")
import_stat_units_csv(
  csv_path = "./csv/10k/patients_10000.csv",
  stat_unit = "Id",
  optional_data = c("BIRTHDATE","DEATHDATE","FIRST","LAST","RACE","ETHNICITY","GENDER","STATE","HEALTHCARE_EXPENSES","HEALTHCARE_COVERAGE"))
toc()

tic("1")
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
)
toc()

tic("2")
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% before(`Combined chemotherapy and radiation therapy (procedure)`)
)
toc()

tic("3")
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% at_least(5 * days)
  %>% after(`Standard pregnancy test`)
)
toc()

tic("4")
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% from("2006/11/09 08:00:00")
  %>% to("2021/11/11 09:00:00")
)
toc()

tic("5")
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% from(as.Date("2000-10-22"))
)
toc()

tic("6")
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% who_is(LAST == "Kris249")
)
toc()


tic("7")
result <- (
  analysr_env
  %>% observed(`Diastolic Blood Pressure` > 90)
  %>% at_least(5*days)
  %>% after('Medication reconciliation (procedure)')
  %>% add_description("Search")
)
toc()

tic("8")
result <- (
  analysr_env
  %>% observed(`Pain severity`  >= 3)
  %>% at_most(60*days)
  %>% before(`Bone immobilization`)
)
toc()

tic("9")
result <- (
  analysr_env
  %>% observed(`Diastolic Blood Pressure` > 125)
  %>% at_most(45*days)
  %>% after(`Subcutaneous immunotherapy`)
)
toc()

tic("10")
result <- (
  analysr_env
  %>% observed(`Tobacco smoking status NHIS` == 'Never smoker')
  %>% before(`Childbirth`)
)
toc()

tic("11")
result <- (
  analysr_env
  %>% observed(`Estimated Glomerular Filtration Rate` < 60)
  %>% at_most(180*days)
  %>% before(`Renal dialysis (procedure)`)
)
toc()

tic("12")
result <- (
  analysr_env
  %>% observed(`Microalbumin Creatinine Ratio` > 300)
  %>% before(`Renal dialysis (procedure)`)
)
toc()

tic("13")
result <- (
  analysr_env
  %>% observed(`Hematocrit [Volume Fraction] of Blood by Automated count` < 35)
  %>% at_most(60*days)
  %>% before(`Combined chemotherapy and radiation therapy (procedure)`) 
)
toc()

tic("14")
result <- (
  analysr_env
  %>% observed(`Estimated Glomerular Filtration Rate`)
  %>% before(`Renal dialysis (procedure)`)
)
toc()

tic("15")
result <- (
  analysr_env
  %>% observed(`Knee X-ray`)
  %>% before(`Surgical manipulation of joint of knee`)
)
toc()

tic("16")
result <- (
  analysr_env
  %>% observed(`Surgical manipulation of joint of knee`)
  %>% before(`Knee X-ray`)
)
toc()

tic("17")
result <- (
  analysr_env
  %>% observed(`Hemoglobin [Mass/volume] in Blood` > 16)
  %>% at_most(60*days)
  %>% after(`Appendectomy`)
)
toc()

tic("18")
result <- (
  analysr_env
  %>% observed(`Auscultation of the fetal heart`)
  %>% at_most(90*days)
  %>% before(`Childbirth`)
)
toc()

tic("19")
result <- (
  analysr_env
  %>% observed(`Hepatitis C antibody test`)
  %>% at_least(10*days)
  %>% after(`Standard pregnancy test`)
)
toc()

tic("20")
result <- (
  analysr_env
  %>% observed(`Calcium` > 9.8)
)
toc()

tic("21")
result <- (
  analysr_env
  %>% observed(`Medication Reconciliation (procedure)`)
  %>% at_most(90*days)
  %>% after(`Colonoscopy`)
)
toc()

tic("22")
result <- (
  analysr_env
  %>% observed(`Body Mass Index` > 28)
  %>% at_most(360*days)
  %>% after(`Insertion of subcutaneous contraceptive`)
)
toc()

tic("23")
result <- (
  analysr_env
  %>% observed(`Electrical cardioversion`)
  %>% before(`Echocardiography`)
)
toc()