
<!-- README.md is generated from README.Rmd. Please edit that file -->

# echartsUtils

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of echartsUtils is to consolidate helpful utility functions for
modifying Echarts rendered via
[echarty](https://github.com/helgasoft/echarty) &
[echarts4r](https://github.com/JohnCoene/echarts4r).

## Installation

You can install the development version of echartsUtils from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("yogat3ch/echartsUtils")
```

## Functions

<table class="table">
<thead>
<tr>
<th>Name</th>
<th>Concept</th>
<th>Title</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>dirs</td>
<td></td>
<td>directory path generation convenience functions</td>
<td>
directory path generation convenience functions
</td>
</tr>
<tr>
<td>e_default_opts</td>
<td></td>
<td>Use the default options applied to each echart.</td>
<td>
Use the default options applied to each echart.

Use the default options applied to each echart.
</td>
</tr>
<tr>
<td>e_get_opts</td>
<td></td>
<td>Get the options from an echart</td>
<td>
Get the options from an echart

Get the options from an echart
</td>
</tr>
<tr>
<td>e_has_base_opts</td>
<td></td>
<td>Is the echart using baseOptions</td>
<td>
Is the echart using baseOptions

Is the echart using baseOptions
</td>
</tr>
<tr>
<td>e_has_group</td>
<td></td>
<td>Does the echart have a group</td>
<td>
Does the echart have a group

Does the echart have a group
</td>
</tr>
<tr>
<td>e_has_timeline</td>
<td></td>
<td>Does the echart have a timeline</td>
<td>
Does the echart have a timeline

Does the echart have a timeline
</td>
</tr>
<tr>
<td>e_js_axisPointer</td>
<td></td>
<td>A callback function with associated dependencies for formatting Echarts axisPointers</td>
<td>
A callback function with associated dependencies for formatting Echarts axisPointers
</td>
</tr>
<tr>
<td>e_opts_is_xAxis_series</td>
<td></td>
<td>Does the echart have xAxis options for each series (multiple unnamed lists with options)</td>
<td>
Does the echart have xAxis options for each series (multiple unnamed lists with options)

Does the echart have xAxis options for each series (multiple unnamed lists with options)
</td>
</tr>
<tr>
<td>e_opts_line_default</td>
<td></td>
<td>Apply default options for a</td>
<td>
Apply default options for a
</td>
</tr>
<tr>
<td>e_opts_make_stacked_area_series</td>
<td></td>
<td>Makes an appropriately styled data list for stacked area charts for
a single serie</td>
<td>
Makes an appropriately styled data list for stacked area charts for
a single serie
</td>
</tr>
<tr>
<td>e_opts_modify</td>
<td></td>
<td>Modify echarts options</td>
<td>
Modify echarts options
</td>
</tr>
<tr>
<td>e_opts_update</td>
<td></td>
<td>Update echarts options</td>
<td>
Update echarts options
</td>
</tr>
<tr>
<td>e_opts_xAxis_type</td>
<td></td>
<td>Get the xAxis type</td>
<td>
Get the xAxis type

Get the xAxis type
</td>
</tr>
<tr>
<td>e_opts_xAxis</td>
<td></td>
<td>Get x-axis options</td>
<td>
Get x-axis options
</td>
</tr>
<tr>
<td>e_opts_yAxis</td>
<td></td>
<td>Get y-axis options</td>
<td>
Get y-axis options
</td>
</tr>
<tr>
<td>e_saveAsImage_filename</td>
<td></td>
<td>saveAsImage_filename</td>
<td>
A utils function used in echarts module building chains. The
function takes an echarts object in, as well as a name and adds the name to
the saveImageAs toolbox feature.
</td>
</tr>
<tr>
<td>e_series_axis_data</td>
<td></td>
<td>Extract data for a particular axis from an `axis_data`` tbl</td>
<td>
Extract data for a particular axis from an `axis_data`` tbl
</td>
</tr>
<tr>
<td>e_series_data</td>
<td></td>
<td>Extract the series data</td>
<td>
Extract the series data

Extract the series data
</td>
</tr>
<tr>
<td>e_series_object</td>
<td></td>
<td>Retrieve a specific object from each series item</td>
<td>
Retrieve a specific object from each series item
</td>
</tr>
<tr>
<td>e_series</td>
<td></td>
<td>Get the series option from an echarts object</td>
<td>
Get the series option from an echarts object
</td>
</tr>
<tr>
<td>e_tooltip_legend_dot</td>
<td></td>
<td>Create an echarts style legend dot</td>
<td>
Create an echarts style legend dot
</td>
</tr>
<tr>
<td>e_x_axis_formatting</td>
<td></td>
<td>e_x_axis_year_formatting</td>
<td>
generates a list that configures the min/max and correct axis formatting
for echarts figs
</td>
</tr>
<tr>
<td>e_y_axis_formatting</td>
<td></td>
<td>e_y_axis_year_formatting</td>
<td>
generates a list that configures the correct y axis formatting for echarts figs
</td>
</tr>
<tr>
<td>e_yAxis_width</td>
<td></td>
<td>Calculate a best guess nameGap value for spacing the ECharts axis titles beyond the axis labels</td>
<td>
Calculate a best guess nameGap value for spacing the ECharts axis titles beyond the axis labels
</td>
</tr>
<tr>
<td>e_year_on_x</td>
<td></td>
<td>Is the X axis in years?</td>
<td>
Is the X axis in years?

Is the X axis in years?
</td>
</tr>
<tr>
<td>js_num2str</td>
<td></td>
<td>An JS callback formatting function</td>
<td>
An JS callback formatting function
</td>
</tr>
<tr>
<td>Re-imports</td>
<td></td>
<td>Re-imports</td>
<td>
Useful functions from other packages
</td>
</tr>
<tr>
<td>reexports</td>
<td></td>
<td>Objects exported from other packages</td>
<td>
These objects are imported from other packages. Follow the links
below to see their documentation.


  rlang%|%, %||%

  UU%|0|%, %|legit|%, %|try|%, %|zchar|%
</td>
</tr>
<tr>
<td>use_js_deps</td>
<td></td>
<td>Use dependencies for echartsUtils</td>
<td>
Use dependencies for echartsUtils
</td>
</tr>
</tbody>
</table>
