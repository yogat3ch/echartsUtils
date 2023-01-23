library(shiny)

ui <- bs4Dash::dashboardPage(
  header = bs4Dash::dashboardHeader(disable = TRUE),
  body = bs4Dash::dashboardBody(
    tags$script(
      "$(function(){
        $('#card1').find('[data-card-widget=\"maximize\"]').on('click', function() {
           $('#plot').resize();
        });
      });"
    ),
    shiny::fluidRow(
      bs4Dash::bs4Card(id = "card1", plotly::plotlyOutput("plot"), width = 4, maximizable = TRUE),
      bs4Dash::bs4Card(echarts4r::echarts4rOutput("chart"), width = 4, maximizable = TRUE),
      bs4Dash::bs4Card(width = 4)
    )
  ),
  sidebar = bs4Dash::bs4DashSidebar(disable = TRUE)
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # generate bins based on input$bins from ui.R
  p <- iris |>
    dplyr::group_by(Species) |>
    echarts4r::e_charts(x = Petal.Width) |>
    echarts4r::e_line(Petal.Length, symbol = "none") |>
    echarts4r::e_y_axis(scale = TRUE) |>
    #echarts4r::e_band2(lower = Sepal.Length, upper = Sepal.Width, itemStyle = list(opacity = 0.4)) |>
    echarts4r::e_tooltip(trigger = "axis") |>
    echarts4r::e_datazoom() |>
    echarts4r::e_toolbox(orient = "vertical", itemSize = 10) |>
    e_saveAsImage_filename()
  # setting outputs
  output$chart <- echarts4r::renderEcharts4r(p)

  output$plot <- plotly::renderPlotly({
    plotly::plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)
  })

}

# Run the application
shinyApp(ui = ui, server = server)
