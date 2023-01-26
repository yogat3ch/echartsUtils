#' Use dependencies for echartsUtils
#'
#' @return \code{shiny.tag.list}
#' @export
#'

use_js_deps <- function() {
  js_src <- system.file("src", "js", package = "echartsUtils")
  deps <-
    tibble::tibble(
      name = c("axisPointer", "sigFig", "addCommas", "num2str", "helpers"),
      version = utils::packageVersion("echartsUtils"),
      src = c(href = js_src),
      script = fs::path(name, ext = "js")
    )

  rlang::exec(
    htmltools::tagList,
    !!!purrr::pmap(deps, \(...) {
      .x <- list(...)
      rlang::exec(htmltools::htmlDependency, !!!.x)
    })
  )
}
js_num2str <-
  function(filename = system.file("src", "js", "num2str.js", package = "echartsUtils")) {
    UU::read_js(filename)
  }

#' A callback function with associated dependencies for formatting Echarts axisPointers
#'
#' @return \code{shiny.tag.list}
#' @export
#'

e_js_axisPointer <- function(sf = 0) {
  UU::glue_js("
            (params) => {
              return axisPointer(params, sf = *{sf}*);
            }
            ")
}


#' An JS callback formatting function
#' @param js_parameters \code{chr} the parameters to pass to the Javascript Callback function
#' @param n \code{chr} The javascript value to pass as `n`, the number to be transformed by `num2str`
#' @param sf \code{int} significant figures of output
#' @param add_suffix \code{lgl}  whether to add a letter suffix
#' @param suffix_lb \code{chr} The lower bound of the divisor (IE "M" do not go lower than millions)
#' @param format \code{lgl} whether to reduce the magnitude when formatting
#' @param magnitude \code{chr} If the magnitude is known apriori this can be used to override the factoring
#'
#' @return The JS string with appropriate arguments
#' @export

e_js_num2str <- function(js_parameters = c("value", "index"), n = "value", sf = NULL, add_suffix = NULL, suffix_lb = NULL, format = NULL, magnitude = NULL) {
  args <- purrr::compact(list(
    sf = sf,
    add_suffix = add_suffix,
    suffix_lb = suffix_lb,
    format = format,
    magnitude = magnitude)) |>
    jsonlite::toJSON(auto_unbox = TRUE) |>
    stringr::str_remove_all("\"")

  js_p <- glue::glue_collapse(js_parameters, sep = ", ")

  return(UU::glue_js("(*{js_p}*) => {
      var args = *{args}*;
      args.n = *{n}*;
      return num2str(args);
    }"))
}
