
#' Authentication -- local
#'
#' This function helps check and set the necessary environment variables to
#' authenticate to a Hue bridge on the local network.
#'
#' @param ip the IP address of your Hue bridge
#' @param username the username with access to your Hue bridge
#'
#' @return Returns `TRUE` (invisibly) if options were successfully set
#'
#' @seealso <https://developers.meethue.com/develop/get-started-2/>
#'
#' @export
auth_local <- function(
    ip = Sys.getenv("PHILIPS_HUE_BRIDGE_IP"),
    username = Sys.getenv("PHILIPS_HUE_BRIDGE_USERNAME")
) {

    # Check inputs
    if (!(!is.null(ip) && is.character(ip) && length(ip) == 1L)) {
        stop("`ip` must be a single character value")
    }

    if (!(!is.null(username) && is.character(username) && length(username) == 1L)) {
        stop("`username` must be a single character value")
    }

    if (length(ip) != 1L || !grepl("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", ip)) {
        stop("Invalid value for `ip`")
    }

    if (length(username) != 1L || !grepl("^.{40}$", username)) {
        stop("Invalid value for `username`")
    }

    # Sanitize, just in case
    ip <- utils::URLencode(ip)
    username <- utils::URLencode(username)

    # Save secrets as environment variables
    Sys.setenv(
        PHILIPS_HUE_BRIDGE_IP = ip,
        PHILIPS_HUE_BRIDGE_USERNAME = username
    )

    # Fin
    return(invisible(TRUE))
}
