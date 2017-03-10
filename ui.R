library(shiny)
shinyUI(fluidPage(
  titlePanel("Submarine Hunt"),
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("sliderX","Target X coordinate",min=1,max=10,step=1,value=5),
      sliderInput("sliderY","Target Y coordinate",min=1,max=10,step=1,value=5),
      submitButton("Fire!"),
      
      h4("Controls"),
      checkboxInput("showTrgt","Show Targets (submarines)",value=TRUE)
      
    ),
    
    mainPanel(
      h3("Radar Display"),
      plotOutput("plot"),
      tableOutput("stateTbl"),
      h5("Instructions"),
      h6(" 1. Aim:  Select x,y target point with sliders"),
      h6(" 2. Shoot:  Press 'Fire!' button"),
      h6(" 3. See Results:  Hit = Explosion, Miss = Splash"),
      h6(" Note: Change show/hide targets check box before pressing  'Fire!'"),
      wellPanel( a("Link to ui.R in GitHub", 
                   href="https://bitflips.github.io/DataProdWk2",
                   target="_blank")),
      wellPanel( a("Link to server.R in GitHub", 
                   href="https://github.com/BitFlips/DataProdWk2/blob/gh-pages/index.Rmd",
                   target="_blank"))

    )
  )
))