
#' Get y-axis options
#'
#' @param e \code{htmlwidget/list} An echarts objects or an options list
#'
#' @return \code{list} of options
#' @export
#'
#' @examples
#' lapply(list(echarty::ec.init(mtcars), echarts4r::e_chart(mtcars)), e_opts_yAxis)
e_opts_yAxis <- function(e) {
  UseMethod("e_opts_yAxis")
}

#' @export
e_opts_yAxis.echarty <- function(e) {
  e_opts_unnest(e_get_opts(e)$yAxis)
}
#' @export
e_opts_yAxis.echarts4r <- e_opts_yAxis.echarty
#' @export
e_opts_yAxis.list <- function(e) {
  e_opts_unnest(e$yAxis)
}

#' Get x-axis options
#'
#' @param e \code{htmlwidget/list} An echarts objects or an options list
#'
#' @return \code{list} of options
#' @export
#'
#' @examples
#' lapply(list(echarty::ec.init(mtcars), echarts4r::e_chart(mtcars)), e_opts_xAxis)
e_opts_xAxis <- function(e) {
  UseMethod("e_opts_xAxis")
}
e_opts_unnest <- function(opts) {
  if (length(opts) == 1 && is.null(names(opts)))
    opts <- opts[[1]]
  return(opts)
}
#' @export
e_opts_xAxis.echarty <- function(e) {
  e_opts_unnest(e_get_opts(e)$xAxis)
}
#' @export
e_opts_xAxis.echarts4r <- e_opts_xAxis.echarty
#' @export
e_opts_xAxis.list <- function(e) {
  e_opts_unnest(e$xAxis)
}

e_yAxis_opts_lists <- c(
  list(nameTextStyle = c("rich")),
  list(axisLine = "lineStyle"),
  list(axisTick = "lineStyle"),
  list(minorTick = "lineStyle"),
  list(axisLabel = c("rich")),
  list(splitLine = "lineStyle"),
  list(minorSplitLine = "lineStyle"),
  list(splitArea = "areaStyle"),
  list(data = list(textStyle = "rich")),
  list(axisPointer = list(label = c("lineStyle", "shadowStyle", "handle")))
)

#' Is the X axis in years?
#'
#' @param e \code{echart}
#'
#' @return \code{lgl}
#' @export
#'

e_year_on_x <- function(e) {
  .data <- e_series_data(e)
  out <- try(
    all(dplyr::between(do.call(c, purrr::map(.data, "x")), 600, 2200))
  )
  return(out)
}


#' Get the series option from an echarts object
#'
#' @param e \code{echart}
#' @inheritParams purrr::pluck
#' @return \code{list}
#' @export

e_series <- function(e, ...) {
  if (e_has_base_opts(e)) {
    x <- purrr::flatten(purrr::map(e$x$opts$options, ~.x$series))
  } else {
    x <- e_get_opts(e)$series
  }
  if (!rlang::is_empty(rlang::dots_list(...))) {
    x <- e_series_object(x, ...)
  }
  return(x)
}

#' Retrieve a specific object from each series item
#'
#' @param series \code{list} Echarts series options
#' @inheritParams purrr::pluck
#'
#' @return \code{list}
#' @export
#'

e_series_object <- function(series, ...) {
  x <- purrr::map(series, \(.x) {purrr::pluck(.x, ...)})
}

#' Extract the series data
#'
#' @param e \code{echart}
#' @param axis \code{chr} "x" or "y" to indicate data for which axis
#' @param as_chr \code{lgl} conver the output to a human legible string
#' @return \code{list}
#' @export
#'

e_series_data <- function(e) {
  # IMPORTANT This function is a monster because echarts does not play nice with data and nests data different depending on the type of graph. Thus every graph type must be accounted for to properly extract and re-assemble the data. Only a handful of graph types are accounted for here so this function is high error prone. The browser statement should fire whenever this function errors
  x <- e_series(e)
  # i <- switch(axis,
  #        x = 1,
  #        y = 2)
  .data <- vector("list")
  .desc <- vector("list")
  for (idx in seq_along(x)) {
    .data[[idx]] <- x[[idx]]$data
    .desc[[idx]] <- purrr::keep(x[[idx]], names(x[[idx]]) %nin% "data")
  }
  # Axis mappings in the series data
  .encode <- purrr::map(.desc, ~{
    out <- if ("encode" %in% names(.x))
      unlist(.x$encode)
    else if (identical(.x$type, "line") && "stack" %in% names(.x))
      "stack"
    else
      c(x = 0, y = 1)
    # JS to R increment indexes
    if (is.numeric(out))
      out <- out + 1
    return(out)
  })
  .types <- purrr::flatten_chr(purrr::map(.desc, "type"))
  .encode <- rlang::set_names(.encode, .types)
  out <- try({
    if (all(.encode == "stack")) {
      out <- dplyr::bind_cols(x = e_opts_xAxis(e)$data, rlang::set_names(.data, paste0("y", seq_along(.data))))

    } else if (any("boxplot" == .types)) {
      out <- purrr::map2_dfr(.data, .types, ~{
        if (identical(.y, "scatter")) {
          if (!rlang::is_empty(.x)) {
            .encoding <- names(.encode[[.y]])
            .out <- purrr::map(.x, \(.x) {rlang::set_names(.x, .encoding)}) |>
              dplyr::bind_rows()
          } else {
            .out <- rlang::set_names(NA, "y")
          }


        } else if (identical(.y, "boxplot")) {
          .out <- dplyr::bind_cols(rlang::set_names(.x, paste0("y", seq_along(.x))))
        }

      })
      out$x <- e_opts_xAxis(e)$type
      out
    } else if ("bar" %in% .types) {
      out <- purrr::map_dfr(.data[[1]], ~{
        d <- .x
        tibble::as_tibble(purrr::map(.encode[[1]], ~{
          .out <- suppressWarnings(as.numeric(d$value[.x]))
          if (!UU::is_legit(.out))
            .out <- d$value[.x]
          return(.out)
        }))
      })


    } else {
      out <- try(purrr::map2(.data, .encode, ~{
        d <- .x
        .enc <- .y
        purrr::map_dfc(.y, ~{
          i <- .x
          do.call(c, purrr::map(d, ~.x$value[[i]] %||% .x[[i]]))
        })
      }))
      if (!e$x$tl)
        names(out) <- purrr::map_chr(.desc, ~glue::glue("{.x$name}_{.x$type}"))
      out
    }
  })
  browser(expr = UU::is_error(out))

  return(out)
}

#' Extract data for a particular axis from an `axis_data`` tbl
#' @seealso e_series_data
#' @param axis_data \code{tbl} Axis data as returned by `e_series_data`
#' @param axis \code{chr} x or y. z currently not supported.
#' @param flat \code{lgl} Whether to flatten or leave as a tbl
#'
#' @return \code{num/tbl} depending on the value to `flat`
#' @export
#'

e_series_axis_data <- function(axis_data, axis = "x", flat = TRUE) {
  out <- if (is.data.frame(axis_data))
    dplyr::select(axis_data, dplyr::starts_with(axis))
  else
    purrr::map(axis_data, ~dplyr::select(.x, dplyr::starts_with(axis)))
  if (flat)
    out <- unlist(out)
  return(out)
}

#' Does the echart have xAxis options for each series (multiple unnamed lists with options)
#'
#' @param e \code{echart}
#'
#' @return \code{lgl}
#' @export

e_opts_is_xAxis_series <- function(e) {
  is.null(names(e_opts_xAxis(e)))
}

#' Get the xAxis type
#'
#' @param e \code{echart}
#'
#' @return \code{chr}
#' @export
#'

e_opts_xAxis_type <- function(e) {
  opts <- e_opts_xAxis(e)
  if (e_opts_is_xAxis_series(e))
    purrr::map_chr(opts, "type")
  else
    opts$type
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
                               min = "auto",
                               max = "auto",
                               name = purrr::when(e_year_on_x(e), isTRUE(.) ~ "Year", ~ NULL),
                               nameLocation = "middle",
                               nameTextStyle = list(padding = rep(0, 4), fontFamily = "rennerbook"),
                               nameGap = 35,
                               formatter = UU::as_js(
                                 "function(value, index){
          return typeof value == 'number' ? parseFloat(value) : value;
       }"
                               ),
       rotate = 45,
       fontFamily = "rennerbook",
       ...) {
  x <- e_series_axis_data(e_series_data(e), axis = "x")
  if (identical(min, "auto") && is.numeric(x))
    min <- UU::round_any(min(x, na.rm = TRUE), 10, floor)
  if (identical(max, "auto") && is.numeric(x))
    max <- UU::round_any(max(x, na.rm = TRUE), 10, ceiling)
  # Modify rather than replace
  out =
    rlang::exec(
      echarts4r::e_x_axis,
      e,
      !!!purrr::list_modify(
        e_opts_xAxis(e),
        !!!purrr::compact(list(
          scale = scale,
          type = type,
          axisLabel = purrr::compact(list(
            formatter = formatter,
            rotate = rotate,
            fontFamily = fontFamily
          )),
          min = min,
          max = max,
          name = name,
          nameLocation = nameLocation,
          nameTextStyle = nameTextStyle,
          nameGap = nameGap,
          ...
        ))
      )
    )

  return(out)
}

#' Calculate a best guess `nameGap` value for spacing the ECharts axis titles beyond the axis labels
#' @seealso e_y_axis_formatting
#' @param x \code{num} All values on the y axis. See `e_series_axis_data`
#'
#' @return \code{num}
#' @export

e_yAxis_width <- function(x, outtype = c("rounded", "abbreviated"), sf = 0) {
  .x <- abs(x)
  .x_str <- round(.x, purrr::when(.x, UU::most(. < 1) ~ 2, ~ 0)) |>
    max(na.rm = TRUE) |>
    UU::num2str(outtype = outtype, sf = sf)
  chars <- nchar(.x_str)
  chars * 8 + 15 # 8 pixels per character + ticks & Gap

}



js_num2str <- function(filename = dirs$js("num2str.js")) {
  UU::read_js(filename)
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


e_y_axis_formatting <- function(e,
                                scale = TRUE,
                                type = 'value',
                                formatter = UU::as_js(paste0("function(value, index){\n", js_num2str(),"\nreturn num2str({n: value});  }"
                                )),
                                fontFamily = "rennerbook",
                                nameLocation = "middle",
                                nameTextStyle = list(padding = c(0,0,0,0), fontFamily = "rennerbook"),
                                nameGap = 'auto',
                                name = NULL,
                                e_ctxt,
                                ...) {

  if (!missing(e_ctxt)) {
    # For use in RiverViz app
    e_ctxt = stringr::str_extract(id_from_ns(), UU::regex_or(c("reservoirs", "energy", "storage"))) %|% 'reservoirs'
    name = purrr::when(e_ctxt, . == "reservoirs" ~ "Elevation (F)", . == "energy" ~ "Output (MW)", . == "storage" ~ "Volume (AF)")
  }

  # Handle axis title units ----
  # Wed Oct  5 14:32:28 2022
  # e_series_Data needs debug for timeline line graphs with median

  x <- e_series_data(e)
  unit <- UU::unit_string(name)
  y <- e_series_axis_data(x, "y")
  .max <- max(abs(y), na.rm = TRUE)
  mo <- UU::magnitude_order(.max)

  if (mo >= 3 && UU::is_legit(unit) && UU::is_legit(formatter)) {
    UU::unit_string(name) <- UU::unit_modify_vec(.max, unit = unit, outtype = "end")
    .max <- round(.max / 10 ^ mo, 2)
  }


  if (nameGap == 'auto') {

    .args <- list(sf = 0,
                  # If formatter is specified, this outtype will mimic the formatter
                  outtype = c("rounded", "abbreviated"))
    # If no formatter, just round to 0 sf
    if (!is.character(formatter))
      .args$outtype = "rounded"

    nameGap <- rlang::exec(e_yAxis_width,
                           y,
                           !!!.args)
  }

  # Modify rather than replace
  out =
    rlang::exec(
      echarts4r::e_y_axis,
      e,
      !!!purrr::list_modify(
        e_opts_yAxis(e),
        !!!purrr::compact(rlang::list2(
          scale = scale,
          type = type,
          axisLabel = purrr::compact(list(
            formatter = formatter,
            fontFamily = fontFamily
          )),
          name = name,
          nameLocation = nameLocation,
          nameTextStyle = nameTextStyle,
          nameGap = nameGap,
          ...
        ))
      )
    )
  # Handle echarts `grid` options ----
  # Tue Jun 28 11:33:27 2022
  # NOTE echarts4r adds rather than replaces grid options causing modified value not to take effect (echarts uses the first relevant value as the option). This code modifies the grid options in place such that they take effect upon modification
  # Retrieve the options for modification
  opts <- e_get_opts(out)
  # Add grid spacing so labels & titles show properly
  grid <- opts$grid %||% list()

  grid <- if (purrr::vec_depth(grid) > 2)
    purrr::map(
      grid,
      ~ purrr::list_modify(.x, containLabel = TRUE))
  else
    purrr::list_modify(grid, containLabel = TRUE)

  opts$grid <- grid


  # reassign options
  out <- e_opts_update(out, opts, replace = TRUE)

  return(out)
}