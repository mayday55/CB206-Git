library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(grid)
library(gridExtra)
library(cowplot)

# setwd("/Users/Leslie/Google_Drive/BCS206/CB_BCS206/RawData")
df <- read.csv("data.csv")

# I actually don't know which is right (0 or 1). But as long as it's consistent.

df <- df %>% mutate(percent_left = ifelse(df2==1, df1, 1-df1)) %>%
  rename(ratio=df1, ideal_choice=df2, subj_choice=df3)


summary <- df %>% 
  group_by(percent_left) %>%
  summarise(choice_percent=mean(subj_choice))

p1 <- summary %>% 
  ggplot(aes(x=percent_left, y=choice_percent)) +
  stat_smooth(method="glm", se=TRUE, method.args=list(family="binomial"), fullrange=TRUE) +
  geom_point() + theme_minimal()
p1

p1_dummy <- df %>%
  ggplot(aes(x=percent_left, y=subj_choice)) + 
  geom_point() +
  stat_smooth(method="glm", se=TRUE, method.args=list(family="binomial"), fullrange=TRUE) +
  theme_minimal()
p1_dummy

grid.arrange(p1, p1_dummy)
