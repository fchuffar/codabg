configurationYaml_title = "Gene expression prediction challenge 0.1 (expred0.1)"
configurationYaml_description = "The challenge provides the two data.frame `data_train` and `data_test` of tumoral samples described by sex, age, histology and genes expression values. In `data_test`, expression values for the first gene are missing. The goal of the challenge is to use statistical models (e.g. linear regression) to predict missing expression values using provided gene expression values and clinical attributes."
metric = "RMSE"
configurationYaml_leaderboard_columns_score_name_sort = "asc"
submission_script_R = "challenges/expred0.1/submission_script.R"
generate_data_rmd_file = "challenges/expred0.1/generate_data.Rmd"

# challenge_dir = "challenges/expred0.1"; system("bash clean.sh"); rmarkdown::render("Bundle_generator_-_cmd.Rmd") ; source(submission_script_R) ; foo = sapply(names(alternative_programs), function (p) {generate_submission_files(alternative_programs[[p]], data_train, data_test, p)})
