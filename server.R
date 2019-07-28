library(shiny)
library(dplyr)
library(ggplot2)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
    
    # Return the requested dataset
    datasetInput <- reactive({
        switch(input$dataset,
               "Apple" = stats_Apple,
               "Google" = stats_google,
               "Facebook" = stats_Facebook,
               "Amazon"=stats_Amazon)
    })
    
    min_date <- reactive({
        switch(input$dataset,
               "Apple" = as.POSIXct(input$date_3, format="%d/%m/%Y"),
               "Google" = as.POSIXct(input$date_1, format="%d/%m/%Y"),
               "Facebook" =  as.POSIXct(input$date_5, format="%d/%m/%Y"),
               "Amazon"=as.POSIXct(input$date_7, format="%d/%m/%Y"))
        
    })
    
    max_date <- reactive({
        switch(input$dataset,
               "Apple" = as.POSIXct(input$date_4, format="%d/%m/%Y"),
               "Google" = as.POSIXct(input$date_2, format="%d/%m/%Y"),
               "Facebook" =  as.POSIXct(input$date_6, format="%d/%m/%Y"),
               "Amazon"=as.POSIXct(input$date_8, format="%d/%m/%Y"))
        
    })
    
    formulaText <- reactive({
        paste(input$dataset)
    })
    
    #Generate a summary of the dataset
    output$summary <- renderText({
        formulaText()
    })
    
    #Generating the required plot
    output$myplot<-renderPlot({
        val<-datasetInput()
        mindate<-min_date()
        maxdate<-max_date()
        val<-val[val$PosixDate>=mindate & val$PosixDate<=maxdate, ]
        mean_val<-mean(as.numeric(as.character(val[,3])))
        ggplot(data=val, aes(x=PosixDate, y=Open))+geom_point(size=1,aes(colour=Stock))+
            ggtitle("Stock Trends ")+xlab("Date")+ylab("Stock Price")+theme(axis.title.x=element_text(size=20, colour="Black"), 
                                                                            axis.title.y=element_text(size=20, colour="Black"), 
                                                                            axis.text.y=element_blank(),
                                                                            plot.title = element_text(size=30, colour="Dark Green"))
    })
    
    
    # Show the observations
    output$view <- renderTable({
        
        data<-datasetInput()
        mindate<-min_date()
        maxdate<-max_date()
        data[data$PosixDate>=mindate & data$PosixDate<=maxdate, ]
    })
})