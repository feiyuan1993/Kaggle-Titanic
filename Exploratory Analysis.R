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

#### Data exploration
stacked <- bind_rows(training, test)

## Survival by Age, Sex
survival_age <- training %>%
  group_by(Age) %>%
  summarize(perc = mean(Survived))

survival_sex <- training %>%
  group_by(Sex) %>%
  summarize(perc = mean(Survived))

survival_cabin <- training %>%
  group_by(Cabin) %>%
  summarize(perc = mean(Survived))

survival_class <- training %>%
  group_by(Pclass) %>%
  summarize(perc = mean(Survived))

survival_class <- training %>%
  group_by(Pclass, Cabin) %>%
  summarize(count = n())
