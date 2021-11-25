# Fonction d'affichage de l'environement


show_env <- function(env) {
    print(sapply(ls(env), function(x) get(x, envir = env)))
}



library(analysr)
library(tidyverse)
library(ddpcr)

quiet({
    import_measures_csv(
    csv_path = "./test-25-11/csv_100/measures_100.csv",
    stat_unit = "PATIENT",
    date = "DATE",
    tag = "DESCRIPTION",
    value = "VALUE",
    optional_data = "TYPE")
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
}, all = TRUE)

show_env(analysr_env)

result <- (
  analysr_env
  %>% observed(`Body Weight` < 100)
  %>% described_by(TYPE == "numeric")
)
show_env(result)
print(result$selection)

result2 <- (
  analysr_env
  %>% observed(`Body Weight` < 100)
  %>% at_least(1000000 * days)
  %>% described_by(TYPE == "numeric")
  %>% before("Physical therapy procedure")
)

print(result2)

