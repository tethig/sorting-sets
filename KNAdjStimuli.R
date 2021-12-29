library(tidyverse)
setwd("~/Desktop")
# Prepare Function

proportion_adjacency <- function(k) {
  prop <- 1/(k-1) # ((2*k)-2)/(k^2-k)
  return(prop)
}

k_vector <- 2:7
y_values <- proportion_adjacency(k_vector)

data <- tibble(stimuli = k_vector, adjprop = y_values)
ggplot(data, aes(x=stimuli, y=adjprop)) + geom_bar(stat="identity", colour="black", fill="lightgrey") + scale_x_continuous(breaks=k_vector) + theme_bw()
ggsave("stimuli.pdf")
