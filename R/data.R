#' Is the X axis in years?
#'
#' @param e \code{echart}
#' @family data
#' @return \code{lgl}
#' @export
#'

e_year_on_x <- function(e) {
  out <- try(
    all(dplyr::between(unlist(e_series_data(e, axis = "x", as_chr = FALSE)), 600, 2200))
  )
  return(out)
}
#' Extract the series data
#' @family data
#' @param e \code{echart}
#' @param axis \code{chr} "x" or "y" to indicate data for which axis
#' @param as_chr \code{lgl} conver the output to a human legible string
#' @return \code{list}
#' @export
#'

e_series_data <- function(e, axis = "y", as_chr = TRUE) {
  if (e_has_base_opts(e)) {
    x <- purrr::flatten(purrr::map(e$x$opts$options, ~.x$series))
  } else {
    x <- e_get_opts(e)$series
  }
  i <- switch(axis,
              x = 1,
              y = 2)

  out <- suppressWarnings(purrr::compact(purrr::map(x, ~{
    if ("type" %in% names(.x)) {
      if (.x$type %in% c("scatter", "line"))
        out <- purrr::map(.x$data, ~ {
          if ("value" %in% names(.x))
            .out <- .x$value[i]
          else
            .out <- .x[[i]] %|try|% purrr::flatten(.x)[[i]]
          return(.out)
        })
      else
        out <- NULL
    } else {
      out <- NULL
    }
    return(out)
  })))

  if (as_chr) {
    while (purrr::vec_depth(out) > 2) {
      out <- purrr::flatten(out)
    }
    out <- try(UU::num2str(out))
  }

  browser(expr = UU::is_error(out))
  return(out)
}
