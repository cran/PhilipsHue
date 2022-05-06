
test_api_wrapper(
    "create_group", list(a = 1),
    "post", "groups", list(a = 1)
)

test_api_wrapper(
    "get_groups", list(),
    "get", "groups"
)

test_api_wrapper(
    "get_group", list("i"),
    "get", "groups/i"
)

test_api_wrapper(
    "set_group_attributes", list("i", a = 1),
    "put", "groups/i", list(a = 1)
)

test_api_wrapper(
    "set_group_state", list("i", a = 1),
    "put", "groups/i/action", list(a = 1)
)

test_api_wrapper(
    "delete_group", list("i"),
    "delete", "groups/i"
)
