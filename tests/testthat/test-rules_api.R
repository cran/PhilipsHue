
test_api_wrapper(
    "create_rule", list(
        "i",
        list(condition("s", "dx")),
        list(action("g", "PUT"))),
    "post", "rules", list(
        name = "i",
        conditions = list(condition("s", "dx")),
        actions = list(action("g", "PUT"))
    )
)

test_api_wrapper(
    "get_rules", list(),
    "get", "rules"
)

test_api_wrapper(
    "get_rule", list("i"),
    "get", "rules/i"
)

test_api_wrapper( # change single attribute (actions)
    "set_rule_attributes", list("i", actions = list(action("addr", "POST"))),
    "put", "rules/i", list(actions = list(action("addr", "POST")))
)

test_api_wrapper( # change multiple attributes (name, conditions, actions)
    "set_rule_attributes",
    list(
        "i",
        "n",
        list(condition("s", "dx")),
        list(action("addr", "POST"))
    ),
    "put", "rules/i",
    list(
        name = "n",
        conditions = list(condition("s", "dx")),
        actions = list(action("addr", "POST"))
    )
)

test_api_wrapper(
    "delete_rule", list("i"),
    "delete", "rules/i"
)

test_that("condition() returns the expected list structure", {
    expect_identical(
        condition("sensor/x", "dx"),
        list(address = "sensor/x", operator = "dx")
    )

    expect_identical(
        condition("sensor/x", "eq", "42"),
        list(address = "sensor/x", operator = "eq", value = "42")
    )
})

test_that("action() returns the expected list structure", {
    expect_identical(
        action("groups/x", "PUT", on = TRUE),
        list(address = "groups/x", method = "PUT", body = list(on = TRUE))
    )

    expect_identical(
        action("groups/x", "POST"),
        list(address = "groups/x", method = "POST", body = list())
    )
})
