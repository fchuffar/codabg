## ========================================================================== ##
##
## Authors: Alexis ARNAUD, UGA
## alexis.arnaud@univ-grenoble-alpes.fr
##
## ========================================================================== ##



## Package dependencies :
##  - rmarkdown : generation of details about the results as a html file
## ========================================================================== ##

for ( package in c("utils") ) {
    if ( !{ package %in% installed.packages( ) } ) {
        install.packages(pkgs = package, repos = "https://cloud.r-project.org")
    }
}
remove(list = "package")



## Input / Output parameters :
## ========================================================================== ##

## define input/output from command line args and remove white spaces (should in principle never be changed except if you need more functionalities)

args <- commandArgs(trailingOnly = TRUE)

## directory where the ingestion program is located :
ingestion_program  <- trimws(x = args[ 1 ] )
## input data directory :
input              <- trimws(x = args[ 2 ] )
## output directory (where predictions are written) :
output             <- trimws(x = args[ 3 ] )
## directory of the code submitted by the participants :
submission_program <- trimws(x = args[ 4 ] )

## There are 2 other directories that can be used by the ingestion program :
##  - hidden reference data directory :
## hidden             <- trimws(x = args[ 5 ] )
##  - directory shared with the participant's code (which is executed simultaneously) :
## shared             <- trimws(x = args[ 6 ] )
## If you need them, you have to modify the 'metadata' file inside the ingestion program directory :
## command: Rscript $ingestion_program/ingestion.R $ingestion_program $input $output $submission_program $hidden $shared

## We display some information for debug purpose :
print(x = "Ingestion program directory :")
print(x = list.files(path = ingestion_program  , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
print(x = "Input directory :")
print(x = list.files(path = input              , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
print(x = "Output directory :")
print(x = list.files(path = output             , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
print(x = "Submission program directory :")
print(x = list.files(path = submission_program , all.files = TRUE, full.names = TRUE, recursive = TRUE) )

## print(x = "Hidden reference data directory :")
## print(x = list.files(path = hidden , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
## print(x = "Shared directory :")
## print(x = list.files(path = shared , all.files = TRUE, full.names = TRUE, recursive = TRUE) )

## output files
output_program       <- paste0(output, .Platform$file.sep, "output_program.txt")
output_profiling     <- paste0(output, .Platform$file.sep, "Rprof.out"         )
output_profiling_rds <- paste0(output, .Platform$file.sep, "Rprof.rds"         )
output_results       <- paste0(output, .Platform$file.sep, "results.rds"       )
file.create(output_program, output_profiling)

## read input data :
input <- readRDS(file = paste0(input, .Platform$file.sep, "input_data.rds") )

## read code submitted by the participants :
.tempEnv <- new.env( )
wd       <- getwd( )
setwd(dir = submission_program)
source(file = "program.R", local = .tempEnv)
setwd(dir = wd)
program <- .tempEnv$program
remove(list = ".tempEnv")


## Evaluation of the participant code :
## ========================================================================== ##

## We fix the seed in case the participant code requires some random generations :
set.seed(seed = 1)

## diverting R output to a text file :
sink(file = output_program, append = FALSE)

utils::Rprof(
    filename         = output_profiling
  , append           = FALSE
  , interval         = 0.1
  , memory.profiling = TRUE
  , gc.profiling     = FALSE
  , line.profiling   = TRUE
)
prediction <- program(
    input = input
)
utils::Rprof(filename = NULL)

profiling <- utils::summaryRprof(filename = output_profiling, memory = "both", lines = "both")

## stop diverting R output to a text file
sink(file = NULL)

saveRDS(
    object = prediction
  , file   = output_results
)
saveRDS(
    object = profiling
  , file   = output_profiling_rds
)

## We display some information for debug purpose :
print(x = "Output directory :")
print(x = list.files(path = output , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
