

#' Is the echart using baseOptions
#' @family options
#' @param e \code{echart}
#'
#' @return \code{lgl}
#' @export

e_has_base_opts <- function(e) {
  !is.null(e$x$opts$baseOption)
}

#' Get the options from an echart
#'
#' @inheritParams e_has_base_opts
#' @family options
#' @return \code{list}
#' @export

e_get_opts <- function(e) {
  e$x$opts$baseOption %||% e$x$opts
}


#' Does the echart have a group
#' @family options
#' @inherit e_has_base_opts params return
#' @export

e_has_group <- function(e) {
  !is.null(e$x$chartGroup)
}


#' Does the echart have a timeline
#' @family options
#' @inherit e_has_base_opts params return
#' @export
e_has_timeline <- function(e) {
  !is.null(e_get_opts(e)$timeline)
}

#' Modify echarts options
#'
#' @param e \code{echart}
#' @param opts \code{list} of options to replace/modify
#' @param replace \code{lgl} whether to replace or modify (the default)
#' @family options
#' @return \code{list}
#' @export

e_opts_modify <- function(e, opts, replace = FALSE) {
  if (replace) {
    .opts <- opts
  } else {
    .opts <- e_get_opts(e)
    .opts <- purrr::list_modify(.opts, !!!opts)
  }
  .opts
}

#' Update echarts options
#'
#' @inheritParams e_opts_modify
#' @family options
#' @return \code{echarts}
#' @export

e_opts_update <- function(e, opts, replace = FALSE) {
  .opts <- e_opts_modify(e, opts, replace)
  if (!e_has_timeline(e)) {
    e$x$opts <- .opts
  } else {
    e$x$opts$baseOption <- .opts
  }
  e
}

#' Is the chart a parallelAxis chart?
#'
#' @param e \code{echart/htmlwidget}
#'
#' @return \code{lgl} whether or not the Echart is a parallel type chart
#' @export
#'

e_is_parallel <- function(e) {
  isTRUE(e$x$opts$series$type == "parallel")
}

#' Use the default options applied to each echart.
#' @family options
#' @param dims \code{(list/logical/NULL)} See \link[echarts4r]{e_dims}
#' @param datazoom \code{(list/logical/NULL)} See \link[echarts4r]{e_datazoom}
#' @param toolbox \code{(list/logical/NULL)} See \link[echarts4r]{e_toolbox}
#' @param toolbox_feature \code{(list/logical/NULL)} See \link[echarts4r]{e_toolbox_feature}
#' @param tooltip \code{(list/logical/NULL)} See \link[echarts4r]{e_tooltip}
#' @param x_axis_formatting \code{(list/logical/NULL)} See `e_x_axis_formatting`
#' @param y_axis_formatting \code{(list/logical/NULL)} See `e_y_axis_formatting`
#' @param saveAsImage_filename \code{(list/logical/NULL)} See `saveAsImage_filename`
#' @param ... Additional `echarts4r` named arguments, IE for \link[echarts4r]{e_add_nested} used `add_nested = list([...])` where the list holds the args to pass to the function.
#' @return \code{echart}
#' @export
#'

e_default_opts <- function(e,
                           dims = TRUE,
                           datazoom = FALSE,
                           grid = list(
                             containLabel = TRUE
                           ),
                           toolbox = list(orient = "vertical",
                                          itemSize = 8,
                                          itemGap = 3),
                           toolbox_feature = list(feature = c("saveAsImage" , "dataZoom", "restore")),
                           x_axis_formatting = TRUE,
                           y_axis_formatting = TRUE,
                           tooltip = list(trigger = 'axis'),
                           text_style = list(fontFamily = 'rennerbook'),
                           saveAsImage_filename = list(),
                           ...) {
  e_funs <- lsf.str(pattern = "^e_", rlang::ns_env("echartsUtils"))
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
