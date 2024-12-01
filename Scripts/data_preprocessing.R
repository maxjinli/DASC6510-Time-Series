# Load required libraries
library(dplyr)
library(tsibble)
library(fpp3)

# Load dataset
data <- read.csv("Data/aus_mortality.csv")

# Data preprocessing
data <- data %>%
  mutate(Week = yearweek(Week)) %>%
  as_tsibble(index = Week, key = c(Sex, Age))

# Split into training and testing sets
train <- data %>% filter(Week < yearweek("2021 W30"))
test <- data %>% filter(Week >= yearweek("2021 W30"))

# Save preprocessed data
saveRDS(train, "Data/train_data.rds")
saveRDS(test, "Data/test_data.rds")

# Plot time series
plot_data <- ggplot(train, aes(x = Week, y = Mortality, color = interaction(Sex, Age))) +
  geom_line() +
  facet_wrap(~Sex + Age, scales = "free_y") +
  theme_minimal() +
  labs(title = "Weekly Mortality Rates by Demographic Group", x = "Week", y = "Mortality Rate") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        axis.text.y = element_blank(), axis.ticks.y = element_blank())

# Save plot
ggsave("Results/plots/data.png", plot = plot_data, width = 10, height = 6)
