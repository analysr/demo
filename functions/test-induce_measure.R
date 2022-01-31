library(analysr)

setup_new_env()

show_env()
load_env_csv("./csv/induce_measure/before1")

induce_measure(analysr_env, "BMI", Weight / (Size * Size))
show_env()
