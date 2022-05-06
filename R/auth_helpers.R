
#' Authentication helpers
#'
#' These functions help manage the environment variables that the PhilipsHue
#' package uses to store authentication secrets.
#'
#' Local authentication requires setting two environment variables:
#' `PHILIPS_HUE_BRIDGE_IP` and `PHILIPS_HUE_BRIDGE_USERNAME`. [has_local_auth()]
#' uses regular expressions to check if these variables are set (but does not
#' check if the credentials actually work). [reset_auth()] sets these variables
#' to empty strings, and [write_auth()] writes the current values to a file
#' (e.g. an `.Renviron` file for use during development).
#'
#' @param path file path to write secrets to
#' @param append passed to [write()]
#'
#' @return [has_local_auth()] returns a logical value; [write_auth()] and
#'   [reset_auth()] return `TRUE` invisibly upon success.
#'
#' @name auth_helpers

#' @rdname auth_helpers
#' @export
has_local_auth <- function() {
    grepl("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", Sys.getenv("PHILIPS_HUE_BRIDGE_IP")) &
    grepl("^.{40}$", Sys.getenv("PHILIPS_HUE_BRIDGE_USERNAME"))
}

#' @rdname auth_helpers
#' @export
write_auth <- function(path = ".Renviron", append = TRUE) {
    vars <- c("PHILIPS_HUE_BRIDGE_IP", "PHILIPS_HUE_BRIDGE_USERNAME") |>
        Sys.getenv()

    sprintf('%s="%s"', names(vars), vars) |>
    write(path, append = append) |>
    is.null() |>
    invisible()
}

#' @rdname auth_helpers
#' @export
reset_auth <- function() {
    Sys.setenv(PHILIPS_HUE_BRIDGE_IP = "", PHILIPS_HUE_BRIDGE_USERNAME = "")
    return(invisible(TRUE))
}
