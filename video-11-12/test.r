library(analysr) # Our package
library(tidyverse) # to have %>% function

setup_new_env()

# import 1000 patients
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

show_env()

start_time <- Sys.time()
result <- (
    analysr_env
    %>% observed(`Body Weight` < 80)
    %>% described_by(GENDER == "F")
    %>% at_least(5 * days)
    %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
    %>% add_description("Women who have Weight<80kg after cancer therapy")
)
end_time <- Sys.time()

sprintf("Nombre de données trouvées: %d",nrow(result$selection))
if (nrow(result$selection)>0){
    print("Exemple d'élément trouvé")
    print(result$selection[1,])
}
time_taken <- end_time - start_time
sprintf("Durée du traitement: %f secondes",time_taken)


# Print selection
print(result$selection)

result <- result %>% extract_feature("Women who have Weight<80kg after cancer therapy")

# Print stat_units
print(result$stat_units)

View(result)


