IAP=function(data_truth, data_pred) {
  # Incorrect Answers Counts
  return( (length(data_truth) - sum(data_truth == data_pred)) / length(data_truth))
}

compare = function(data_truth, data_pred, metric = "IAP") {
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