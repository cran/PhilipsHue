
#' Hue API: `scenes` endpoints
#'
#' @param id,scene_id ID of a specific scene
#' @param light_id ID of a specific light in the scene
#' @param group_id ID of group that scene belongs to
#' @param name name to assign to the scene
#' @param lights vector of light IDs included in the scene
#' @param recycle logical indicating whether the scene can be automatically
#'   deleted by the bridge
#' @param transitiontime duration (in milliseconds) of the scene transition
#' @param ... named parameters describing scene attributes or light state
#'   (e.g. `name = "foo"`; `on = TRUE`)
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/4-scenes/>
#'
#' @name scenes

#' @rdname scenes
#' @export
create_scene <- function(name, lights, recycle = TRUE, transitiontime = 4) {
    call_hue("post", "scenes", list(
        name = name,
        lights = lights,
        recycle = recycle,
        transitiontime = transitiontime
    ))
}

#' @rdname scenes
#' @export
create_group_scene <- function(name, group_id, recycle = TRUE, transitiontime = 4) {
    call_hue("post", "scenes", list(
        name = name,
        type = "GroupScene",
        group = group_id,
        recycle = recycle,
        transitiontime = transitiontime
    ))
}

#' @rdname scenes
#' @export
get_scenes <- function() {
    call_hue("get", "scenes")
}

#' @rdname scenes
#' @export
get_scene <- function(id) {
    call_hue("get", paste("scenes", id, sep = "/"))
}

#' @rdname scenes
#' @export
set_scene_attributes <- function(id, ...) {
    call_hue("put", paste("scenes", id, sep = "/"), list(...))
}

#' @rdname scenes
#' @export
set_scene_lightstate <- function(scene_id, light_id, ...) {
    call_hue(
        "put",
        paste("scenes", scene_id, "lightstates", light_id, sep = "/"),
        list(...)
    )
}

#' @rdname scenes
#' @export
delete_scene <- function(id) {
    call_hue("delete", paste("scenes", id, sep = "/"))
}
