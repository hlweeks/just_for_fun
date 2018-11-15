library(shiny)
source('pokemon.R')

shinyServer(function(input, output) {
  
  # output$pokePlot <- renderPlot({
  #   data <- get(paste0("gen", input$gen))
  #   
  #   if(input$xvar == input$yvar){
  #     ggplot(data, aes(1:nrow(data), get(input$yvar))) + 
  #       geom_pokemon_local(aes(image = data$name_id)) + 
  #       xlab("") + ylab(input$yvar) + 
  #       theme(axis.ticks.x = element_blank(), axis.text.x = element_blank())
  #   }else{
  #   ggplot(data, aes(get(input$xvar), get(input$yvar))) + 
  #     geom_pokemon_local(aes(image = name_id$name)) + 
  #       xlab(input$xvar) + ylab(input$yvar)
  #   }
  #   
  # }, width = 700, height = 700)
  
  output$pokePlot <- renderPlot({
    data <- get(paste0("gen", input$gen))
    
    if(input$xvar == input$yvar){
      ggplot(data, aes(1:nrow(data), get(input$yvar))) +
        geom_pokemon_local(aes(image = data$name_id)) + 
        xlab("") + ylab(input$yvar) + 
        theme(axis.ticks.x = element_blank(), axis.text.x = element_blank())
    }else{
      ggplot(data, aes(get(input$xvar), get(input$yvar))) +
        geom_pokemon_local(aes(image = data$name_id)) +
        xlab(input$xvar) + ylab(input$yvar)
    }
    
  }, width = 700, height = 700)
  
  # output$info <- renderText({
  #   distance <- sqrt((data[,input$xvar] - input$click$x)^2 + 
  #                                  (data[,input$yvar] - input$click$y)^2)
  #   distance <- distance[order(name_id$id)]
  #   
  #   closest <- which.min(distance)
  #   
  #   paste0(data$name[closest],
  #       "\n", input$xvar, ": ", data[closest,input$xvar],
  #       "\n", input$yvar, ": ", data[closest,input$yvar])
  # })
  
})
