#' Use dependencies for echartsUtils
#'
#' @return \code{shiny.tag.list}
#' @export
#'

use_echartsUtils_deps <- function() {
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
