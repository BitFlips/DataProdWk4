library(png)
library(ggplot2)


img1 <- readPNG("bship.png")
img2 <- readPNG("boom.png")
img3 <- readPNG("splash.png")

shinyServer(function(input,output,session){
  
    #-- Set up shared access variables
    vars <- reactiveValues(s = NULL)
    
    
    vars$s <- data.frame(x=sample(1:10,size=3,replace=FALSE),
                         y=sample(1:10,size=3,replace=FALSE),
                         hit = FALSE) 
    
    #-- Start New Game Processing
    observeEvent(input$newGame, {
      
      vars$s <- data.frame(x=sample(1:10,size=3,replace=FALSE),
                           y=sample(1:10,size=3,replace=FALSE),
                           hit = FALSE) 
      
    })
    
    #-- Plot Rendering Function
    output$plot <- renderPlot(width=460,height=400,{
      
      #-- access the target array
      s <- vars$s
      
      #-- set up ranges for annotation_raster() 
      x1 <- s[,]$x-0.7
      x2 <- s[,]$x+0.7
      y1 <- s[,]$y-0.7
      y2 <- s[,]$y+0.7
      
      #-- Base qplot (dummy points made invisible)  
      g <- qplot( 1:10,1:10,geom="blank") + 
          scale_x_continuous(name="Radar X-Coordinate",limits=c(1,10),breaks=seq(1,10,1))+
          scale_y_continuous(name="Radar Y-Coordinate",limits=c(1,10),breaks=seq(1,10,1))+
        
          theme(panel.background = element_rect(fill="lightblue",colour = "navy"))+
          geom_point(alpha=0.01)
    
     
      #-- Target visibility processing
      if (input$showTrgt) { 
        for (i in 1:3) {
          g <- g + annotation_raster(img1, xmin=x1[i], xmax=x2[i], ymin=y1[i], ymax=y2[i])
        }
      }
     
      #-- Set up annotation_raster() slider location for hits/misses
      x1t <- input$sliderX-0.7
      x2t <- input$sliderX+0.7
      y1t <- input$sliderY-0.7
      y2t <- input$sliderY+0.7  
    
      #-- Hit Processing Code
      hitfound <- FALSE
      for (i in 1:3) {
        if ((input$sliderX == s[i,]$x) & (input$sliderY == s[i,]$y)) {
          hitfound <- TRUE
          if (input$showTrgt) {
            g <- g + annotation_raster(img1, xmin=x1t, xmax=x2t, ymin=y1t, ymax=y2t)
            g <- g + annotation_raster(img3, xmin=x1t, xmax=x2t, ymin=y1t, ymax=y2t)
            g <- g + annotation_raster(img2, xmin=x1t, xmax=x2t, ymin=y1t, ymax=y2t)
          }  
          else {
            g <- g + annotation_raster(img1, xmin=x1t, xmax=x2t, ymin=y1t, ymax=y2t)
            g <- g + annotation_raster(img2, xmin=x1t, xmax=x2t, ymin=y1t, ymax=y2t)
          }
        } 
      } 
      
      #-- Miss processing code
      if (!hitfound) {
        g <- g + annotation_raster(img3, xmin=x1t, xmax=x2t, ymin=y1t, ymax=y2t)
      }
      
      
      ##-- Final plot object
      g 
      
  })
  
})