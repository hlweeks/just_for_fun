#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source('pokemon.R')

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Pokemon Plots"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("xvar", "X Variable:", choices = stats),
       selectInput("yvar", "Y Variable:", choices = stats),
       textOutput("info")
       
       # Add menu items with links to github repos for geom_pokemon code and emoji .png files
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("pokePlot", click = "click")
    )
  )
))
