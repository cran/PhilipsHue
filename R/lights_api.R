
#' Hue API: `lights` endpoints
#'
#' @param id ID of a specific light
#' @param name name to assign to the light
#' @param ... named parameters describing light state (e.g. `on = TRUE`)
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/lights-api/>
#'
#' @name lights

#' @rdname lights
#' @export
search_for_new_lights <- function() {
    call_hue("post", "lights")
}

#' @rdname lights
#' @export
get_new_lights <- function() {
    call_hue("get", "lights/new")
}

#' @rdname lights
#' @export
rename_light <- function(id, name) {
    call_hue("put", paste("lights", id, sep = "/"), list(name = name))
}

#' @rdname lights
#' @export
get_lights <- function() {
    call_hue("get", "lights")
}

#' @rdname lights
#' @export
get_light <- function(id) {
    call_hue("get", paste("lights", id, sep = "/"))
}

#' @rdname lights
#' @export
set_light_state <- function(id, ...) {
    call_hue("put", paste("lights", id, "state", sep = "/"), list(...))
}

#' @rdname lights
#' @export
delete_light <- function(id) {
    call_hue("delete", paste("lights", id, sep = "/"))
}
