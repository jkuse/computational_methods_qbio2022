# Time series
install.packages('zoo')
library(dplyr)
library(ggplot2)
library(lubridate)
library(zoo)

#Loading data
covid <- read.csv("data/raw/covid19-dd7bc8e57412439098d9b25129ae6f35.csv")

# First checking the class
class(covid$date)

# Changing to date format
covid$date <- as_date(covid$date)

# Now we can make numeric operations
range(covid$date)

# plotting a time series with ggplot

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal()

# changing negative number for zeros
covid$new_confirmed[covid$new_confirmed < 0] <- 0

# trying again

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal() +
  scale_x_date(breaks = "4 months", date_labels = "%Y - %m") +
  labs(x = "Date", y = "New cases") +
  geom_line(aes(x=date, y=roll_mean), color="darkred", size=1.1)
?geom_line
# rolling mean

covid$roll_mean <- zoo::rollmean(covid$new_confirmed, 14, fill=NA)

