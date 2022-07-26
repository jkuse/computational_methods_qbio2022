install.packages("sf")
install.packages("tmap")

library(sf)
library(raster)
library(tmap)
library(ggplot2)
library(dplyr)
data(World)

# package tmap has a syntax similar to ggplot. The functions start all with tm_
tm_shape(World) +
  tm_borders()

#head(World)
names(World)
class(World)
dplyr::glimpse(World)

plot(World[1])
plot(World[,1])
plot(World[1,])
plot(World["pop_est"], main = "Population")

plot(World["continent"], main = "Continent")
par(mar = c(5, 5, 5, 5))

head(World[, 1:4])
class(World)
class(World$geometry)

head(sf::st_coordinates(World))

# taking off the "geomtry" from the data frame
no_geom <- sf::st_drop_geometry(World)
class(no_geom)

#bounding boxes
st_bbox(World)

names(World)
unique(World$continent)

# pipe syntax to filter information of a df to plot
World %>%
  filter(continent == "South America") %>%
  tm_shape() +
  tm_borders()

World %>%
  mutate(our_countries = if_else(iso_a3 %in% c("COL","BRA", "MEX", "ARG"), "darkred", "grey")) %>%
  tm_shape() +
  tm_borders() +
  tm_fill(col = "our_countries") +
  tm_add_legend("fill",
                "Countries QBio Program",
                col = "darkred")

# to transform sp objects in sf
# (function sf::st_as_sf())

# Loading, ploting, and saving a shapefile from the disk
install.packages("rnaturalearth")
install.packages("remotes")
remotes::install_github("ropensci/rnaturalearthhires")
library(rnaturalearth)
library(rnaturalearthhires)
bra <- ne_states(country = "brazil", returnclass = "sf")
plot(bra)

dir.create("data/shapefiles", recursive = TRUE)
st_write(obj = bra, dsn = "data/shapefiles/bra.shp", delete_layer = TRUE)

bra2 <- read_sf("data/shapefiles/bra.shp")
plot(bra2)
class(bra)
class(bra2)

# Loading, ploting, and saving a raster from the disk
library(raster)
dir.create(path = "data/raster/", recursive = TRUE)
tmax_data <- getData(name = "worldclim", var = "tmax", res = 10, path = "data/raster/")
plot(tmax_data)

is(tmax_data) #the data are a raster stack, several rasters piled

dim(tmax_data) # number of rows, number of columns, number of layers
extent(tmax_data)
res(tmax_data)
