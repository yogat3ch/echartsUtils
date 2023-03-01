

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
  s <- e$x$opts$series
  isTRUE(if (has_names(s)) {
    s$type
  } else {
    s[[1]]$type
  }  == "parallel")

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

  if (e_is_parallel(e))
    UU::gwarn("This is a parallel type Echart, see {.code e_parallel_default_opts}")
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

has_names <- function(x) {
  !is.null(names(x))
}

#' Initialize the options if they don't exist
#' @param e \code{echart}
#' @param names \code{chr} Name of the options to initialize. All top level headings on the \link{https://echarts.apache.org/en/option.html}{ECharts Option Documentation} are viable.
#' @return echart

e_opts_init <- function(e, ...) {
  opts <- rlang::dots_list(...)
  for (o in opts) {
    for (i in seq_along(o)) {
      if (is.null(purrr::pluck(e$x$opts, !!!as.list(o[1:i]))))
        purrr::pluck(e$x$opts, !!!as.list(o[1:i])) <- list()
    }
  }
  e
}
#' Add default options for Parallel Axis
#'
#' @param nameLocation \code{chr} \href{https://echarts.apache.org/en/option.html#parallel.parallelAxisDefault.nameLocation}{Link}
#' @param nameGap \code{num} \href{https://echarts.apache.org/en/option.html#parallel.parallelAxisDefault.nameGap}{Link}
#' @param axisLabel \code{list} \href{https://echarts.apache.org/en/option.html#parallel.parallelAxisDefault.axisLabel}{Link}
#' @return \code{echart}
#' @export
#'

e_parallelAxisDefault <- function(e,
                                       nameLocation = 'end',
                                       nameGap = 15,
                                       axisLabel = list(
                                         formatter = js_num2str()
                                       ),
                                       ...) {
  if (!e_is_parallel(e))
    UU::gbort("This is not a parallel type Echart.")

  args <- list(nameLocation = nameLocation,
               nameGap = nameGap,
               axisLabel = axisLabel,
               ...)
  # Add the options if they don't exist. Must use bracket subset because $ partial matches on parallelAxis
  if (is.null(e$x$opts[["parallel"]])) {
    e$x$opts[["parallel"]] <- list()
  }


  # Modify the existing values
  e$x$opts$parallel$parallelAxisDefault <- purrr::list_modify(e$x$opts$parallel$parallelAxisDefault %||% list(), !!!args)

  return(e)
}
#' Use the default options for parallelAxis ECharts
#'
#' @inherit e_default_opts params return
#' @export
#'

e_parallel_default_opts <- function(
    e,
    dims = TRUE,
    grid = list(
      containLabel = TRUE
    ),
    toolbox = list(orient = "vertical",
                   itemSize = 8,
                   itemGap = 3),
    # toolbox_feature = list(feature = c("saveAsImage")),
    tooltip = list(trigger = 'axis'),
    saveAsImage_filename = list(),
    parallelAxisDefault = TRUE,
    ...
) {
  if (!e_is_parallel(e))
    UU::gwarn("This is not a parallel type Echart, see {.code e_default_opts}")
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
