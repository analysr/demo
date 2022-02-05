library(analysr)
library(tidyverse)

setup_new_env()

load_env_csv('./demo-02-12/data')

model <- (
   analysr_env
   %>% observed(`Body Weight` < 50)
   %>% described_by(GENDER == "F")
   %>% at_least(5 * days)
   %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
   %>% add_description("Search")
)


print(model$selection)

model2 <- (
   analysr_env
   %>% observed(`Diastolic Blood Pressure` > 90)
   #%>% described_by(ETHNICITY == "nonhispanic")
   %>% at_least(5 * days)
   %>% after(`Medication Reconciliation (procedure)`)
   %>% add_description("Search")
)


print(model2$selection)
View(model2)


