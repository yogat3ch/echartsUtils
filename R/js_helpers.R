js_num2str <- function(filename = system.file("src", "js", "num2str.js", package = "echartsUtils")) {
  UU::read_js(filename)
}
