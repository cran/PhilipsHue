
#' Hue API: `schedules` endpoints
#'
#' @param id ID of a specific schedule
#' @param ... named parameters describing schedule attributes
#'   (e.g. `name = "foo"`)
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/3-schedules-api/>
#'
#' @name schedules

#' @rdname schedules
#' @export
create_schedule <- function(...) {
    call_hue("post", "schedules", list(...))
}

#' @rdname schedules
#' @export
get_schedules <- function() {
    call_hue("get", "schedules")
}

#' @rdname schedules
#' @export
get_schedule <- function(id) {
    call_hue("get", paste("schedules", id, sep = "/"))
}

#' @rdname schedules
#' @export
set_schedule_attributes <- function(id, ...) {
    call_hue("put", paste("schedules", id, sep = "/"), list(...))
}

#' @rdname schedules
#' @export
delete_schedule <- function(id) {
    call_hue("delete", paste("schedules", id, sep = "/"))
}
