## glm and glmm exercises
install.packages("bbmle")
library(bbmle)
cuckoo <- read.csv("data/raw/valletta_cuckoo.csv")

# create models to represent each hypotesis
h1 <- glm(Beg ~ Mass, data = cuckoo,
          family = poisson(link = log))

h2 <- glm(Beg ~ Mass + Species, data = cuckoo,
          family = poisson(link = log))

h3 <- glm(Beg ~ Mass * Species, data = cuckoo,
          family = poisson(link = log))

h0 <- glm(Beg ~ 0, data = cuckoo,
          family = poisson(link = log))

summary(h3)

# Using AIC to confront simultaneously multiple hypotheses

bbmle::AICtab(h0, h1, h2, h3, base = TRUE, weights = TRUE)

