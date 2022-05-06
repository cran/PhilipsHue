
describe("create_group()", {
    it("returns the new ID", {
        defer(delete_test_resources())

        delete_test_resources()
        expect_false("test group" %in% get_group_names())
        test_group_id <- create_test_group()
        expect_true("test group" %in% get_group_names())
        expect_identical(get_group(test_group_id)$name, "test group")
    })
})

describe("get_groups()", {
    it("returns a list", {
        get_groups() |>
        map(names) |>
        reduce(intersect) |>
        expect_identical(GROUP_ATTRIBUTES_NAMES)
    })
})

describe("get_group()", {
    it("returns a list", {
        defer(delete_test_resources())

        expect_true(all(GROUP_ATTRIBUTES_NAMES %in% names(get_group(create_test_group()))))
    })
})

describe("set_group_attributes()", {
    it("returns TRUE", {
        defer(delete_test_resources())
        test_group_id <- create_test_group()

        test_group_id |>
        set_group_attributes(name = "renamed test group") |>
        expect_true()

        get_group(test_group_id)$name |>
        expect_identical("renamed test group")
    })
})

describe("set_group_state()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        test_group_id <- create_test_group()
        expect_true(get_group(test_group_id)$state$all_on)
        bri <- get_group(test_group_id)$action$bri
        expect_true(bri < 254)
        expect_true(set_group_state(test_group_id, bri_inc = 1))
        expect_equal(get_group(test_group_id)$action$bri, bri + 1)
        expect_true(set_group_state(test_group_id, bri_inc = -1))
        expect_equal(get_group(test_group_id)$action$bri, bri)
    })
})

describe("delete_group()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        delete_test_resources()
        test_group_id <- create_test_group()
        expect_true("test group" %in% get_group_names())
        expect_true(delete_group(test_group_id))
        expect_false("test group" %in% get_group_names())
    })
})
