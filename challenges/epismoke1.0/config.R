configurationYaml_title = "Smoking Status Prediction Challenge 1.0 (epismoke1.0)"
configurationYaml_description = "The challenge provides 2 *data.frames* (`data_train` and `data_test`) of individuals described by their `smoking_status` and the DNA methylation profile of their blood.
The objective of the challenge is to train a statistical or machine learning model (*e.g.* linear model, support vector machine or penalized regression) on the DNA methylation matrix of the training set to predict the `smoking_status` of the test set.
"
metric = "IAP"
configurationYaml_leaderboard_columns_score_name_sort = "asc"
submission_script_R = "challenges/epismoke1.0/submission_script.R"
generate_data_rmd_file = "challenges/epismoke1.0/generate_data.Rmd"


params = list()
params$package_repository = "https://cloud.r-project.org"
