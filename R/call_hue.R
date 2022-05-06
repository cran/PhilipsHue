
call_hue <- function(
    method = c("get", "post", "put", "delete"),
    url,
    body,
    encode = c("json", "form")
) {

    # Check arguments
    method <- match.arg(method)

    # Check auth
    if (!has_local_auth()) {
        stop('Unable to find authentication parameters. See vignette("local_authentication")')
    }

    # Initialize call args
    call_args <- list()

    # Prepare URL
    if (!hasArg("url")) url <- ""

    call_args$url <- sprintf(
        "http://%s/api/%s/%s",
        Sys.getenv("PHILIPS_HUE_BRIDGE_IP"),
        Sys.getenv("PHILIPS_HUE_BRIDGE_USERNAME"),
        paste(url, collapse = "/")
    )

    # Prepare body
    if (!method %in% "get" && hasArg("body")) {
        call_args$body <- body
        call_args$encode <- match.arg(encode)
    }

    # Make call
    res <- do.call(toupper(method), call_args, envir = pkgload::ns_env("httr"))

    # Parse and return
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
            simple_success <- (
                length(res_content) > 0 &&
                tryCatch(
                    all(map_lgl(
                        res_content,
                        function(x) identical(names(x), "success")
                    )),
                    error = function(e) FALSE
                )
            )

            if (simple_success) {
                if (
                    length(res_content) == 1 &&
                    identical(names(res_content[[1]]$success), "id")
                ) {
                    return(res_content[[1]]$success$id)
                } else {
                    return(TRUE)
                }
            } else {
                return(res_content)
            }
        }
    } else {
        stop("API request faild with status code: ", res_status, ":\n", as.yaml(res_content))
    }
}
