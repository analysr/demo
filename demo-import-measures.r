# On charge la version d'AnalysR qui nous interesse
remove.packages("analysr")
detach("package:analysr", unload = TRUE)
devtools::install_github("analysr/analysr@75efef9")
# '75efef9' numéro pour identifier le commit (en effet ce code est ammené à évoluer)
.rs.restartR()

# Fonction d'affichage de l'environement
show_env <- function(env) {
  sapply(ls(env), function(x) get(x, envir = env))
}


library(analysr)
library(tidyverse)

# On crée un pourrait remettre à 0 l'environnement
# mais cela est déjà fait au chargement du package
# setup_new_env()


setup_new_env()

show_env(analysr_env)

import_measures_csv("./csv/import_measures_csv/to_import_1.csv",stat_unit="patient",date="date_prlvt",tag="type_examen",value="valeur",optional_data="effectue_par")

show_env(analysr_env)

import_measures_csv("./csv/import_measures_csv/to_import_2.csv",stat_unit="patient",date="date_prlvt",tag="type_examen",value="valeur")

show_env(analysr_env)


