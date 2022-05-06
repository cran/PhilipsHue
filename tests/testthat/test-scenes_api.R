
test_api_wrapper(
    "create_scene", list("x", c("a", "b")),
    "post", "scenes", list(
        name = "x",
        lights = c("a", "b"),
        recycle = TRUE,
        transitiontime = 4
    )
)

test_api_wrapper(
    "create_group_scene", list("x", "a"),
    "post", "scenes", list(
        name = "x",
        type = "GroupScene",
        group = "a",
        recycle = TRUE,
        transitiontime = 4
    )
)

test_api_wrapper(
    "get_scenes", list(),
    "get", "scenes"
)

test_api_wrapper(
    "get_scene", list("i"),
    "get", "scenes/i"
)

test_api_wrapper(
    "set_scene_attributes", list("i", a = 1),
    "put", "scenes/i", list(a = 1)
)

test_api_wrapper(
    "set_scene_lightstate", list("i", "j", on = TRUE),
    "put", "scenes/i/lightstates/j", list(on = TRUE)
)

test_api_wrapper(
    "delete_scene", list("i"),
    "delete", "scenes/i"
)
