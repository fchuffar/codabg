configurationYaml_title = "Sample sex prediction challenge 0.3 (sexpred0.3)"
configurationYaml_description = "The challenge provides the data.frame `d` of tumoral samples described by sex, age, histology and genes expression values. Some sex status are missing. The goal of the challenge is to use statistical models (e.g. logistic regression) to predict missing sex status using provided gene expression values and clinical attributes."
generate_data_rmd_file = "challenges/sexpred0.3/generate_data.Rmd"
metric = "IAP"
configurationYaml_leaderboard_columns_score_name_sort = "asc"
submission_script_R = "challenges/sexpred0.3/submission_script.R"


params = list()
params$package_repository = "https://cloud.r-project.org"
