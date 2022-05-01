#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(bslib)
load("ModeloAbuelos.Rdata")
load("ModeloNinos.Rdata")


# Define UI for application that draws a histogram
ui <- navbarPage(theme = bs_theme(version = 4, bootswatch = "minty"),"Modelos de Satisfacción",
                 navbarMenu("Modelos",
                            tabPanel("Modelo Ninos",
                                     sidebarLayout(
                                       sidebarPanel(
                                         sliderInput("Satis_tecnologia",
                                                     "Satisfaccion con la tecnologia:",
                                                     min = 0,
                                                     max = 100,
                                                     value = 50),
                                         sliderInput("Satis_educacion",
                                                     "Satisfaccion con su eduacion:",
                                                     min = 0,
                                                     max = 100,
                                                     value = 50),
                                         sliderInput("Satis_vivenda",
                                                     "Satisfaccion con su vivienda:",
                                                     min = 0,
                                                     max = 100,
                                                     value = 50)
                                       ),
                                       
                                       
                                       # Show a plot of the generated distribution
                                       mainPanel(
                                         p("Prediccion ninos"),
                                         textOutput("prediccion_ninos")
                                         # plotOutput("distPlot")
                                       )
                                     )
                            ),
                            tabPanel("Modelo Abuelos",
                                     sidebarLayout(
                                       sidebarPanel(
                                         sliderInput("Satis_salud",
                                                     "Satisfaccion con la salud:",
                                                     min = 0,
                                                     max = 100,
                                                     value = 50),
                                         sliderInput("Satis_vivienda",
                                                     "Satisfaccion con su vivienda:",
                                                     min = 0,
                                                     max = 100,
                                                     value = 50),
                                         
                                       ),
                                       
                                       
                                       
                                       mainPanel(
                                         p("Prediccion Abuelos"),
                                         textOutput("prediccion_abuelos")
                                         # plotOutput("distPlot")
                                       )
                                     )
                            )
                 ),
                 tabPanel("Información del equipo",
                          p("Kevin Arias"),
                          p("Santiago Carvajal"),
                          p("Sebastian Lopez"),
                          p("Juan Pino"),
                          p("Cristian Rojas")
                          
                          ),
                  tabPanel("Explicacion modelo",
                           fluidPage(
                             column(10,
                                    includeHTML("Modelo.html")
                                    )
                             
                           )
                    
                  )
                 
                 
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$prediccion_abuelos <- renderText({
    entrada1 <- data.frame(Satisfaccion_salud=input$Satis_salud,
                           Satisfaccion_vivienda=input$Satis_vivenda)
    
    salida1 <- predict(modelo_abuelos,newdata = entrada1)
    return(salida1)
    
  })
  
  output$prediccion_ninos <- renderText({
    entrada2 <- data.frame(Satisfaccion_tecnologia=input$Satis_tecnologia,
                           Satisfaccion_educacion=input$Satis_educacion,
                           Satisfaccion_vivienda=input$Satis_vivienda)
    
    salida2 <- predict(modelo_ninos,newdata = entrada2)
    return(salida2)
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
