# Load required libraries
library(dplyr)
library(fable)
library(tsibble)

# Load training data
train <- readRDS("Data/train_data.rds")

# Cross-validation
cv_splits <- train %>% stretch_tsibble(.init = 104, .step = 52)

cv_results <- cv_splits %>%
  group_by(Sex, Age) %>%
  model(
    MEAN = MEAN(Mortality),
    SNAIVE = SNAIVE(Mortality),
    DRIFT = RW(Mortality ~ drift()),
    TSLM = TSLM(Mortality ~ trend() + season()),
    ARIMA = ARIMA(Mortality)
  ) %>%
  forecast(h = "1 year") %>%
  accuracy(train)

cv_summary <- cv_results %>%
  group_by(.model) %>%
  summarise(
    AVG_MAE = mean(MAE),
    AVG_RMSE = mean(RMSE),
    AVG_MAPE = mean(MAPE)
  )

# Save results
write.csv(cv_summary, "Results/cv_summary.csv", row.names = FALSE)
