library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(grid)
library(gridExtra)
library(cowplot)
library(quickpsy)

setwd("~/Documents/GitHub/CB206-Git/20181103_fourier_noise/CodeBCS206/AnalysisBCS206")
df <- read.csv("data.csv")

ggplot(df, aes(x=signal, y=choice)) + geom_point() + geom_smooth(method='lm') #+ geom_smooth(method="glm")



fit_no_lapse <- quickpsy(df, x=signal, k=choice, lapses=F, guess=F)
fit_lapse <- quickpsy(df, x=signal, k=choice, lapses=T, guess=F)

grid.arrange(plotcurves(fit_no_lapse)+xlim(c(-5, 5)),
plotcurves(fit_lapse)+xlim(c(-5, 5)), nrow=2)







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
