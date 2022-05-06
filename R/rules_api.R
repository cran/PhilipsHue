
#' Hue API: `rules` endpoints
#'
#' @param id ID of a specific rule
#' @param name name to assign to the rule
#' @param conditions a list of conditions (e.g. the result of a call to
#'   [condition()] )
#' @param actions a list of actions (e.g. the result of a call to
#'   [action()] )
#'
#' @return Requests that create resources return the ID of the newly created
#'   item, requests with side effects return `TRUE` upon success, and GET
#'   requests return the response content, parsed into a list.
#'
#' @seealso <https://developers.meethue.com/develop/hue-api/6-rules-api/>
#'
#' @name rules

#' @rdname rules
#' @export
create_rule <- function(name, conditions, actions) {
    call_hue(
        "post",
        "rules",
        list(name = name, conditions = conditions, actions = actions)
    )
}

#' @rdname rules
#' @export
get_rules <- function() {
    call_hue("get", "rules")
}

#' @rdname rules
#' @export
get_rule <- function(id) {
    call_hue("get", paste("rules", id, sep = "/"))
}

#' @rdname rules
#' @export
set_rule_attributes <- function(id, name, conditions, actions) {
    body <- list()
    if (hasArg(name)) body$name <- name
    if (hasArg(conditions)) body$conditions <- conditions
    if (hasArg(actions)) body$actions <- actions
    call_hue("put", paste("rules", id, sep = "/"), body)
}

#' @rdname rules
#' @export
delete_rule <- function(id) {
    call_hue("delete", paste("rules", id, sep = "/"))
}

#' Rule Helpers
#'
#' Defining rules can become quite verbose, and it can be tricky to prepare the
#' proper list structure for the POST or PUT request. These functions simplify
#' things a bit and provide a leaner, more semantic interface.
#'
#' @param address path to attribute or resource
#' @param operator one of: eq, gt, lt, dx, ddx, stable, not stable, in, not in
#' @param value the value a condition will compare against
#' @param method the HTTP method used to send the body to the given address
#' @param ... named parameters to include in action body
#'
#' @return Returns a list-like structure suitable for [create_rule()]
#'   or [set_rule_attributes()].
#'
#' @name rule_helpers

#' @rdname rule_helpers
#' @export
condition <- function(address, operator, value) {
    y <- list(address = address, operator = operator)
    if (hasArg(value)) y$value <- as.character(value)
    return(y)
}


#' @rdname rule_helpers
#' @export
action <- function(address, method, ...) {
    list(address = address, method = method, body = list(...))
}
