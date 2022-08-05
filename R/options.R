#' Is the echart using baseOptions
#'
#' @param e \code{echart}
#'
#' @return \code{lgl}
#' @export

e_has_base_opts <- function(e) {
  !is.null(e$x$opts$baseOption)
}

#' Does the echart have a group
#'
#' @inherit e_has_base_opts params return
#' @export

e_has_group <- function(e) {
  !is.null(e$x$chartGroup)
}


#' Does the echart have a timeline
#'
#' @inherit e_has_base_opts params return
#' @export
e_has_timeline <- function(e) {
  !is.null(e_get_opts(e)$timeline)
}
#' Get the options from an echart
#'
#' @inheritParams e_has_base_opts
#'
#' @return \code{list}
#' @export

e_get_opts <- function(e) {
  e$x$opts$baseOption %||% e$x$opts
}

#' Does the echart have xAxis options for each series (multiple unnamed lists with options)
#'
#' @param e \code{echart}
#'
#' @return \code{lgl}
#' @export

e_opts_is_xAxis_series <- function(e) {
  is.null(names(e_get_opts(e)$xAxis))
}

#' Get the xAxis type
#'
#' @param e \code{echart}
#'
#' @return \code{chr}
#' @export
#'

e_opts_xAxis_type <- function(e) {
  opts <- e_get_opts(e)
  if (e_opts_is_xAxis_series(e))
    opts$xAxis[[1]]$type
  else
    opts$xAxis$type
}

#' Use the default options applied to each echart.
#'
#' @param dims \code{(list/logical/NULL)} See \link[echarts4r]{e_dims}
#' @param datazoom \code{(list/logical/NULL)} See \link[echarts4r]{e_datazoom}
#' @param toolbox \code{(list/logical/NULL)} See \link[echarts4r]{e_toolbox}
#' @param toolbox_feature \code{(list/logical/NULL)} See \link[echarts4r]{e_toolbox_feature}
#' @param tooltip \code{(list/logical/NULL)} See \link[echarts4r]{e_tooltip}
#' @param grid \code{(list/logical/NULL)} See \link[echarts4r]{e_grid}
#' @param x_axis_formatting \code{(list/logical/NULL)} See `e_x_axis_formatting`
#' @param y_axis_formatting \code{(list/logical/NULL)} See `e_y_axis_formatting`
#' @param saveAsImage_filename \code{(list/logical/NULL)} See `saveAsImage_filename`
#' @param ... Additional `echarts4r` named arguments, IE for \link[echarts4r]{e_add_nested} used `add_nested = list([...])` where the list holds the args to pass to the function.
#' @return \code{echart}
#' @export
#'

e_default_opts <- function(e,
                           dims = TRUE,
                           datazoom = TRUE,
                           toolbox = list(orient = "vertical",
                                          itemSize = 8,
                                          itemGap = 3),
                           toolbox_feature = list(feature = c("saveAsImage" , "dataZoom", "restore")),
                           x_axis_formatting = TRUE,
                           y_axis_formatting = TRUE,
                           tooltip = list(trigger = 'axis'),
                           grid = list(containLabel = TRUE),
                           text_style = list(fontFamily = 'rennerbook', color = "#ffffff"),
                           saveAsImage_filename = list(),
                           ...) {
  e_funs <- lsf.str(pattern = "^e_", rlang::ns_env(pkgload::pkg_name()))
  .dots <- rlang::dots_list(..., .named = TRUE)
  named_args <- rlang::fn_fmls_names() |>
    {\(x) {subset(x, !x %in% c("e", "..."))}}() |>
    rlang::set_names() |>
    purrr::map(get0, envir = environment()) |>
    append(.dots) |>
    {\(x) {rlang::set_names(x, paste0("e_", names(x)))}}()

  out <- purrr::reduce2(named_args, names(named_args), ~ {
    if (!is.null(..2) && !isFALSE(..2)) {
      # NULL arg skips
      .args <- purrr::when(..2,
                           is.list(.) ~ ..2,
                           . ~ list())
      .call <- rlang::call2(..3, ..1, !!!.args, .ns = ifelse(..3 %in% e_funs, "echartsUtils", "echarts4r"))
      out <- rlang::eval_bare(.call)
    } else
      out <- ..1

    out
  }, .init = e)


  out
}
