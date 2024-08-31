# Cirrhologix: Liver Cirrhosis Predictor Project

## Overview

**Cirrhologix** is a liver cirrhosis prediction tool developed in R and deployed using Shiny. This application aims to assist healthcare professionals in predicting the likelihood of liver cirrhosis in patients by leveraging data-driven models and statistical analysis. Cirrhosis is a severe liver disease characterized by irreversible scarring of the liver, often resulting from long-term liver damage due to conditions such as hepatitis, alcohol abuse, or fatty liver disease. Early detection is crucial for better management and treatment of the condition.

## Features

- **User-Friendly Interface**: The Cirrhologix app provides a simple and intuitive interface, enabling users to input patient data and receive predictions seamlessly.
- **Predictive Model**: The application utilizes a robust machine learning model trained on relevant clinical data to predict the likelihood of liver cirrhosis.
- **Interactive Visualizations**: Visual representation of input data and results, including charts and plots, to aid in decision-making.
- **Real-Time Predictions**: Obtain predictions in real-time, allowing for immediate assessment and further medical planning.
  
## Getting Started

### Prerequisites

To run Cirrhologix locally, you will need to install the following:

- **R (version 4.0 or higher)**: You can download the latest version of R from [CRAN](https://cran.r-project.org/).
- **RStudio (optional)**: A user-friendly interface for R, available [here](https://rstudio.com/).
- **Shiny package**: For deploying the web application, install it by running the following command in your R console:

```r
install.packages("shiny")
```

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/OmkarLolage21/Cirrhologix.git
   cd Cirrhologix
   ```

2. **Install the required R packages**:
   Open the `Cirrhologix.Rproj` file in RStudio and run the following command to install the necessary dependencies:
   ```r
   install.packages(c("shiny", "caret", "ggplot2", "dplyr", "randomForest"))
   ```

3. **Run the application**:
   To run the app locally, open `app.R` in RStudio and click the "Run App" button, or simply execute the following command in the R console:
   ```r
   shiny::runApp("app.R")
   ```

4. **Access the Deployed Application**:
   The Cirrhologix application is also deployed on shinyapps.io. You can access it at the following link:

   [Cirrhologix on ShinyApps.io](https://your-shinyapps-url)

## Dataset
The predictive model used in Cirrhologix is trained on a liver cirrhosis dataset sourced from Kaggle. This dataset includes a variety of clinical features that are relevant for cirrhosis prediction.

## Methodology

Cirrhologix employs a machine learning model built using the **Random Forest** algorithm, which is well-suited for handling complex and non-linear relationships in clinical data. The model was trained on a publicly available liver cirrhosis dataset, ensuring both accuracy and generalization in predictions. The application processes the input features and returns the probability of cirrhosis, which is then categorized into risk groups (e.g., Low, Medium, High).

## Model Performance

The performance of the predictive model has been evaluated using standard metrics such as accuracy, precision, recall, and AUC-ROC curve. The model was cross-validated to avoid overfitting and ensure robust predictions. Accuracy achieved was approximately 93%.

## Future Work

Further improvements are planned for the Cirrhologix project, including:
- Integration of additional datasets for model refinement.
- Expansion of the feature set to include more clinical parameters.
- Enhancement of the user interface with more advanced visualization options.
- Incorporation of feedback from healthcare professionals to optimize usability.

## Contributing

Contributions to Cirrhologix are welcome! Please fork the repository and submit pull requests. Before contributing, kindly read our [Contributing Guidelines](CONTRIBUTING.md).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for details.

Thank you for using **Cirrhologix**! Your feedback is invaluable in making this project better for the community.
