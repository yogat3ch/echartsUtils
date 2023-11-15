#' Use dependencies for echartsUtils
#'
#' @return \code{shiny.tag.list}
#' @export
#'

use_js_deps <- function() {
  js_src <- system.file("srcjs", package = "echartsUtils")
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
.js_num2str <-
  function(filename = system.file("srcjs", "num2str.js", package = "echartsUtils")) {
    UU::read_js(filename)
  }



#' An JS callback formatting function
#' @param js_parameters \code{chr} the parameters to pass to the Javascript Callback function
#' @param n \code{chr} The javascript value to pass as `n`, the number to be transformed by `num2str`
#' @param sf \code{int} significant figures of output **Default: 2**
#' @param add_suffix \code{lgl}  whether to add a letter suffix **Default: FALSE**
#' @param suffix_lb \code{chr} The lower bound of the divisor (IE "M" do not go lower than millions) **Default: ''** for no lower bound
#' @param format \code{lgl} whether to reduce the magnitude when formatting **Default: TRUE**
#' @param magnitude \code{chr} If the magnitude is known apriori this can be used to override the factoring **Default: NULL**
#' @param add_commas \code{lgl} Format the numeric string output with commas every thousands place. **Default: FALSE**
#' @details  The Javascript function is provided below for reference:
#' ```{r echo=FALSE}
#' glue::glue_collapse(readLines(system.file("srcjs","num2str.js", package = "echartsUtils")), sep = '\n')
#' ```
#' @return The JS callback function as a string with appropriate arguments
#' @export

js_num2str <- function(js_parameters = c("value", "index"), n = "value", sf = NULL, add_suffix = NULL, suffix_lb = NULL, format = NULL, magnitude = NULL, add_commas = NULL) {
  args <- purrr::compact(list(
    sf = sf,
    add_suffix = add_suffix,
    suffix_lb = suffix_lb,
    format = format,
    magnitude = magnitude,
    add_commas = add_commas)) |>
    jsonlite::toJSON(auto_unbox = TRUE) |>
    stringr::str_remove_all("\"")

  js_p <- glue::glue_collapse(js_parameters, sep = ", ")

  return(UU::glue_js("(*{js_p}*) => {
      var args = *{args}*;
      args.n = *{n}*;
      return num2str(args);
    }"))
}

#' A callback function with associated dependencies for formatting Echarts axisPointers
#' @inheritParams js_num2str
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
