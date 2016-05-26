library(shiny)
library(lubridate)
library(ggplot2)
library(doBy)

banting <-read.csv("API_Banting.csv")

function(input,output){
    
    output$plot1 <- renderPlot({
        selected.data <- banting[(month(banting$Date)==input$month & year(banting$Date)== input$year),] 
        ggplot(data=selected.data, aes(x=selected.data$Hour,y=selected.data$API))+geom_smooth(color="blue")+labs(x="Hour",y="API Index")
    })
    
    output$table <- renderDataTable (banting[(month(banting$Date)==input$month & year(banting$Date)==input$year),])
    
    output$summary <- renderPrint({
        summary(banting)
    })
    
    output$text1 <- renderText({
        input_month <- as.numeric(input$month)
        mon_x <- as.character(month(ymd(010101) + months(input_month -1),label=TRUE,abbr=TRUE))
        ##    paste("* Month Selected : ", mon_x,".")
        paste("* Month And Year Selected : ", mon_x,"-",input$year,".")
    })
    
    output$outcome <- renderText({
        d1 <- banting[(month(banting$Date)== input$month & year(banting$Date)== input$year),]
        d1 <- d1[,4:5]
        cdata1 <- summaryBy(API ~ Hour, data=d1, FUN=c(length,mean,sd,max,min))
        sorted_data <- cdata1[order(cdata1$API.mean,decreasing=TRUE),c(1,3)]
        max_hours <- round(sorted_data[1,1],2)
        max_mean <-  round(sorted_data[1,2],2) 
        paste("* From the plot, we can observe that Average API reading peak at hours ",max_hours,
              ":00 With Average of API reading is ", max_mean, ".")
    })
    ##  
    ##  output$text2 <- renderText({
    ##    input_month <- as.numeric(input$month)
    ##    mon_x <- as.character(month(ymd(010101) + months(input_month -1),label=TRUE,abbr=TRUE))
    ##    paste("* Month Selected : ", mon_x,".")
    ##  })
}
