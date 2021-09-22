# Fonction d'affichage de l'environement
show_env <- function(env) {
  sapply(ls(env), function(x) get(x, envir = env))
}

# On charge la version d'AnalysR qui nous interesse
remove.packages("analysr")
devtools::install_github("analysr/analysr@75efef9")
# '75efef9' numéro pour identifier le commit (en effet ce code est ammené à évoluer)
.rs.restartR()


library(analysr)
library(tidyverse)

# On crée un pourrait remettre à 0 l'environnement
# mais cela est déjà fait au chargement du package
# setup_new_env()

load_env_csv("./csv/before/before/")

show_env(analysr_env)

model_filtred = analysr_env %>% observed(Temperture > 38.5) %>% at_most(15*days) %>% before("Surgery")

show_env(model_filtred)
