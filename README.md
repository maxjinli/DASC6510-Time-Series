# Australian Mortality Forecasting Using Time Series Models

This project applies advanced time series modeling techniques to analyze and forecast Australian mortality rates. The dataset includes weekly mortality rates segmented by age and sex, providing insights into long-term trends and seasonal patterns. By employing a combination of baseline models and advanced statistical approaches, the project aims to evaluate model performance and provide actionable insights for resource planning and public health strategy.

## Project Overview

Forecasting mortality rates is crucial for understanding demographic trends and addressing resource allocation challenges. This project leverages time series models such as Mean, Seasonal Naïve, Drift, Time Series Linear Models (TSLM), and Seasonal ARIMA (SARIMA). Cross-validation was employed to ensure robust model performance evaluation, using metrics such as Mean Absolute Error (MAE) and Root Mean Squared Error (RMSE).

### Key Objectives:
- Explore seasonal and demographic variations in Australian mortality rates.
- Evaluate baseline models (Mean, Seasonal Naïve, Drift) against advanced models (TSLM and SARIMA).
- Use cross-validation to assess model performance and reliability.
- Provide actionable insights for policymakers and healthcare providers.

## Repository Structure

    /mortality_forecasting_project
    │
    ├── Data/
    │   └── aus_mortality.csv             # Processed dataset    
    │
    ├── Scripts/
    │   ├── data_preprocessing.R          # Data preprocessing script
    │   ├── model_fitting.R               # Scripts for fitting all models
    │   └── cross_validation.R            # Cross-validation implementation
    │  
    ├── Results/
    │   ├── plots/
    │   │   ├── data.png                  # Time series visualization
    │   │   ├── mean.png                  # Mean method forecast
    │   │   ├── snaive.png                # Seasonal naive method forecast
    │   │   ├── drift.png                 # Drift method forecast
    │   │   ├── arima.png                 # ARIMA method forecast
    │   │   ├── tslm.png                  # TSLM method forecast
    │   │   └── accuracy.png              # Accuracy comparison by models
    │   ├── cv_summary.csv                # Cross-validation performance metrics
    │   └── accuracy_summary.csv          # Model performance metrics
    │
    ├── Reports/
    │   └── Final_Report.pdf              # Final report document
    │
    ├── Notebooks/
    │   └── Mortality_Analysis.Rmd        # R Markdown notebook
    │
    └── README.md 

## Usage

1. **Data Preparation:**  
   Place the dataset (`aus_mortality.csv`) in the `Data/` folder. Run `data_preprocessing.R` to preprocess the data.

2. **Model Fitting:**  
   Use `model_fitting.R` to fit Mean, Naïve, Drift, TSLM, and SARIMA models.

3. **Cross-Validation:**  
   Run `cross_validation.R` to validate models using the rolling-origin method.

4. **Visualization and Results:**  
   The scripts generate visualizations (stored in `Results/plots/`) and performance metrics (stored in `Results/`).

## Dependencies

- R version 4.0.0 or later
- Required libraries: `fpp3`, `ggplot2`, `dplyr`, `forecast`, `fable`, `tidyverse`

## Contributions

This project was developed as part of a comprehensive time series analysis study. Contributions and suggestions for further improvement are welcome.

