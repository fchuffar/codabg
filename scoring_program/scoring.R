## ========================================================================== ##
##
## Authors: Alexis ARNAUD, UGA
## alexis.arnaud@univ-grenoble-alpes.fr
##
## ========================================================================== ##



## Package dependencies :
##  - rmarkdown : generation of details about the results as a html file
## ========================================================================== ##

for ( package in c("rmarkdown") ) {
    if ( !{ package %in% installed.packages( ) } ) {
        install.packages(pkgs = package, repos = "https://cloud.r-project.org")
    }
}
remove(list = "package")




## Input / Output parameters :
## ========================================================================== ##

## define input/output from command line args and remove white spaces (should in principle never be changed)
args <- commandArgs(trailingOnly = TRUE)

## input data directory :
input   <- trimws(x = args[ 1 ] )
## output directory (where data_preds are written) :
output  <- trimws(x = args[ 2 ] )
## scoring program directory :
program <- trimws(x = args[ 3 ] )

source(paste0(program, "/scoring_functions.R"))

## We display some information for debug purpose :
print(x = "Input directory :")
print(x = list.files(path = input  , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
print(x = "Output directory :")
print(x = list.files(path = output , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
print(x = "Scoring program directory :")
print(x = list.files(path = program, all.files = TRUE, full.names = TRUE, recursive = TRUE) )

## load submited results from participant or participant program :
# data_pred <- readRDS(file = paste0(input, .Platform$file.sep, "res", .Platform$file.sep, "results.rds") )
# data_pred = read.table("submissions/results.txt", stringsAsFactors=FALSE)
data_pred = read.table(paste0(input, .Platform$file.sep, "res", .Platform$file.sep, "results.txt"), stringsAsFactors=FALSE)

## load R profiling of the data_pred (if existing) :
profilingPath <- paste0(input, .Platform$file.sep, "res", .Platform$file.sep, "Rprof.rds")
profiling <- NULL
if ( file.exists( profilingPath ) ) {
    profiling <- readRDS(file = profilingPath)
}
remove(list = c("profilingPath") )

## load data_truth data :
# data_truth <- readRDS("~/projects/bundle_generation/histpred2.0/data_truth.rds")
data_truth <- readRDS(file = paste0(input, .Platform$file.sep, "ref", .Platform$file.sep, "data_truth.rds") )

## Score file to write :
scoreFile <- paste0(output, .Platform$file.sep, "scores.txt")



## Scoring :
## ========================================================================== ##

## score participants :
# stopifnot(exprs = sum( names(x = data_truth) != names(x = data_pred) ) == 0 )

# source("~/projects/bundle_generation/histpred2.0/scoring_program/scoring_functions.R")
scores <- compare(data_truth=as.vector(data_truth), data_pred=data_pred[,1])
# names(x = scores) <- names(x = data_truth)

# print(x = "Scores :")
# print(x = paste0(paste( paste(names(x = scores), scores, sep = " = "), collapse = ", ") ) )

print(paste0("score_1: ", sum( unlist(x = scores))))


## Generation of the score file :
cat(paste0("score_1: ", sum( unlist(x = scores) ), "\n"), file = scoreFile, append = FALSE)
# if ( length(x = scores) >= 2 ) {
#     for ( i in names(x = scores) ) {
#         cat(paste0(i , ": ", scores[[ i ]], "\n"), file = scoreFile, append = TRUE)
#     }
# }

## Generation of a (more) detailed file :
rmarkdown::render(
               input       = paste0(program, .Platform$file.sep, "detailed_results.Rmd")
             , envir       = parent.frame( )
             , output_dir  = output
             , output_file = "scores.html"
           )

## We display some information for debug purpose :
print(x = "Output directory :")
print(x = list.files(path = output, all.files = TRUE, full.names = TRUE, recursive = TRUE) )
