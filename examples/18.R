library(analysr)
library(tidyverse)

setup_new_env()


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
  
  


# Call function here

start_time <- Sys.time()
result <- (
  analysr_env
  %>% observed(`Auscultation of the fetal heart`)
  %>% at_most(90*days)
  %>% before(`Childbirth`)
)
end_time <- Sys.time()

# Answer here

sprintf("Nombre de données trouvées: %d",nrow(result$selection))
if (nrow(result$selection)>0){
  print("Exemple d'élément trouvé")
  print(result$selection[1,])
}
time_taken <- end_time - start_time
sprintf("Durée du traitement: %f secondes",time_taken)

