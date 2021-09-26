# Fonction d'affichage de l'environement
show_env <- function(env) {
  sapply(ls(env), function(x) get(x, envir = env))
}


library(analysr)
library(tidyverse)

# On cr?e un pourrait remettre ? 0 l'environnement
# mais cela est d?j? fait au chargement du package
# setup_new_env()


setup_new_env()

show_env(analysr_env)

import_periods_csv("./csv/import_periods_csv/to_import_1.csv",stat_unit="PERSON",begin="BEGIN",end="END",tag="DESCRIPTION",optional_data="LOCATION")

show_env(analysr_env)

import_periods_csv("./csv/import_periods_csv/to_import_2.csv",stat_unit="PERSON",begin="BEGIN",end="END",tag="DESCRIPTION")

show_env(analysr_env)
