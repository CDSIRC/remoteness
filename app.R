library(shiny)
library(leaflet)

m <- readRDS("m.rds")
pal <- readRDS("pal.rds")
regions_rates <- readRDS("regions_rates.rds")

ui <- fluidPage(
  
  h2("Death rate for children in South Australia by region"),
  
  h4("Explore the map by zooming and draging it"),
   
   leafletOutput("mymap"), 
   
   downloadLink("downloadData", "Get the data"), 
   helpText(a("Get the code", href = "https://github.com/CDSIRC/", target = "_blank"))
   
)

server <- function(input, output) {
   
  output$mymap <- renderLeaflet({
    m
  })
  
  output$downloadData <- downloadHandler(
    filename = "regions_data.csv",
    content = function(file) {
      write.csv(regions_rates, file, row.names = FALSE)
    }, 
    contentType = "text/csv"
  )
  
}

shinyApp(ui = ui, server = server)

