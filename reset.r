# On charge la version d'AnalysR qui nous intéresse
remove.packages("analysr")
detach("package:analysr", unload = TRUE)
devtools::install_github("analysr/analysr@886f82e")
# '75efef9' numéro pour identifier le commit
rm(list=ls())
.rs.restartR()




