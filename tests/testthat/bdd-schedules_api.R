
describe("create_schedule()", {
    it("returns the new ID", {
        defer(delete_test_resources())

        delete_test_resources()
        expect_false("test schedule" %in% get_schedule_names())
        test_schedule_id <- create_test_schedule()
        expect_true("test schedule" %in% get_schedule_names())
        expect_identical(get_schedule(test_schedule_id)$name, "test schedule")
    })
})

describe("get_schedules()", {
    it("returns a list", {
        defer(delete_test_resources())
        test_schedule_id <- create_test_schedule()

        get_schedules() |>
        map(names) |>
        reduce(intersect) |>
        expect_identical(SCHEDULE_ATTRIBUTES_NAMES)
    })
})

describe("get_schedule()", {
    it("returns a list", {
        defer(delete_test_resources())

        expect_true(all(SCHEDULE_ATTRIBUTES_NAMES %in% names(get_schedule(create_test_schedule()))))
    })
})

describe("set_schedule_attributes()", {
    it("returns TRUE", {
        defer(delete_test_resources())
        test_schedule_id <- create_test_schedule()

        test_schedule_id |>
        set_schedule_attributes(name = "renamed test schedule") |>
        expect_true()

        get_schedule(test_schedule_id)$name |>
        expect_identical("renamed test schedule")
    })
})

describe("delete_schedule()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        delete_test_resources()
        test_schedule_id <- create_test_schedule()
        expect_true("test schedule" %in% get_schedule_names())
        expect_true(delete_schedule(test_schedule_id))
        expect_false("test schedule" %in% get_schedule_names())
    })
})
