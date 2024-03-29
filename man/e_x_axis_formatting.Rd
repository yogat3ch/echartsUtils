% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/e_opts_axes.R
\name{e_x_axis_formatting}
\alias{e_x_axis_formatting}
\title{e_x_axis_year_formatting}
\usage{
e_x_axis_formatting(
  e,
  scale = TRUE,
  type = e_opts_xAxis_type(e) \%||\% "value",
  min = "auto",
  max = "auto",
  name = if (e_year_on_x(e)) {
     "Year"
 },
  nameLocation = "middle",
  nameTextStyle = list(padding = rep(0, 4)),
  nameGap = 35,
  formatter =
    htmlwidgets::JS("function(value, index){\\n          return typeof value == 'number' ? parseFloat(value) : value;\\n       }"),
  rotate = 45,
  ...
)
}
\arguments{
\item{...}{
  Arguments passed on to \code{\link[echarts4r:axis]{echarts4r::e_x_axis}}
  \describe{
    \item{\code{e}}{An \code{echarts4r} object as returned by \code{\link[echarts4r]{e_charts}} or
a proxy as returned by \code{\link[echarts4r]{echarts4rProxy}}.}
    \item{\code{serie}}{Column name of serie to range the axis. If used the range of the serie is used as,
\code{min} an \code{max}.}
    \item{\code{index}}{Index of axis to customise.}
    \item{\code{formatter}}{An axis formatter as returned by \code{\link[echarts4r]{e_axis_formatter}}.}
    \item{\code{margin}}{Margin to apply to \code{serie}: \eqn{min = serie - margin} and
\eqn{max = serie + margin}}
  }}

\item{e_ctxt}{\code{(character)} The context in which the e_chart is being rendered}
}
\value{
A list of parameters for appropriate x-axis formatting for years on echarts figures
}
\description{
generates a list that configures the min/max and correct axis formatting
for echarts figs
}
\seealso{
Other options: 
\code{\link{e_default_opts}()},
\code{\link{e_get_opts}()},
\code{\link{e_has_base_opts}()},
\code{\link{e_has_group}()},
\code{\link{e_has_timeline}()},
\code{\link{e_opts_is_xAxis_series}()},
\code{\link{e_opts_line_default}()},
\code{\link{e_opts_make_stacked_area_series}()},
\code{\link{e_opts_modify}()},
\code{\link{e_opts_parallelAxisDefault}()},
\code{\link{e_opts_parallel}()},
\code{\link{e_opts_update}()},
\code{\link{e_opts_xAxis_type}()},
\code{\link{e_opts_xAxis}()},
\code{\link{e_opts_yAxis}()},
\code{\link{e_parallel_default_opts}()},
\code{\link{e_series_axis_data}()},
\code{\link{e_series_data}()},
\code{\link{e_series}()},
\code{\link{e_yAxis_width}()},
\code{\link{e_y_axis_formatting}()}
}
\concept{options}
