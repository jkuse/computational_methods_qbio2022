library(vegan)
# taxonomic diversity

comm_A <- c(10, 6, 4, 1)
comm_B <- c(17, rep(1,7))

diversity(comm_A, "shannon")
diversity(comm_B, "shannon")
diversity(comm_A, "invsimpson")
diversity(comm_B, "invsimpson")

ren_comm_A <- renyi(comm_A)
ren_comm_B <- renyi(comm_B)

ren_AB <- rbind(ren_comm_A, ren_comm_B)
matplot(t(ren_AB), type = "l", axes = F,
        ylab = "Rényi Diversity")
box()
axis(side = 2)
axis(side = 1, labels = c(0, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, "Inf"), at = 1:11)
legend("topright",
       legend = c("Community A", "Community B"),
       lty = c(1,2),
       col = c(1,2))

# functional diversity
install.packages("Phylomatic")
