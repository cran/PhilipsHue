
describe("create_sensor()", {
    it("returns the new ID", {
        defer(delete_test_resources())

        delete_test_resources()
        expect_false("test sensor" %in% get_sensor_names())
        test_sensor_id <- create_test_sensor()
        expect_true("test sensor" %in% get_sensor_names())
        expect_identical(get_sensor(test_sensor_id)$name, "test sensor")
    })
})

describe("rename_sensor()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        sensor_id <- create_test_sensor()
        sensor_name <- get_sensor(sensor_id)$name

        expect_true(rename_sensor(sensor_id, "renamed sensor"))
        expect_identical(get_sensor(sensor_id)$name, "renamed sensor")
        expect_true(rename_sensor(sensor_id, sensor_name))
        expect_identical(get_sensor(sensor_id)$name, sensor_name)
    })
})

describe("get_sensors()", {
    it("returns a list", {
        get_sensors() |>
        map(names) |>
        reduce(intersect) |>
        expect_identical(SENSOR_ATTRIBUTES_NAMES)
    })
})

describe("get_sensor()", {
    it("returns a list", {
        sensor_id <- sample(names(get_sensor_names()), 1)

        expect_true(
            all(SENSOR_ATTRIBUTES_NAMES %in% names(get_sensor(sensor_id)))
        )
    })
})

describe("set_sensor_config()", {
    it("returns TRUE", {
        defer(delete_test_resources())
        test_sensor_id <- create_test_sensor()
        expect_true(get_sensor(test_sensor_id)$config$on)
        expect_true(set_sensor_config(test_sensor_id, on = FALSE))
        expect_false(get_sensor(test_sensor_id)$config$on)
    })
})

describe("set_sensor_state()", {
    it("returns TRUE", {
        defer(delete_test_resources())
        test_sensor_id <- create_test_sensor()
        expect_equal(get_sensor(test_sensor_id)$state$status, 0)
        expect_true(set_sensor_state(test_sensor_id, status = 42))
        expect_equal(get_sensor(test_sensor_id)$state$status, 42)
    })
})

describe("delete_sensor()", {
    it("returns TRUE")
})

describe("search_for_new_sensors()", {
    it("returns TRUE", {
        while (get_new_sensors()$lastscan == "active") Sys.sleep(2)
        expect_false(get_new_sensors()$lastscan == "active")
        expect_true(search_for_new_sensors())
        expect_true(get_new_sensors()$lastscan == "active")
    })
})

describe("get_new_sensors()", {
    it("returns a list", {
        expect_identical(get_new_sensors(), list(lastscan = "active"))
    })
})
