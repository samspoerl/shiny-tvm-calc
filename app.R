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
        
        # Accept input in the side (left) panel
        sidebarPanel(
            
            # Show help text at the top of the side panel
            helpText("Calculate the future value of an 
                     investment by entering the following 
                     inputs."),
            
            # Present value input
            numericInput("pv", h4("Present Value"), value = 100),
            
            # Payment input
            numericInput("pmt", h4("Payment"), value = 0),
            
            # Interest rate input
            sliderInput("rate", h4("Interest Rate"),
                        min = 0, max = 12, value = 8),
            
            # Number of periods input
            sliderInput("nper", h4("Number of Periods"),
                        min = 0, max = 80, value = 20),
            
            # Show author info at bottom of side panel
            br(),
            br(),
            br(),
            helpText("Author: Sam Spoerl"),
            helpText("sam@samspoerl.com")
        ),

        # Display output in the main (right) panel
        mainPanel(
            
            # Show value of investment at the end of the time period
           verbatimTextOutput("fv"),
           
           # Show graph of investment over time
           plotOutput("fv_schedule")
        )
    )
)

# Define server logic to perform TVM calculations
server <- function(input, output) {

    # Output: value of investment at the end of the time period
    output$fv <- renderText({
        
        # Pass inputs to fv function
        futval <- fv(r=input$rate/100, # / 100
                     n=input$nper, 
                     pv=-input$pv, # negative
                     pmt=-input$pmt, # negative
                     type = 0)
        
        # Concatenate with string and convert to currency format
        cur <- paste("In ", 
                     input$nper,
                     " periods you will have:\n$",
                    format(futval, 
                           digits = 0, 
                           scientific = FALSE,
                           big.mark = ",")
                )
    })
    
    # Output: graph of investment over time
    output$fv_schedule <- renderPlot({
        
        # Pass inputs to helper function
        vals <- fv_plot(input$rate/100, 
                        input$nper, 
                        -input$pv,
                        -input$pmt)
        
        # Create line plot from dataframe
        plot(vals, type="b")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
