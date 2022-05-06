
test_api_wrapper(
    "create_resourcelink", list(a = 1),
    "post", "resourcelinks", list(a = 1)
)

test_api_wrapper(
    "get_resourcelinks", list(),
    "get", "resourcelinks"
)

test_api_wrapper(
    "get_resourcelink", list("i"),
    "get", "resourcelinks/i"
)

test_api_wrapper(
    "set_resourcelink_attributes", list("i", a = 1),
    "put", "resourcelinks/i", list(a = 1)
)

test_api_wrapper(
    "delete_resourcelink", list("i"),
    "delete", "resourcelinks/i"
)
