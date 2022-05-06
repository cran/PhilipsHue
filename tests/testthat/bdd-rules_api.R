
describe("create_rule()", {
    it("returns the new ID", {
        defer(delete_test_resources())

        delete_test_resources()
        expect_false("test rule" %in% get_rule_names())
        test_rule_id <- create_test_rule()
        expect_true("test rule" %in% get_rule_names())
        expect_identical(get_rule(test_rule_id)$name, "test rule")
    })
})

describe("get_rules()", {
    it("returns a list", {
        get_rules() |>
        map(names) |>
        reduce(intersect) |>
        expect_identical(RULE_ATTRIBUTES_NAMES)
    })
})

describe("get_rule()", {
    it("returns a list", {
        defer(delete_test_resources())

        expect_true(all(RULE_ATTRIBUTES_NAMES %in% names(get_rule(create_test_rule()))))
    })
})

describe("set_rule_attributes()", {
    it("returns TRUE", {
        defer(delete_test_resources())
        test_rule_id <- create_test_rule()

        test_rule_id |>
        set_rule_attributes(name = "renamed test rule") |>
        expect_true()

        get_rule(test_rule_id)$name |>
        expect_identical("renamed test rule")
    })
})

describe("delete_rule()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        delete_test_resources()
        test_rule_id <- create_test_rule()
        expect_true("test rule" %in% get_rule_names())
        expect_true(delete_rule(test_rule_id))
        expect_false("test rule" %in% get_rule_names())
    })
})
