
test_api_wrapper(
    "create_sensor", list(a = 1),
    "post", "sensors", list(a = 1)
)

test_api_wrapper(
    "search_for_new_sensors", list(),
    "post", "sensors"
)

test_api_wrapper(
    "get_new_sensors", list(),
    "get", "sensors/new"
)

test_api_wrapper(
    "rename_sensor", list("i", "n"),
    "put", "sensors/i", list(name = "n")
)

test_api_wrapper(
    "get_sensors", list(),
    "get", "sensors"
)

test_api_wrapper(
    "get_sensor", list("i"),
    "get", "sensors/i"
)

test_api_wrapper(
    "set_sensor_config", list("i", a = 1),
    "put", "sensors/i/config", list(a = 1)
)

test_api_wrapper(
    "set_sensor_state", list("i", a = 1),
    "put", "sensors/i/state", list(a = 1)
)

test_api_wrapper(
    "delete_sensor", list("i"),
    "delete", "sensors/i"
)

test_that("configure_daylight_sensor() calls set_sensor_config() as expected", {
    mock_set_sensor_config <- mock(TRUE, cycle = TRUE)
    stub(configure_daylight_sensor, "set_sensor_config", mock_set_sensor_config)

    expect_true(configure_daylight_sensor(41, 42))
    expect_args(mock_set_sensor_config, 1,
        id = 1,
        lat = "41.0000N", long = "42.0000E",
        sunriseoffset = 30, sunsetoffset = -30
    )

    expect_true(configure_daylight_sensor(-41, 42))
    expect_args(mock_set_sensor_config, 2,
        id = 1,
        lat = "41.0000S", long = "42.0000E",
        sunriseoffset = 30, sunsetoffset = -30
    )

    expect_true(configure_daylight_sensor(41, -42))
    expect_args(mock_set_sensor_config, 3,
        id = 1,
        lat = "41.0000N", long = "42.0000W",
        sunriseoffset = 30, sunsetoffset = -30
    )
})
