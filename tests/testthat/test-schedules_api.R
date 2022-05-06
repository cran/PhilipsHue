
test_api_wrapper(
    "create_schedule", list(a = 1),
    "post", "schedules", list(a = 1)
)

test_api_wrapper(
    "get_schedules", list(),
    "get", "schedules"
)

test_api_wrapper(
    "get_schedule", list("i"),
    "get", "schedules/i"
)

test_api_wrapper(
    "set_schedule_attributes", list("i", a = 1),
    "put", "schedules/i", list(a = 1)
)

test_api_wrapper(
    "delete_schedule", list("i"),
    "delete", "schedules/i"
)
