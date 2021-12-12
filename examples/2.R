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

# Call functions here


# After or before events
# Standard pregnancy test
# Screening for occult blood in feces (procedure)
# Urine culture
# Medication Reconciliation (procedure)
start.time <- Sys.time()
result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% before(`Combined chemotherapy and radiation therapy (procedure)`)
)
end.time <- Sys.time()

# Answer here

sprintf("Nombre de données trouvées: %d",nrow(result$selection))
if (nrow(result$selection)>0){
  print("Exemple d'élément trouvé")
  print(result$selection[1,])
}
time.taken <- end.time - start.time
sprintf("Durée du traitement: %f secondes",time.taken)
