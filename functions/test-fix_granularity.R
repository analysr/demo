library(analysr)

setup_new_env()

load_env_csv("./csv/fix_granularity/before1")

show_env()
fix_granularity(
    tag_wanted = "Kaliemie",
    period_start = lubridate::ymd("06-11-10"),
    period_end = lubridate::ymd("06-11-17"),
    stat_unit_wanted = c(101929076, 101929077),
    temporal_granularity = lubridate::days())

show_env()
