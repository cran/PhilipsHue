
describe("create_resourcelink()", {
    it("returns the new ID", {
        defer(delete_test_resources())

        delete_test_resources()
        expect_false("test resourcelink" %in% get_resourcelink_names())
        test_resourcelink_id <- create_test_resourcelink()
        expect_true("test resourcelink" %in% get_resourcelink_names())
        expect_identical(get_resourcelink(test_resourcelink_id)$name, "test resourcelink")
    })
})

describe("get_resourcelinks()", {
    it("returns a list", {
        get_resourcelinks() |>
        expect_type("list")
        # map(names) |>
        # reduce(intersect) |>
        # expect_identical(RESOURCELINK_ATTRIBUTES_NAMES)
    })
})

describe("get_resourcelink()", {
    it("returns a list", {
        defer(delete_test_resources())

        expect_true(all(RESOURCELINK_ATTRIBUTES_NAMES %in% names(get_resourcelink(create_test_resourcelink()))))
    })
})

describe("set_resourcelink_attributes()", {
    it("returns TRUE", {
        defer(delete_test_resources())
        test_resourcelink_id <- create_test_resourcelink()

        test_resourcelink_id |>
        set_resourcelink_attributes(name = "renamed test resourcelink") |>
        expect_true()

        get_resourcelink(test_resourcelink_id)$name |>
        expect_identical("renamed test resourcelink")
    })
})

describe("delete_resourcelink()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        delete_test_resources()
        test_resourcelink_id <- create_test_resourcelink()
        expect_true("test resourcelink" %in% get_resourcelink_names())
        expect_true(delete_resourcelink(test_resourcelink_id))
        expect_false("test resourcelink" %in% get_resourcelink_names())
    })
})
