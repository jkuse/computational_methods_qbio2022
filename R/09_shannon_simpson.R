shannon <- function(x) {
  pi <- x/sum(x)
  H <- -sum(pi * log(pi))
}

simpson <- function(x) {
  pi <- x/sum(x)
  Simp <- 1 - sum(pi^2)
}

my_diversity <- function(X, index = "shannon") {
  pi <- x/sum(x)
  if (index == "shannon") d <- -sum(pi * log(pi))
  if (index == "simpson") d <- 1 - sum(pi^2)
  return (d)
}

