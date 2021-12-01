library(analysr)
library(tidyverse)

setup_new_env()

load_env_csv('./demo-02-12/data')

model <- (
   analysr_env
   %>% observed(`Body Weight` < 80)
   %>% at_least(5 * days)
   %>% described_by(GENDER == "F")
   %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
   %>% add_description("Search")
)


print(model$selection)

model <- (
  analysr_env
  %>% observed(Search)
)
print(model$selection)
