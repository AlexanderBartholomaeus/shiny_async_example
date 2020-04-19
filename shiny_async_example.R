# shiny app example to show the effect on async / parallel execution
#  this will prevent users from waiting for long lasting calculation 
#  other users
# for more info visit:
# https://blog.rstudio.com/2018/06/26/shiny-1-1-0/
# 
############################################
###### Author: Alexander Bartholomäus ######
############################################

library(shiny)
library(promises)
library(future) # lib for parallel/async execution
plan(multisession) # add this for multisession

source('functions.R') # some functions for the busy indicator gif

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # busy indcator
  div(class = "busy", style=styleBusy(),
      #p("Calculation in progress.."),
      img(src="busy.gif")
  ),
  tags$head(tags$script(busyChecker())),
  
  # Application title
  titlePanel("Async / parallel execution example"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput('nLoops','Select number of dummy calculations',min = 10000, max = 1000000, step = 100000, value = 20000),
      actionButton('noParallel','Non-parallel execution'),
      tags$br(),tags$br(),
      actionButton('parallel','Parallel execution')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot1"),
      plotOutput("distPlot2")
    )
  )
)

# server logic
server <- function(input, output) {
  
  # non-parallel calculation / sleeping
  r1 <- eventReactive(input$noParallel,{
    # dummy calculation 
    for(i in 1:isolate(input$nLoops)){
      x <- rnorm(n = 100, mean = 5)
    }
    return(x)
  })
  # parallel (= async) calculation / sleeping
  r2 <- eventReactive(input$parallel,{
    # dummy calculation 
    future({
      for(i in 1:isolate(input$nLoops)){
        x <- rnorm(n = 100, mean = 5)
      }
      return(x)
    })
  })

  # simple plots
  output$distPlot1 <- renderPlot({
    # draw the histogram with the specified number of bins
    hist(r1(), col = 'darkgray', border = 'white')
  })
  # simple plot with promise
  output$distPlot2 <- renderPlot({
    # draw the histogram with the specified number of bins
    r2() %...>% hist(., col = 'darkgray', border = 'white')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

