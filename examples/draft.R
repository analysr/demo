
# result <- (
#   analysr_env
#   %>% observed(`Body Weight` < 100)
#   %>% described_by(TYPE == "numeric")
# )
# show_env(result)
# show_env()
# print(result$selection)

# result2 <- (
#   analysr_env
#   %>% observed(`Body Weight` > 50)
#   %>% at_most(20 * days)
#   %>% described_by(TYPE == "numeric")
#   %>% before("Medication Reconciliation (procedure)")
#   %>% from(lubridate::parse_date_time("2012/01/01 08:00:00", "ymd-HMS"))
#   %>% to(lubridate::parse_date_time("2013/01/01 08:00:00", "ymd-HMS"))
#   %>% add_description("TEST")

# )
# show_env()

# result2 <- (
#   analysr_env
#   %>% observed(`Body Weight` > 50)
#   %>% at_most(20 * days)
#   %>% described_by(TYPE == "numeric")
#   %>% before("Medication Reconciliation (procedure)")
# )
# show_env()


load_env_csv('./test-25-11/after-import')
result2 <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% at_least(5 * days)
  %>% described_by(GENDER == "F")
  %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
)
print(result2$selection)



result <- (
  analysr_env
  %>% observed(`Body Weight` < 80)
  %>% at_least(5 * days)
  %>% after(`Combined chemotherapy and radiation therapy (procedure)`)
)


print(result2$selection)
