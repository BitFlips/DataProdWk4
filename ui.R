library(shiny)
shinyUI(fluidPage(
  titlePanel("Submarine Hunt"),
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("sliderX","Target X coordinate",min=1,max=10,step=1,value=5),
      sliderInput("sliderY","Target Y coordinate",min=1,max=10,step=1,value=5),
      submitButton("Fire!"),
      
      h4("Controls"),
      checkboxInput("showTrgt","Targets above/below water",value=TRUE),
      actionButton("newGame","New Game")
    ),
    
    mainPanel(
      h3("Radar Display"),
      plotOutput("plot"),
      tableOutput("stateTbl"),
      h5("Instructions"),
      h6(" 1. Aim:  Select x,y target point with sliders"),
      h6(" 2. Shoot:  Press 'Fire!' button"),
      h6(" 3. See Results:  Hit = Explosion, Miss = Splash"),
      h6(" Note 1: Check box takes effect on next 'Fire!'"),
      h6(" Note 2: New game takes effect on next 'Fire!'"),
      wellPanel( a("Link to ui.R in GitHub", 
                   href="https://github.com/BitFlips/DataProdWk4/blob/master/ui.R",
                   target="_blank")),
      wellPanel( a("Link to server.R in GitHub", 
                   href="https://github.com/BitFlips/DataProdWk4/blob/master/server.R",
                   target="_blank"))

    )
  )
))