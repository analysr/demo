# Fonction d'affichage de l'environement
show_env <- function(env) {
  sapply(ls(env), function(x) get(x, envir = env))
}

library(analysr)
library(tidyverse)



setup_new_env()

import_events_csv("./csv/test-05-11-21/csv_events_10000.csv", date_format_func = (function (y) {as.Date(y) }))
import_measures_csv("./csv/test-05-11-21/csv_measure_10000.csv")
#import_periods_csv("./csv/test-05-11-21/csv_periods_10000.csv", date_format_func = (function (y) {as.POSIXct(y, format = "%d/%m/%Y") }))


# To save env to csv
#save_env_csv("./csv/test-05-11-21/env-10000")

#show_env(analysr_env)

# To load env
# load_env_csv("./csv/test-05-11-21/env-100")
