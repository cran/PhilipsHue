
#' Hue API: `capabilities` endpoints
#'
#' @return [get_capabilities] returns a list structure with the capabilities of
#' bridge resources.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/10-capabilities-api/>
#'
#' @name capabilities

#' @rdname capabilities
#' @export
get_capabilities <- function() {
    call_hue("get", "capabilities")
}
