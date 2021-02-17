#############################################################
## This is a Shiny web application to calculate
## the future value of an investment.
##
## You can run the app by clicking 'Run App' above.
##
##
## Author: Sam Spoerl (sam@samspoerl.com)
## Created: 2021-02-17
#############################################################

library(shiny)
library(FinCal) # For financial calculations
source("utils.R") # Helper functions

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Title ribbon across the top
    h1("Shiny TVM Calculator", 
       style = "font-family: sans-serif;
        font-weight: bold;
        color: #000; 
        text-align: left;
        background-color: #F8F8FF;
        padding: 20px"),
    
    br(),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            helpText("Calculate the future value of an 
                     investment by entering the following 
                     inputs."),
            numericInput("pv", h4("Present Value"), value = 100),
            numericInput("pmt", h4("Payment"), value = 0),
            sliderInput("rate", h4("Interest Rate"),
                        min = 0, max = 12, value = 8),
            sliderInput("nper", h4("Number of Periods"),
                        min = 0, max = 80, value = 20),
            br(),
            br(),
            br(),
            helpText("Author: Sam Spoerl"),
            helpText("sam@samspoerl.com")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           verbatimTextOutput("fv"),
           plotOutput("fv_schedule")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$fv <- renderText({
        futval <- fv(r=input$rate/100, # / 100
                     n=input$nper, 
                     pv=-input$pv, # negative
                     pmt=-input$pmt, # negative
                     type = 0)
        cur <- paste("In ", 
                     input$nper,
                     " periods you will have:\n$",
                    format(futval, 
                           digits = 0, 
                           scientific = FALSE,
                           big.mark = ",")
                )
    })
    
    output$fv_schedule <- renderPlot({
        vals <- fv_plot(input$rate/100, 
                        input$nper, 
                        -input$pv,
                        -input$pmt)
        plot(vals, type="b")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
