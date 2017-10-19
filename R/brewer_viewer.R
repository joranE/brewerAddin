library(shiny)
library(miniUI)
library(RColorBrewer)

brewerAddin <- function(){

  ui <- miniPage(
    gadgetTitleBar("Brewer Palette Viewer"),
    miniTabstripPanel(
      miniTabPanel(
        "Palette Selection",
        icon = icon("sliders"),
        miniContentPanel(
          numericInput(inputId = "pal_size",
                       label = "Number of colors",
                       value = 3,
                       min = 3,
                       max = 12,
                       step = 1),
          checkboxInput(inputId = "col_blind",
                        label = "Color blind friendly",
                        value = FALSE)
        )
      ),
      miniTabPanel(
        "Palette Display",
        icon = icon("area-chart"),
        miniContentPanel(
          plotOutput("palette",height = "600px"),
          padding = 5
        )
      )
    )
  )

  server <- function(input,output,session){
    output$palette <- renderPlot(
      RColorBrewer::display.brewer.all(n = input$pal_size,
                                       type = "all",
                                       colorblindFriendly = input$col_blind)
    )

    observeEvent(input$done, {
      stopApp()
    })
  }

  viewer <- paneViewer(minHeight = 600)
  runGadget(ui,server,viewer = viewer)
}
