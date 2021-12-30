# Set location
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/Github/sorting-sets")

# Load library
library(tidyverse)

# Prepare Function
proportion_adjacency <- function(k, n) {
  prop <- ( (2*k) - 2 )/( (k^2*n) - k )
  return(prop)
}

# Prepare vectors
k_vector <- 2:7
n_vector <- 2:7
## note that function with vectorise over k but not over n

# Run function repeatedly for different values of n and bind columns
data <- n_vector %>% map(~ proportion_adjacency(k_vector, .x)) %>% map_dfc(~.)
# Name columns by n values
colnames(data) = n_vector
# Add column containing k values
data <- data %>% mutate(num_stimuli = k_vector) %>% select(num_stimuli, everything())
# Tidy data with n values as character variable
( data <- pivot_longer(data, `2`:`7`, names_to = "group_size", values_to = "adjacent_prob") )

# Plot with k as x axis and n as facetting factor
ggplot(data, aes(x=num_stimuli, y=adjacent_prob)) + 
  geom_bar(stat="identity", colour="black", fill="lightgrey") + 
  scale_x_continuous(breaks=k_vector) + 
  facet_grid(~group_size) +
  theme_bw()

ggsave("stimuli.pdf")
