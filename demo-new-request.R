# On charge la version d'AnalysR qui nous interesse
remove.packages("analysr")
devtools::install_github("analysr/analysr@691a4c1")
# '75efef9' numéro pour identifier le commit (en effet ce code est ammené à évoluer)
.rs.restartR()
rm(list=ls())

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

load_env_csv("./csv/before/before/")

show_env(analysr_env)

result <- (
  analysr_env
  %>% observed(Temperature > 38.5)
  %>% at_most(15 * days)
  %>% before("Surgery")
)

show_env(analysr_env)

print(result)
