# Author: Richard Ian Carpenter

# Date Created: 03 Apr 2025
# Date Updated: 03 Apr 2025

# Project: Dow Jones Historical Data

# Purpose: --

# Initial libraries:
library(ggplot2)
library(dplyr)
library(tidyquant)

# Getting the Dow Jones Industrial Average data:
getSymbols(Symbols = "^DJI",
           from = "2025-01-01",
           to = "2025-04-08")

# Quick look:
head(DJI)

# Cleaning up:
dji_data_start <- data.frame(DJI)
dji_data_start$date <- as.Date(rownames(dji_data_start))
rownames(dji_data_start) <- NULL
dji_data_start <- dji_data_start[ ,c(7, 1:6)]
colnames(dji_data_start) <- c("date", "open", "high",
                       "low", "close", 
                       "volume", "adjusted")
head(dji_data_start)

# Do some math here:
dji_data_start$daily_change <- dji_data_start$close - lag(dji_data_start$close)

# Slicing the dataset:
dji_data_set <- dji_data_set <- slice(dji_data_start, 12:n())


# Plotting:

ggplot(data = dji_data_set,
       aes(x = date,
           y = close)) +
  geom_line() +
  geom_hline(yintercept = 44025.81, linetype = "dashed", color = "blue") +
  theme_minimal() +
  scale_x_date("Date") +
  labs(title = "Dow Jones Index, 20 Jan 2025 to 7 Apr 2025",
       x = "Date", y = "Closing Value", 
       caption = "Source: Yahoo! Finance")

ggplot(data = dji_data_set,
       aes(x = date,
           y = daily_change)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "blue") +
  theme_minimal() +
  scale_x_date("Date") +
  labs(title = "Dow Jones Index, 20 Jan 2025 to 7 Apr 2025",
       x = "Date", y = "Closing Value", 
       caption = "Source: Yahoo! Finance") 

