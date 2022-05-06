
#' Hue API: `groups` endpoints
#'
#' @param id ID of a specific group
#' @param ... named parameters describing group attributes or state
#'   (e.g. `name = "foo"`; `on = TRUE`)
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/groupds-api/>
#'
#' @name groups

#' @rdname groups
#' @export
create_group <- function(...) {
    call_hue("post", "groups", list(...))
}

#' @rdname groups
#' @export
get_groups <- function() {
    call_hue("get", "groups")
}

#' @rdname groups
#' @export
get_group <- function(id) {
    call_hue("get", paste("groups", id, sep = "/"))
}

#' @rdname groups
#' @export
set_group_attributes <- function(id, ...) {
    call_hue("put", paste("groups", id, sep = "/"), list(...))
}

#' @rdname groups
#' @export
set_group_state <- function(id, ...) {
    call_hue("put", paste("groups", id, "action", sep = "/"), list(...))
}

#' @rdname groups
#' @export
delete_group <- function(id) {
    call_hue("delete", paste("groups", id, sep = "/"))
}
