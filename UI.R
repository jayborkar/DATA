library(shiny)
# Define UI for application that plots graph & display data in table format
fluidPage( 
    headerPanel("Banting Air Pollutant Index From Aug 2013 - Feb 2015", windowTitle = "Banting API"),
    sidebarPanel(
        helpText("Create plot API Index vs Hour from month of August 2013 to Feb 2015."),
        selectInput("year",label="Select Year",selected=2014,choice=c(2013,2014,2015)),
        selectInput("month",label="Select Month", selected=1,choices=c(1,2,3,4,5,6,7,8,9,10,11,12))
    ),
    mainPanel(br(),
              h4(textOutput("text1"),style = "color:blue"),
              ##            h4(textOutput("text2"),style = "color:blue"),
              h5("The detail records and plot generated based on input values above, please refer Tab View Data and Plot respectively.",style = "color:blue"),
              br(),
              br(),
              tabsetPanel(
                  tabPanel(
                      h5("Introduction"),
                      h5("* This is a Shiny application to plot API(Air Pollutant Index) reading by Year and Month in Cousera Course Project."),
                      h5("* Note that the Air Pollutant Index file capture data by hours from 01-08-2013 to 05-02-2015."),
                      h5("* This application allows user to observe the hourly changes of the API reading in Banting Malaysia based on the selected Month and Year only."),
                      h5("* The original unprocessed data can be obtained from" , 
                         a("Government Data" ,href = "http://data.gov.my/view.php?view=280"),"."),
                      h5("* Open the left drop-down , Select the options Year and Month and then   
                         Observe on the right panel(under Tab Plot) on API index vs Hours."),
                      br(),
                      br(),
                      strong("* No Data munging tasks performed here, only focus on variables month , year and API reading only.To get the idea of the distribution of variables in the data used please refer Tab Data Summary and Tab View Data for the observations.")),
                  tabPanel(h5("Data Summary"),verbatimTextOutput("summary")),
                  tabPanel(h5("View Data"), dataTableOutput("table")),  
                  tabPanel(h5("Plot"),plotOutput("plot1")),  
                  tabPanel(h5("Conclusion"),  
                           h5("* This application demonstrated to build reactive output to display in Shiny app. Reactive output automatically responds when user toggles a widget."),
                           h5("* We use " ,strong("slideInput function"),"i.e A box with choices to select from, as a user interface to reactive the output."),
                           h5(textOutput("outcome"),style = "color:red"))
                  )
    )
)
