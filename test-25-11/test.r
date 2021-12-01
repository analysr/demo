# Fonction d'affichage de l'environement

library(analysr)
library(tidyverse)
library(ddpcr)
setup_new_env()
quiet({
    import_measures_csv(
    csv_path = "./test-25-11/csv_100/measures_100.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION",
    value = "VALUE")

    import_events_csv(
    csv_path = "./test-25-11/csv_100/events_100.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION")

    import_periods_csv(
     csv_path = "./test-25-11/csv_100/periods_100.csv",
     stat_unit = "PATIENT",
     begin = "START",
     end = "STOP",
     tag = "DESCRIPTION")
    import_stat_units_csv(
      csv_path = "./test-25-11/csv_100/patients_100.csv",
      stat_unit = "UserId",
      optional_data = c("BIRTHDATE","DEATHDATE","FIRST","LAST","RACE","ETHNICITY","GENDER","STATE","HEALTHCARE_EXPENSES","HEALTHCARE_COVERAGE"))
    save_env_csv('./test-25-11/after-import')

}, all = TRUE)



setup_new_env()
# add 24356,"GENDER","F" to ./test-25-11/after-import/descriptions.csv
load_env_csv('./test-25-11/after-import')
result2 <- (
   analysr_env
   %>% observed(`Body Weight` < 80)
   %>% at_least(5 * days)
   %>% described_by(GENDER == "F")
   %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
)
print(result2$selection)

# result <- (
#   analysr_env
#   %>% observed(`Body Weight` < 100)
#   %>% described_by(TYPE == "numeric")
# )
# show_env(result)
# show_env()
# print(result$selection)

# result2 <- (
#   analysr_env
#   %>% observed(`Body Weight` > 50)
#   %>% at_most(20 * days)
#   %>% described_by(TYPE == "numeric")
#   %>% before("Medication Reconciliation (procedure)")
#   %>% from(lubridate::parse_date_time("2012/01/01 08:00:00", "ymd-HMS"))
#   %>% to(lubridate::parse_date_time("2013/01/01 08:00:00", "ymd-HMS"))
#   %>% add_description("TEST")

# )
# show_env()

# result2 <- (
#   analysr_env
#   %>% observed(`Body Weight` > 50)
#   %>% at_most(20 * days)
#   %>% described_by(TYPE == "numeric")
#   %>% before("Medication Reconciliation (procedure)")
# )
# show_env()
