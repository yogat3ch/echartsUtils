
#' Makes an appropriately styled data list for stacked area charts for
#' a single serie
#' @return appropriately formatted list to add as an entry to the series list
#' in the base list
#' @family line
#' @family options
#' @param data \code{num} series data
#' @param name \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.name)
#' @param type \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.type)
#' @param stack \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.stack)
#' @param smooth \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.smooth)
#' @param lineStyle \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.lineStyle)
#' @param showSymbol \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.showSymbol)
#' @param areaStyle \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.areaStyle)
#' @param emphasis \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.emphasis)
#' @param color \code{chr} See [echarts setOption docs](https://echarts.apache.org/en/option.html#series-line.color)
#' @param ... additional parameters passed to [series](https://echarts.apache.org/en/option.html#series-line)
#' @export
#'

e_opts_make_stacked_area_series = function(data,
                                           name = NULL,
                                           type = "line",
                                           stack = 'Total',
                                           smooth = TRUE,
                                           lineStyle = list(width = 0),
                                           showSymbol = FALSE,
                                           areaStyle = list(opacity = 0.8),
                                           emphasis = list(focus = 'series'),
                                           color = NULL,
                                           ...
) {
  list(
    data = data,
    name = name,
    type = type,
    stack = stack,
    smooth = smooth,
    lineStyle = lineStyle,
    showSymbol = showSymbol,
    areaStyle = areaStyle,
    emphasis = emphasis,
    color = color,
    ...
  )
}


#' A list of default options for an echart line
#'
#' @param .data \code{tbl} of Reservoir Data
#' @param grid See [echarts setOption docs](https://echarts.apache.org/en/option.html#grid)
#' @param color See [echarts setOption docs](https://echarts.apache.org/en/option.html#color)
#' @param tooltip See [echarts setOption docs](https://echarts.apache.org/en/option.html#tooltip)
#' @param legend See [echarts setOption docs](https://echarts.apache.org/en/option.html#legend)
#' @param xAxis See [echarts setOption docs](https://echarts.apache.org/en/option.html#xAxis)
#' @param yAxis See [echarts setOption docs](https://echarts.apache.org/en/option.html#yAxis)
#' @param ... \code{args} Additional parameters
#' @family line
#' @family options
#' @return \code{list}
#' @export

e_opts_line_default <- function(.data,
                                grid = list(left = '20%'),
                                color = NULL,
                                tooltip = list(trigger = 'axis',
                                               axisPointer = list(
                                                 type = 'cross'
                                               )),
                                legend = list(
                                  textStyle = list(fontSize = 10),
                                  type = 'scroll',
                                  bottom = '0%',
                                  opacity = 1,
                                  padding = list(0, 0, 0, 0),
                                  itemGap = 2
                                ),
                                xAxis = list(type = 'category'),
                                yAxis = list(type = 'value'),
                                ...) {


  list(
    grid = grid,
    color = color,
    tooltip = tooltip,
    legend = legend,
    xAxis = xAxis,
    yAxis = yAxis,
    ...
  )
}
