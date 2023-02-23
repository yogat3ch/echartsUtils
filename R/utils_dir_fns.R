#' directory path generation convenience functions
#' @param ... \code{(chr)} directory paths
#' @param mkpath \code{lgl} Whether to return a path regardless of whether the file/dir exists or not
#' @param ext \code{(chr)} file extension
#' @param mustWork \code{lgl} If `TRUE`, an error is given if there are no matching files.
#' @usage dirs$data()
#' @export
#' @examples dirs$data("mydata", ext = "csv")
dirs <-
list(css = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("inst/app/www/css", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, data = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("data", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, dev = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("dev", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, extdata = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("inst/extdata", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, img = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("inst/app/www/img", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, inst = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("inst", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, js = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("inst/app/www/js", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, R = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("R", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, renv = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("renv", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, tests = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("tests/testthat", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, top = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path(".", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, vault = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("inst/vault", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
}, www = function (..., ext = "", mkpath = FALSE, mustWork = FALSE) 
{
    .path <- fs::path("inst/app/www", ..., ext = ext)
    out <- if (!mkpath) {
        .path <- stringr::str_remove(.path, "^inst\\/?")
        if (!FALSE && mustWork) 
            fs::path_package(package = "echartsUtils", .path)
        else .path
    }
    else .path
    return(out)
})
