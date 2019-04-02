library(ggplot2)
library(caret)
library(shiny)

# load the model
load(file = "./data/logRegModel.Rdata");

ui <- fluidPage(
  sidebarPanel(
    sliderInput("model_year", "Year manufactured", 1970, 1990, 1972, sep = ""),
    
    selectInput("origin", "manufacture origin",
                choices = c(1, 2, 3)),
    
    numericInput("weight", "weight (lbs)", 2000),
    
    numericInput("hp", "horse power", 100)
    
    
  ),
  textOutput("mpg")
)

server <- function(input, output, session) {
  output$mpg <- renderText({
    origin = as.numeric(input$origin)
    year = input$model_year - 1900
    newdata <- data.frame(model_year = year, origin = origin, weight = input$weight, horsepower = input$hp)
    val <- predict(cars.fit10, newdata)
    mpg <- round(val[1])[1]
    left <- 50 - mpg
    paste0("predicted miles per gallon is ", mpg )
  })
}

shinyApp(ui, server)