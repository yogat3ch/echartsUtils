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
