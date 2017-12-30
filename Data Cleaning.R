rm(list = ls())

library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(mice)

datapath <- "C:/Users/yfei/Desktop/Kaggle/Titanic/data"

# Read in the data
training <- read.csv(file.path(datapath, "train.csv"), stringsAsFactors = FALSE) %>%
  mutate(type = "Training")
test <- read.csv(file.path(datapath, "test.csv"), stringsAsFactors = FALSE) %>%
  mutate(type = "Test")

stacked <- bind_rows(training, test)

### Clean Data
# Create family name variable
stacked <- stacked %>%
  mutate(Family_Name = sapply(Name, function(x) str_split(x, ",")[[1]][1]))

# Impute missing ages
age_impute <- stacked %>%
  filter(!is.na(Age))

missing_ages <- stacked %>%
  filter(is.na(Age))

