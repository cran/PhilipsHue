
test_api_wrapper(
    "search_for_new_lights", list(),
    "post", "lights"
)

test_api_wrapper(
    "get_new_lights", list(),
    "get", "lights/new"
)

test_api_wrapper(
    "rename_light", list("i", "a"),
    "put", "lights/i", list(name = "a")
)

test_api_wrapper(
    "get_lights", list(),
    "get", "lights"
)

test_api_wrapper(
    "get_light", list("i"),
    "get", "lights/i"
)

test_api_wrapper(
    "set_light_state", list("i", a = 1),
    "put", "lights/i/state", list(a = 1)
)

test_api_wrapper(
    "delete_light", list("i"),
    "delete", "lights/i"
)
