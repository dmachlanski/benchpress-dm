library(pcalg)
library(BiDAG)

generateDAG <- function(n, e) {
  # n is number of nodes
  # e is expected number of parents
  n_offdiag <- n * (n - 1) / 2
  offdiag_vec <- rbinom(n_offdiag, 1, e * n / n_offdiag)

  DAG <- matrix(0, n, n)
  DAG[upper.tri(DAG)] <- offdiag_vec
  permy <- sample(1:n)
  return(DAG[permy, permy])
}

generateDAGs <- function(n, e, n_dags) {
  if (n_dags == 1){
    return(generateDAGn(n, e))
  }
  dags <- c()
  for (i  in seq(n_dags)) {
    dags[i] <- generateDAGn(n, e)
  }
  return(dags)
}

#' Title
#'
#' @param n Nmber of nodes
#' @param d  average neighborhood size (children+parents)
#' @param maxneib Maximum number of parents
#'
#' @return
#' @export
#'
#' @examples
generateDAGMaxParents <- function(n, d, maxneib = 5){

  mydag <- NULL
  while (maxneib > 4) {
    # here we make sure graphs do not have to big parent sets
    # here we can define the type of the graph
    # mydag<-randDAG(n, d=2, method ="er")
    mydag <- randDAG(n, d = d, method = "barabasi", par1 = 0.3)
    # mydag<-randDAG(n, d=2, method ="power")
    adj <- dag2adjacencymatrix(mydag)
    maxneib <- max(apply(adj, 2, sum))
  }
  return(mydag)
}