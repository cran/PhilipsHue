
#' Hue API: `sensors` endpoints
#'
#' @param id ID of a specific sensor
#' @param name name to assign to the sensor
#' @param ... named parameters describing sensor state (e.g. `on = TRUE`)
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/5-sensors-api/>
#'
#' @name sensors

#' @rdname sensors
#' @export
create_sensor <- function(...) {
    call_hue("post", "sensors", list(...))
}

#' @rdname sensors
#' @export
search_for_new_sensors <- function() {
    call_hue("post", "sensors")
}

#' @rdname sensors
#' @export
get_new_sensors <- function() {
    call_hue("get", "sensors/new")
}

#' @rdname sensors
#' @export
rename_sensor <- function(id, name) {
    call_hue("put", paste("sensors", id, sep = "/"), list(name = name))
}

#' @rdname sensors
#' @export
get_sensors <- function() {
    call_hue("get", "sensors")
}

#' @rdname sensors
#' @export
get_sensor <- function(id) {
    call_hue("get", paste("sensors", id, sep = "/"))
}

#' @rdname sensors
#' @export
set_sensor_config <- function(id, ...) {
    call_hue("put", paste("sensors", id, "config", sep = "/"), list(...))
}

#' @rdname sensors
#' @export
set_sensor_state <- function(id, ...) {
    call_hue("put", paste("sensors", id, "state", sep = "/"), list(...))
}

#' @rdname sensors
#' @export
delete_sensor <- function(id) {
    call_hue("delete", paste("sensors", id, sep = "/"))
}

#' Configure Built-In Daylight Sensor
#'
#' Supported sensors for the Hue bridge include a virtual daylight sensor that
#' calculates sunrise and sunset times based on your location. This function
#' helps configure the built-in daylight sensor (`id = 1`).
#'
#' @param lat latitude (in decimal degrees). Positive north; negative south.
#' @param lon longitude (in decimal degrees). Positive east; negative west.
#' @param sunriseoffset "daylight" begins `sunriseoffset` minutes after
#'   sunrise
#' @param sunsetoffset "daylight" ends `sunsetoffset` minutes after sunset
#' @param id ID of the daylight sensor
#'
#' @return Returns `TRUE` (invisibly) upon success.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/supported-devices/#supportred-sensors>
#'
#' @export
configure_daylight_sensor <- function(lat, lon, sunriseoffset = 30, sunsetoffset = -30, id = 1) {
    set_sensor_config(
        id = id,
        lat = ifelse(
            lat < 0,
            sprintf('%03.4fS', abs(lat)),
            sprintf('%03.4fN', abs(lat))
        ),
        long = ifelse(
            lon < 0,
            sprintf('%03.4fW', abs(lon)),
            sprintf('%03.4fE', abs(lon))
        ),
        sunriseoffset = sunriseoffset,
        sunsetoffset = sunsetoffset
    )
}
