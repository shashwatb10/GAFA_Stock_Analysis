library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("GAFA Stock Trends"),
    
    # Sidebar with controls to select a dataset and specify the number
    # of observations to view
    sidebarPanel(
        selectInput("dataset", "Choose a Stock:", 
                    choices = c("Google", "Apple","Facebook", "Amazon")),
        
        #sliderInput("num", "Number of observations to view:", min=1, max=500, value =100 ),
        paste("Enter Date Range: "),
        
        conditionalPanel(condition="input.dataset=='Google'",
                         textInput("date_1", "Enter Lower limit", "19/08/2004" ),
                         textInput("date_2", "Enter Upper Limit", "20/04/2018")),
        
        conditionalPanel(condition="input.dataset=='Apple'",
                         textInput("date_3", "Enter Lower limit", "12/12/1980" ),
                         textInput("date_4", "Enter Upper Limit", "20/04/2018")),
        
        conditionalPanel(condition="input.dataset=='Facebook'",
                         textInput("date_5", "Enter Lower limit", "18/05/2012" ),
                         textInput("date_6", "Enter Upper Limit", "20/04/2018")),
        
        conditionalPanel(condition="input.dataset=='Amazon'",
                         textInput("date_7", "Enter Lower limit", "15/05/1997" ),
                         textInput("date_8", "Enter Upper Limit", "20/04/2018"))
        
    ),
    
    # Show a summary of the dataset and an HTML table with the requested
    # number of observations
    mainPanel(
        
        textOutput("summary"),
        
        plotOutput("myplot"),
        
        tableOutput("view")
    )
))