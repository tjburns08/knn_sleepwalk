# Code: a helper function for sleepwalk for KNN visualization
# Author: Tyler J Burns
# Date: November 16, 2022

#' @title KNN Sleepwalk
#' @description Takes a data matrix and a 2-D embedding as input. It produces 
#' a 'KNN matrix' and places that along with the aforementioned inputs into the
#' sleepwalk function.
#' @param mat A data matrix with data points as rows and features as columns.
#' the matrix must already be filtered by the markers you care about.
#' @param embedding The 2-D embedding of the data matrix, in matrix format with
#' data points as rows and two columns.
#' @param k The number of nearest neighbors to be visualized
KnnSleepwalk <- function(mat, embedding, k = 100) {
    message('Building distance matrix')
    dist_mat <- dist(mat) %>% as.matrix()
    message("Finding k-nearest neighbors")
    nn_mat <- lapply(seq(nrow(dist_mat)), function(i) {
        curr <- dist_mat[i,]
        max_dist <- sort(curr)[k] # This is the K
        curr <- ifelse(curr <= max_dist, curr, 100) # A large number
        return(curr)
    }) %>% do.call(rbind, .)
    sleepwalk::sleepwalk(embeddings = embedding, distances = nn_mat)
}