#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv')

library(shiny)
library(dplyr)

# Define UI for application 
ui <- fluidPage(

    # Application title
    titlePanel("Cocktailpedia"),

    # Sidebar with a select input for  ingredient type
        sidebarPanel(
          helpText('Chooese the ingredient you want'),
          selectInput('ingredient',
                      'Search by ingredient',
                      choices = unique(data$ingredient),
                      selected = 'Gin'),
          
        ),

        # Show a plot of the generated distribution
    dataTableOutput('name'),
    ###sidebar witha a select input for cocktail name
    sidebarPanel(
      helpText('Chooese the cocktail you want'),
      selectInput('cocktail',
                  'Search by cocktail name',
                  choices = unique(data$name),
                  selected = 'Bloody Mary'),
      
    ),
    
    # Show a plot of the generated distribution
    dataTableOutput('recipe')
    
        
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    #filter the the alcoholic name based on the ingredient
  cocktail_select<-reactive({
    data%>%
      filter(ingredient==input$ingredient)%>%
      select(name, ingredient)
  })
  ###print the output
  output$name <- renderDataTable({
  cocktail_select()
    
  })
  drink_recipe<-reactive({
    data%>%
      filter(name==input$cocktail)%>%
      select(name, ingredient, measure)
  })
  ###print the output
  output$recipe <- renderDataTable({
    drink_recipe()
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
