#Corruption Analysis
cdata <- read.csv(file.choose())
View(cdata)

#Libraries
library(plotly)
library(dplyr)
library(ggplot2)
library(reshape2)
library(corrplot)
library(gganimate)
library(ggExtra)

b <- ggplot(cdata, aes(Continent, CPI)) + geom_boxplot(aes(fill=Continent)) 
ggplotly(b)

f <- ggplot(cdata, aes(GDP_Growth, CPI, color = Continent, size= Magnitude)) +
  geom_point() +
  facet_wrap(~Continent) +
  #ani.options(interval = 0.06) + #animation speed, seconds per frame+
  scale_x_log10() +
  # gganimate specific bits:
  labs(title = 'Year: {frame_time}', x = 'GDP Growth(%)', y = 'CPI Index') +
  transition_time(Year) +
  ease_aes('linear')

f + transition_time(Year) +
  labs(title = "Year: {frame_time}")+
  shadow_wake(wake_length = 0.1, alpha = FALSE)

anim_save("CPI by Continent.gif")

ggplotly(ggplot(cdata, aes(GDP_Growth, CPI, color = Year)) + geom_point())

