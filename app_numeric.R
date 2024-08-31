library(shiny)
library(shinythemes)  
library(data.table)
library(DT) 
library(caret)
library(rpart)
library(dplyr)
library(randomForest)

# Read in the RF model
model <- readRDS("model_final.rds")
f <- read.csv("liver_TRY.csv")

####################################
# User interface                   #
####################################

ui <- navbarPage(
  theme = shinytheme("cosmo"),
  
  "Liver Cirrhosis Predictor",
  
  tabPanel("Predictor",
           sidebarLayout(
             sidebarPanel(
               tags$label(h3('Input parameters')),
               selectInput("drug", h3("Drug"),
                           choices = list("D-penicillamine" = 1, "Placebo" = 0), selected = 1),
               selectInput("hepatomegal1", h3("Hepatomegal1"),
                           choices = list("Yes" = 1, "No" = 0), selected = 1),
               selectInput("edema", h3("Edema"),
                           choices = list("N" = 0, "S" = 1, "Y" = 2), selected = 1),
               numericInput("Bilirubin", 
                            label = "Bilirubin", 
                            value = 0.3,
                            min=0,
                            max = 2,
                            ),
               numericInput("Cholesterol", 
                            label = "Cholesterol", 
                            value = 301,
                            min = 100,
                            max = 450),
               numericInput("Albumin", 
                            label = "Albumin", 
                            value = 3.11,
                            min = 2,
                            max = 6),
               numericInput("Copper", 
                            label = "Copper", 
                            value = 49,
                            min = 0,
                            max = 500),
               numericInput("Alk_Phos", 
                            label = "Alk_Phos", 
                            value = 1338,
                            min=0),
               numericInput("SGOT", 
                            label = "SGOT", 
                            value = 87.9,
                            min = 0,
                            max = 200),
               numericInput("Tryglicerides", 
                            label = "Tryglicerides", 
                            value = 126,
                            min = 0,
                            max = 350),
               numericInput("Platelets", 
                            label = "Platelets", 
                            value = 276,
                            min = 0,
                            max = 600),
               numericInput("Prothrombin", 
                            label = "Prothrombin", 
                            value = 10.5,
                            min = 5,
                            max = 17),
               
               actionButton("submitbutton", "Submit", 
                            class = "btn btn-primary")
             ),
             
             mainPanel(
               tags$label(h3('Status/Output')),
               textOutput('Statement')
             )
           )
  ),
  
  tabPanel("Results",
           fluidRow(
             column(12,
                    tableOutput('tabledata')
             )
           )
  ),
  
  tabPanel("Explore Data",
           fluidRow(
             column(12,
                    dataTableOutput("data_table")
             )
           )
  )
)

####################################
# Server                           #
####################################
server <- function(input, output, session) {
  
  observe({
    print("Inside observe")
    print(input$submitbutton)
    print(input$drug)
    print(input$hepatomegal1)
    print(input$edema)
    print(input$Bilirubin)
    print(input$Cholesterol)
    print(input$Albumin)
    print(input$Copper)
    print(input$Alk_Phos)
    print(input$SGOT)
    print(input$Tryglicerides)
    print(input$Platelets)
    print(input$Prothrombin)
  })
  
  prediction_result <- reactive({
    print("Inside prediction_result")
    df <- data.frame(
      Drug = as.factor(input$drug),
      Hepatomegal1 = as.factor(input$hepatomegal1),
      Edema = as.factor(input$edema),
      Bilirubin = input$Bilirubin,
      Cholesterol = input$Cholesterol,
      Albumin = input$Albumin,
      Copper = input$Copper,
      Alk_Phos = input$Alk_Phos,
      SGOT = input$SGOT,
      Tryglicerides = input$Tryglicerides,
      Platelets = input$Platelets,
      Prothrombin = input$Prothrombin
    )
    
    
    prediction <- predict(model, df)
    
    prediction_result <- data.frame(Prediction = prediction, round(predict(model, df, type = "prob"), 3))
    
    print(prediction_result)
    
    prediction_result
  })
  
  output$tabledata <- renderTable({
    print("Inside renderTable")
    if (input$submitbutton > 0) {
      prediction_result()
    }
  })
  
  # Reactive to update the Statement output
  output$Statement <- renderText({
    if (input$submitbutton > 0) {
      df <- data.frame(
        Drug = as.factor(input$drug),
        Hepatomegal1 = as.factor(input$hepatomegal1),
        Edema = as.factor(input$edema),
        Bilirubin = input$Bilirubin,
        Cholesterol = input$Cholesterol,
        Albumin = input$Albumin,
        Copper = input$Copper,
        Alk_Phos = input$Alk_Phos,
        SGOT = input$SGOT,
        Tryglicerides = input$Tryglicerides,
        Platelets = input$Platelets,
        Prothrombin = input$Prothrombin
      )
      prediction <- predict(model, df)
      if (prediction == 1) {
        return("You are having Liver Cirrhosis")
      } else {
        return("You are not having Liver Cirrhosis")
      }
    }
  })
  
  output$data_table <- renderDataTable({
    datatable(f, options = list(
      dom = 't', 
      paging = FALSE,
      ordering = TRUE,
      columnDefs = list(
        list(targets = "_all", className = "dt-center")
      )
    ), rownames = FALSE, class = 'cell-border stripe')
  })
}

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
