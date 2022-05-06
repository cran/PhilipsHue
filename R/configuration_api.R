
#' Hue API: `configuration` endpoints
#'
#' @param ... named parameters describing configuration
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/7-configuration-api/>
#'
#' @name configs

#' @rdname configs
#' @export
get_config <- function() {
    call_hue("get", "config")
}

#' @rdname configs
#' @export
set_config_attributes <- function(...) {
    call_hue("put", "config", list(...))
}

#' Create local user
#'
#' The [create_user()] function allows you to create a user on a local Hue
#' network, but it requires pressing the button on the Hue bridge then
#' executing this command within 30 seconds. `delete_user()` is not implemented
#' because, apparently, it can only be executed through remote authentication.
#'
#' @param devicetype a string naming your app and the device it's running on;
#'   suggested format: `<application_name>#<devicename>` (e.g. `Hue#iPhone13`).
#'
#' @return Returns a list with the newly created `username` and `clientkey`
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/7-configuration-api/#create-user>
#'
#' @export
create_user <- function(devicetype) {
    has_bridge_ip <- "^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$" |>
        grepl(Sys.getenv("PHILIPS_HUE_BRIDGE_IP"))

    if (!has_bridge_ip) {
        stop("Unable to obtain bridge IP Check environment variable: PHILIPS_HUE_BRIDGE_IP")
    }

    res <- POST(
        url = sprintf("http://%s/api", Sys.getenv("PHILIPS_HUE_BRIDGE_IP")),
        body = list(devicetype = devicetype, generateclientkey = TRUE),
        encode = "json"
    )

    res_status <- tryCatch(
        status_code(res),
        error = function(e) NA
    )

    res_content <- tryCatch(
        content(res, as = "parsed", encoding = "UTF-8"),
        error = function(e) list(`content error` = as.character(e))
    )

    if (res_status %in% 200) {
        api_errors <- subset(
            res_content,
            map_lgl(res_content, function(x) {identical(names(x), "error")})
        )

        if (length(api_errors) > 0) {
            stop("API request returned errors\n", as.yaml(api_errors))
        } else {
            stopifnot(length(res_content) == 1 && names(res_content[[1]]) == "success")
            return(res_content[[1]]$success)
        }
    } else {
        stop("API request faild with status code: ", res_status, ":\n", as.yaml(res_content))
    }
}

#' @rdname configs
#' @export
get_state <- function() {
    y <- call_hue()

    for (scene in names(y$scenes)) {
        y$scenes[[scene]]$lightstates <- get_scene(scene)$lightstates
    }
    rm(scene)

    return(y)
}
