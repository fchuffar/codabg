## Scoring functions :
##  - MAE     : the metric to compare 2 vectors or matrices
##  - compare : the scoring function
## ========================================================================== ##

#' The Incorrect Answers Proportion (IAP)
#'
#' @param data_truth a vector or a matrix
#' @param data_pred a vector or a matrix, with same dimensions as the 'data_truth' parameter
#' @return the Incorrect Answers Proportion
IAP <- function(data_truth, data_pred) {
    # Incorrect Answers Counts
    return( (length(data_truth) - sum(data_truth == data_pred)) / length(data_truth))
}

#' The function to compare 2 vectors or 2 matrices
#'
#' @param data_truth a vector or a matrix
#' @param data_pred a vector or a matrix, with same dimensions as the 'data_truth' parameter
#' @param metric the name of the function to use as a metric
#' @return the measure obtain from the metric
compare <- function(data_truth, data_pred, metric = "IAP") {
    stopifnot(
        exprs = {
            is.vector(x = data_truth) && is.vector(x = data_pred)
        } || {
            is.matrix(x = data_truth) && is.matrix(x = data_pred)
        }
    )

    if ( is.vector(x = data_truth) ) {
        stopifnot(
            exprs = length(x = data_truth) == length(x = data_pred)
        )
    }
    if ( is.matrix(x = data_truth) ) {
        stopifnot(
            exprs = {
                nrow(x = data_truth) == nrow(x = data_pred)
            } && {
                ncol(x = data_truth) == ncol(x = data_pred)
            }
        )
    }

    ## Computation of the metric :
    res <- get(x = metric)(data_truth = data_truth, data_pred = data_pred)
    
    return( res )
}
