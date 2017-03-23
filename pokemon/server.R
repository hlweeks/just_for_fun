#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source('pokemon.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$pokePlot <- renderPlot({
    if(input$xvar == input$yvar){
      ggplot(pokemon, aes(1:nrow(pokemon), get(input$yvar))) + 
        geom_pokemon_local(aes(image = paste0('emojis/', name_id$name, '.png'))) + 
        xlab("") + ylab(input$yvar) + 
        theme(axis.ticks.x = element_blank(), axis.text.x = element_blank())
    }else{
    ggplot(pokemon, aes(get(input$xvar), get(input$yvar))) + 
      geom_pokemon_local(aes(image = paste0('emojis/', name_id$name, '.png'))) + 
        xlab(input$xvar) + ylab(input$yvar)
    }
    
  }, width = 700, height = 700)
  
  output$info <- renderText({
    distance <- sqrt((pokemon[,input$xvar] - input$click$x)^2 + 
                                   (pokemon[,input$yvar] - input$click$y)^2)
    distance <- distance[order(name_id$id)]
    
    closest <- which.min(distance)
    
    paste0(pokemon$Name[closest],
        "\n", input$xvar, ": ", pokemon[closest,input$xvar],
        "\n", input$yvar, ": ", pokemon[closest,input$yvar])
  })
  
})
