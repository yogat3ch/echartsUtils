#' Create an echarts style legend dot
#'
#' @param color \code{chr} CSS compliant color
#'
#' @return \code{shiny.tag.list}
#' @export
#'
#' @examples
#' e_tooltip_legend_dot("#48df94")
e_tooltip_legend_dot <- function(color) {
  rlang::exec(htmltools::tagList, !!!purrr::map(color, ~htmltools::tags$span(style = glue::glue("display:inline-block;margin-right:4px;border-radius:10px;width:10px;height:10px;background-color:{.x};"))))
}
