# Load required libraries
library(dplyr)
library(fable)
library(ggplot2)
library(patchwork)

# Load training and testing data
train <- readRDS("Data/train_data.rds")
test <- readRDS("Data/test_data.rds")

# Fit models
# Mean
fit_mean <- train %>% model(Mean = MEAN(Mortality))
forecast_mean <- fit_mean %>% forecast(new_data = test)
ggsave("Results/plots/mean.png", 
       test %>% autoplot(Mortality, color = "grey") +
         autolayer(forecast_mean, level = NULL) +
         facet_wrap(~Sex + Age, scales = "free_y") +
         labs(title = "Mean Method Forecasts by Group", x = "Week", y = "Mortality Rate") +
         theme_minimal(), width = 10, height = 6)

# Seasonal Naive
fit_naive <- train %>% model(Snaive = SNAIVE(Mortality))
forecast_naive <- fit_naive %>% forecast(new_data = test)
ggsave("Results/plots/snaive.png", 
       test %>% autoplot(Mortality, color = "grey") +
         autolayer(forecast_naive, level = NULL) +
         facet_wrap(~Sex + Age, scales = "free_y") +
         labs(title = "Seasonal Naive Method Forecasts by Group", x = "Week", y = "Mortality Rate") +
         theme_minimal(), width = 10, height = 6)

# Drift
fit_drift <- train %>% model(Drift = RW(Mortality ~ drift()))
forecast_drift <- fit_drift %>% forecast(new_data = test)
ggsave("Results/plots/drift.png", 
       test %>% autoplot(Mortality, color = "grey") +
         autolayer(forecast_drift, level = NULL) +
         facet_wrap(~Sex + Age, scales = "free_y") +
         labs(title = "Drift Method Forecasts by Group", x = "Week", y = "Mortality Rate") +
         theme_minimal(), width = 10, height = 6)

# TSLM
tslm_model <- train %>% model(TSLM_1 = TSLM(Mortality ~ trend() + season()))
forecast_tslm <- tslm_model %>% forecast(new_data = test)
ggsave("Results/plots/tslm.png", 
       test %>% autoplot(Mortality, color = "grey") +
         autolayer(forecast_tslm, level = NULL, aes(color = interaction(Sex, Age))) +
         facet_wrap(~Sex + Age, scales = "free_y") +
         labs(title = "TSLM Method Forecasts by Group", x = "Week", y = "Mortality Rate") +
         theme_minimal(), width = 10, height = 6)

# Auto ARIMA
auto_arima <- train %>% model(ARIMA = ARIMA(Mortality))
forecast_arima <- auto_arima %>% forecast(new_data = test)
ggsave("Results/plots/arima.png", 
       test %>% autoplot(Mortality, color = "grey") +
         autolayer(forecast_arima, level = NULL, aes(color = interaction(Sex, Age))) +
         facet_wrap(~Sex + Age, scales = "free_y") +
         labs(title = "ARIMA Model Forecasts by Group", x = "Week", y = "Mortality Rate") +
         theme_minimal(), width = 10, height = 6)

# Save accuracy metrics for each model
accuracy_results <- bind_rows(
  forecast_mean %>% accuracy(test) %>% mutate(Model = "Mean"),
  forecast_naive %>% accuracy(test) %>% mutate(Model = "Naive"),
  forecast_drift %>% accuracy(test) %>% mutate(Model = "Drift"),
  forecast_tslm %>% accuracy(test) %>% mutate(Model = "TSLM"),
  forecast_arima %>% accuracy(test) %>% mutate(Model = "ARIMA")
)
write.csv(accuracy_results, "Results/accuracy_summary.csv", row.names = FALSE)
