
#' Calculate a best guess `nameGap` value for spacing the ECharts axis titles beyond the axis labels
#' @seealso e_y_axis_formatting
#' @param e \code{echart}
#' @inheritParams e_x_axis_formatting
#'
#' @return \code{num}
#' @export

axis_width <- function(e) {

  x <- e_series_data(e)
  chars <- max(nchar(x), na.rm = TRUE)

  chars * 8  + # 9 pixels per characters
    2 # For good measure
}

#' e_x_axis_year_formatting
#' @description generates a list that configures the min/max and correct axis formatting
#' for echarts figs
#' @param e_ctxt \code{(character)} The context in which the e_chart is being rendered
#' @inheritDotParams echarts4r::e_x_axis
#' @return A list of parameters for appropriate x-axis formatting for years on echarts figures
#'
#' @export

e_x_axis_formatting = function(e,
                               scale = TRUE,
                               type = e_opts_xAxis_type(e) %||% 'value',
                               min = purrr::when(e_year_on_x(e), isTRUE(.) ~ 1940, ~ NULL),
                               max = purrr::when(e_year_on_x(e), isTRUE(.) ~ 2060, ~ NULL),
                               name = purrr::when(e_year_on_x(e), isTRUE(.) ~ "Year", ~ NULL),
                               nameLocation = "middle",
                               nameTextStyle = list(padding = rep(0, 4), fontFamily = "rennerbook"),
                               nameGap = 30,
                               rotate = 45,
                               fontFamily = "rennerbook",
                               ...) {
  out =
    echarts4r::e_x_axis(
      e,
      scale = scale,
      type = type,
      axisLabel = list(formatter = htmlwidgets::JS(
        "function(value, index){
          return typeof value == 'number' ? parseFloat(value) : value;
       }"
      ),
      rotate = rotate,
      fontFamily = fontFamily),
      min = min,
      max = max,
      name = name,
      nameLocation = nameLocation,
      nameTextStyle = nameTextStyle,
      nameGap = nameGap,
      ...
    )

  return(out)
}

#' Calculate a best guess `nameGap` value for spacing the ECharts axis titles beyond the axis labels
#' @seealso e_y_axis_formatting
#' @param e \code{echart}
#' @inheritParams e_x_axis_formatting
#'
#' @return \code{num}
#' @export

axis_width <- function(e, e_ctxt) {

  x <- e_series_data(e)
  chars <- max(nchar(x), na.rm = TRUE)

  chars * 8  + # 9 pixels per characters
    2 # For good measure
}

#' e_y_axis_year_formatting
#' @description generates a list that configures the correct y axis formatting for echarts figs
#' @seealso echarts4r::e_y_axis
#' @inheritParams e_x_axis_formatting
#' @inheritDotParams echarts4r::e_y_axis
#' @param fontFamily \code{chr} CSS font-family
#' @param name \code{chr} Axis label
#' @param nameLocation \code{chr} Where to position the axis label. **Default 'middle'**
#' @param nameTextStyle \code{list} With named parameters. See \href{https://echarts.apache.org/en/option.html#yAxis.nameTextStyle}{Echarts yAxis.nameTextStyle}
#' @param nameGap \code{num/chr} **Default: 'auto'** uses custom heuristics to determine a best guess. See \link{axis_width}. Otherwise a numeric pixel value
#' @return A list of parameters for appropriate y-axis formatting for years on echarts figures
#'
#' @export


e_y_axis_formatting = function(e,
                               scale = TRUE,
                               type = 'value',
                               formatter = htmlwidgets::JS(paste0("function(value, index){\n", js_num2str(),"\nreturn num2str(value);  }"
                               )),
                               fontFamily = "rennerbook",
                               name = "Y-Axis",
                               nameLocation = "middle",
                               nameTextStyle = list(padding = c(0,0,0,0), fontFamily = "rennerbook"),
                               nameGap = 'auto',
                               ...) {
  if (nameGap == 'auto')
    nameGap = axis_width(e)


  out =
    echarts4r::e_y_axis(
      e,
      scale = scale,
      type = type,
      axisLabel = list(
        formatter = formatter,
        fontFamily = fontFamily
      ),
      name = name,
      nameLocation = nameLocation,
      nameTextStyle = nameTextStyle,
      nameGap = nameGap,
      ...
    )
  # Handle echarts `grid` options ----
  # Tue Jun 28 11:33:27 2022
  # NOTE echarts4r adds rather than replaces grid options causing modified value not to take effect (echarts uses the first relevant value as the option). This code modifies the grid options in place such that they take effect upon modification
  # Check where options are
  has_baseopts <- e_has_base_opts(out)
  # Retrieve the options for modification
  opts <- e_get_opts(out)
  # Add grid spacing so labels & titles show properly
  if (!is.null(opts$grid)) {
    opts$grid[[1]] <- purrr::list_modify(opts$grid[[1]], containLabel = TRUE)
  } else {
    opts$grid[[1]]$containLabel <- TRUE
  }


  # reassign options
  if (has_baseopts)
    out$x$opts$baseOption <- opts
  else
    out$x$opts <- opts

  return(out)
}
