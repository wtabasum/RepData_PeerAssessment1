---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---
## Installing and loading necessary packages

install.packages("kniter")
library(knitr)
install.packages("dplyr")
library(dplyr)
install.packages("lubridate")
library(lubridate)
install.packages("ggplot2")
library(ggplot2)

## Loading and preprocessing the data
getwd()
data <- read.csv("activity.csv", header = TRUE, sep = ',', 
colClasses = c("numeric", "character", "integer"))

## formating the date

data$date <- ymd(data$date)
str(data)
head(data)

## Calculate the total numb of steps according to date

steps <- data %>%
  filter(!is.na(steps)) %>%
  group_by(date) %>%
  summarize(steps = sum(steps)) %>%
  print
  
## make the histogram for steps based on date 
  
  ggplot(steps, aes(x = steps)) +
  geom_histogram(fill = "firebrick", binwidth = 1000) +
  labs(title = "Histogram of Steps per day", x = "Steps per day", y = "Frequency")


## What is mean total number of steps taken per day?

mean_steps <- mean(steps$steps, na.rm = TRUE)
median_steps <- median(steps$steps, na.rm = TRUE)
 mean(mean_steps)
 median(median_steps)

Mean steps are 10766 and median steps are 10765. 

## What is the average daily activity pattern?

interval <- data %>%
  filter(!is.na(steps)) %>%
  group_by(interval) %>%
  summarize(steps = mean(steps))
  
## we use ggplot for the graph
 
  ggplot(interval, aes(x=interval, y=steps)) +
  geom_line(color = "firebrick")
  
  interval[which.max(interval$steps),]
  Using the above function we found that in 835 days the average step was 206
## find the steps per day using ggplot2 

ggplot(steps_full, aes(x = steps)) +
  geom_histogram(fill = "firebrick", binwidth = 1000) +
  labs(title = "Histogram of Steps per day, including missing values", x = "Steps per day", y = "Frequency")

## Imputing missing values

sum(is.na(data$steps))

There are 2304 missing data 

## Are there differences in activity patterns between weekdays and weekends?

From the two plots it seems that the test object is more active earlier in the day during weekdays compared to weekends, but more active throughout the weekends compared with weekdays (probably because the oject is working during the weekdays, hence moving less during the day).

data <- mutate(data, weektype = ifelse(weekdays(data$date) == "Saturday" | weekdays(data$date) == "Sunday", "weekend", "weekday"))
data$weektype <- as.factor(data$weektype)
head(data)

## removing missing data 

complete.cases(data)
!complete.cases(data)
data[complete.cases(data), ]

data_full <- data
nas <- is.na(data_full$steps)
avg_interval <- tapply(data_full$steps, data_full$interval, mean, na.rm=TRUE, simplify=TRUE)
data_full$steps[nas] <- avg_interval[as.character(data_full$interval[nas])]

sum(is.na(data_full$steps)) ## now we have 0 missing values 

## we will need to find weekday vs weekedns 

data_full <- mutate(data_full, weektype = ifelse(weekdays(data_full$date) == "Saturday" | weekdays(data_full$date) == "Sunday", "weekend", "weekday"))
data_full$weektype <- as.factor(data_full$weektype)
head(data_full)

## Plot the steps in weekdays vs weekends 

interval_full <- data_full %>%
  group_by(interval, weektype) %>%
  summarise(steps = mean(steps))
s <- ggplot(interval_full, aes(x=interval, y=steps, color = weektype)) +
  geom_line() +
  facet_wrap(~weektype, ncol = 1, nrow=2)
print(s)
