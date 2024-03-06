#' Create an echarts style legend dot
#' @family legend
#' @param color \code{chr} CSS compliant property
#' @param background_color \code{chr} CSS compliant property
#' @param border_radius \code{chr} CSS compliant property
#' @param opacity \code{chr} CSS compliant property
#' @param height \code{chr} CSS compliant property
#' @param width \code{chr} CSS compliant property
#' @param margin_right \code{chr} CSS compliant property
#' @param display \code{chr} CSS compliant property
#' @param as_chr \code{lgl} whether the output should be HTML/character
#' @param ... \code{chr} Additional CSS properties
#' @return \code{shiny.tag}
#' @export
#'
#' @examples
#' e_tooltip_legend_dot("#48df94")
e_tooltip_legend_dot <- function(background_color, color = "#000", border_radius = "10px", opacity = .2, height = "10px", width = "10px", margin_right = "4px", display = "inline-block", as_chr = FALSE, ...) {
  props <- rlang::dots_list(...)
  props <- append(props,
                  list(
                    display = display,
                    `background-color` = background_color,
                    color = color,
                    `border-radius` = border_radius,
                    opacity = opacity,
                    height = height,
                    width = width,
                    `margin-right` = margin_right
                  ))
  out <- htmltools::tags$span(
    style = css_props(declarations = props, inline = TRUE)
  )
  if (as_chr)
    out <- htmltools::doRenderTags(out)
  return(out)
}

#' Create a rectangle legend item
#'
#' @inheritParams e_tooltip_legend_dot
#' @family legend
#' @return \code{shiny.tag}
#' @export
#'
#' @examples
#' e_tooltip_legend_rectangle("#48df94")
e_tooltip_legend_rectangle <- function(background_color, color = "#000", opacity = .2, height = "10px", width = "20px", display = "inline-block", as_chr = FALSE, ...) {

  props <- rlang::dots_list(...)
  props <- append(props,
         list(
           display = display,
           `background-color` = background_color,
           color = color,
           opacity = opacity,
           height = height,
           width = width
         ))
  out <- htmltools::tags$span(
    style = css_props(declarations = props, inline = TRUE)
  )
  if (as_chr)
    out <- htmltools::doRenderTags(out)
  return(out)
}

css_props <- function (...,
                       declarations = NULL,
                       inline = FALSE) {
  .dots <- rlang::dots_list(..., .named = TRUE)
  declarations <- rlang::list2(!!!.dots, !!!declarations)
  paste0(purrr::imap_chr(declarations, ~ glue::glue("{.y}: {.x};")),
         collapse = ifelse(inline, "", "\n"))
}
