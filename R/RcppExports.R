# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Fit the Bradley-Terry model using the EM or MM algorithm
#' @param W a K*K square matrix of class "dgCMatrix"
#' @param a the shape parameter of the gamma prior 
#' @param b the rate parameter of the gamma prior
#' @param maxit the maximum number of iterations
#' @param epsilon controls the convergence criteria
#' @return A list containing a K*1 matrix with the pi estimate, the N matrix, the number of iterations, and whether the algorithm converged.
BT_EM <- function(W, a, b, maxit = 5000L, epsilon = 1e-3) {
    .Call(`_BradleyTerryScalable_BT_EM`, W, a, b, maxit, epsilon)
}

btprob_vec <- function(pi) {
    .Call(`_BradleyTerryScalable_btprob_vec`, pi)
}

fitted_vec <- function(pi, N) {
    .Call(`_BradleyTerryScalable_fitted_vec`, pi, N)
}

