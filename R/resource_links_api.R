
#' Hue API: `resourcelinks` endpoints
#'
#' @param id ID of a specific resourcelink
#' @param ... named parameters describing resourcelink attributes
#'   (e.g. `name = "foo"`)
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/9-resourcelinks-api/>
#'
#' @name resourcelinks

#' @rdname resourcelinks
#' @export
create_resourcelink <- function(...) {
    call_hue("post", "resourcelinks", list(...))
}

#' @rdname resourcelinks
#' @export
get_resourcelinks <- function() {
    call_hue("get", "resourcelinks")
}

#' @rdname resourcelinks
#' @export
get_resourcelink <- function(id) {
    call_hue("get", paste("resourcelinks", id, sep = "/"))
}

#' @rdname resourcelinks
#' @export
set_resourcelink_attributes <- function(id, ...) {
    call_hue("put", paste("resourcelinks", id, sep = "/"), list(...))
}

#' @rdname resourcelinks
#' @export
delete_resourcelink <- function(id) {
    call_hue("delete", paste("resourcelinks", id, sep = "/"))
}
