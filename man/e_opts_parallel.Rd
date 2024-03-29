% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/e_opts_general.R
\name{e_opts_parallel}
\alias{e_opts_parallel}
\title{Modify parallel options}
\usage{
e_opts_parallel(
  e,
  top = NULL,
  right = NULL,
  bottom = NULL,
  left = NULL,
  layout = NULL,
  parallelAxisDefault = list(),
  ...
)
}
\arguments{
\item{e}{\code{echart}}

\item{top}{\code{num} See \link{https://echarts.apache.org/en/option.html#parallel.top}{Docs}. \strong{Default: 60}}

\item{right}{\code{num} See \link{https://echarts.apache.org/en/option.html#parallel.right}{Docs}. \strong{Default: 80}}

\item{bottom}{\code{num} See \link{https://echarts.apache.org/en/option.html#parallel.bottom}{Docs}. \strong{Default: 60}}

\item{left}{\code{num} See \link{https://echarts.apache.org/en/option.html#parallel.left}{Docs}. \strong{Default: 80}}

\item{layout}{\code{chr} See \link{https://echarts.apache.org/en/option.html#parallel.layout}{Docs}. \strong{Default: 'horizontal'}}

\item{parallelAxisDefault}{See \link{https://echarts.apache.org/en/option.html#parallel.parallelAxisDefault}{Docs} for all available options.}

\item{...}{See \link{https://echarts.apache.org/en/option.html#parallel}{Docs} for all available options}
}
\value{
\code{echart}
}
\description{
Modify parallel options
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
\code{\link{e_opts_update}()},
\code{\link{e_opts_xAxis_type}()},
\code{\link{e_opts_xAxis}()},
\code{\link{e_opts_yAxis}()},
\code{\link{e_parallel_default_opts}()},
\code{\link{e_series_axis_data}()},
\code{\link{e_series_data}()},
\code{\link{e_series}()},
\code{\link{e_x_axis_formatting}()},
\code{\link{e_yAxis_width}()},
\code{\link{e_y_axis_formatting}()}
}
\concept{options}
