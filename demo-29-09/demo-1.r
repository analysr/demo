# Fonction d'affichage de l'environement

show_env <- function(env) {
  print(sapply(ls(env), function(x) get(x, envir = env)))
}

library(analysr)
library(tidyverse)

# On crée un pourrait remettre à 0 l'environnement
# mais cela est déjà fait au chargement du package
# setup_new_env()
setup_new_env()

cat(crayon::blue$bold("Environement vide\n"))
show_env(analysr_env)

import_measures_csv("./csv/demo-28-09-21/measures.csv")
import_events_csv("./csv/demo-28-09-21/events.csv")

# On peut aussi importer un environement
# load_env_csv("./csv/demo-28-09-21/")

cat(crayon::blue$bold("Environement chargé\n"))
show_env(analysr_env)
