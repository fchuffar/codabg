if (!exists("trimws")) {
  trimws = function (x, which = c("both", "left", "right"), whitespace = "[ \t\r\n]") {
      which <- match.arg(which)
      mysub <- function(re, x) sub(re, "", x, perl = TRUE)
      switch(which, left = mysub(paste0("^", whitespace, "+"), 
          x), right = mysub(paste0(whitespace, "+$"), x), both = mysub(paste0(whitespace, 
          "+$"), mysub(paste0("^", whitespace, "+"), x)))
  }
}

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



## Scoring functions :
##  - MAE     : the metric to compare 2 vectors or matrices
##  - compare : the scoring function
## ========================================================================== ##

#' The Mean Absolute Error (MAE)
#'
#' @param reference a vector or a matrix
#' @param estimation a vector or a matrix, with same dimensions as the 'reference' parameter
#' @return the mean absolute error between the two provided vectors or matrices
MAE <- function(reference, estimation) {
    return( mean(x = abs(x = reference - estimation) ) )
}

#' The function to compare 2 vectors or 2 matrices
#'
#' @param reference a vector or a matrix
#' @param estimation a vector or a matrix, with same dimensions as the 'reference' parameter
#' @param metric the name of the function to use as a metric
#' @return the measure obtain from the metric
compare <- function(reference, estimation, metric = "MAE") {
    stopifnot(
        exprs = {
            is.vector(x = reference) && is.vector(x = estimation)
        } || {
            is.matrix(x = reference) && is.matrix(x = estimation)
        }
    )

    if ( is.vector(x = reference) ) {
        stopifnot(
            exprs = length(x = reference) == length(x = estimation)
        )
    }
    if ( is.matrix(x = reference) ) {
        stopifnot(
            exprs = {
                nrow(x = reference) == nrow(x = estimation)
            } && {
                ncol(x = reference) == ncol(x = estimation)
            }
        )
    }

    ## Computation of the metric :
    res <- get(x = metric)(reference = reference, estimation = estimation)
    
    return( res )
}



## Input / Output parameters :
## ========================================================================== ##

## define input/output from command line args and remove white spaces (should in principle never be changed)
args <- commandArgs(trailingOnly = TRUE)

## input data directory :
input   <- trimws(x = args[ 1 ] )
## output directory (where predictions are written) :
output  <- trimws(x = args[ 2 ] )
## scoring program directory :
program <- trimws(x = args[ 3 ] )

## We display some information for debug purpose :
print(x = "Input directory :")
print(x = list.files(path = input  , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
print(x = "Output directory :")
print(x = list.files(path = output , all.files = TRUE, full.names = TRUE, recursive = TRUE) )
print(x = "Scoring program directory :")
print(x = list.files(path = program, all.files = TRUE, full.names = TRUE, recursive = TRUE) )

## load submited results from participant or participant program :
estimation <- readRDS(file = paste0(input, .Platform$file.sep, "res", .Platform$file.sep, "results.rds") )

## load R profiling of the estimation (if existing) :
profilingPath <- paste0(input, .Platform$file.sep, "res", .Platform$file.sep, "Rprof.rds")
profiling <- NULL
if ( file.exists( profilingPath ) ) {
    profiling <- readRDS(file = profilingPath)
}
remove(list = c("profilingPath") )

## load reference data :
reference <- readRDS(file = paste0(input, .Platform$file.sep, "ref", .Platform$file.sep, "reference_data.rds") )

## Score file to write :
scoreFile <- paste0(output, .Platform$file.sep, "scores.txt")



## Scoring :
## ========================================================================== ##

## score participants :
stopifnot(exprs = sum( names(x = reference) != names(x = estimation) ) == 0 )

scores <- lapply(
    X = names(x = reference)
  , FUN = function( x ) {
      compare(reference = reference[[ x ]], estimation = estimation[[ x ]], metric = "MAE")
  }
)
names(x = scores) <- names(x = reference)

print(x = "Scores :")
print(x = paste0(paste( paste(names(x = scores), scores, sep = " = "), collapse = ", ") ) )

## Generation of the score file :
cat(paste0("score_1: ", sum( unlist(x = scores) ), "\n"), file = scoreFile, append = FALSE)
if ( length(x = scores) >= 2 ) {
    for ( i in names(x = scores) ) {
        cat(paste0(i , ": ", scores[[ i ]], "\n"), file = scoreFile, append = TRUE)
    }
}

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
