
describe("create_scene()", {
    it("returns the new ID", {
        defer(delete_test_resources())

        delete_test_resources()
        expect_false("test scene" %in% get_scene_names())
        test_scene_id <- create_test_scene()
        expect_true("test scene" %in% get_scene_names())
        expect_identical(get_scene(test_scene_id)$name, "test scene")
    })
})

describe("create_group_scene()", {
    it("returns the new ID", {
        defer(delete_test_resources())

        delete_test_resources()
        expect_false("test scene" %in% get_scene_names())
        test_scene_id <- create_test_group_scene()
        expect_true("test scene" %in% get_scene_names())
        expect_identical(get_scene(test_scene_id)$name, "test scene")
    })
})

describe("get_scenes()", {
    it("returns a list", {
        get_scenes() |>
        map(names) |>
        reduce(intersect) |>
        expect_identical(SCENE_ATTRIBUTES_NAMES)
    })
})

describe("get_scene()", {
    it("returns a list", {
        defer(delete_test_resources())

        expect_true(all(SCENE_ATTRIBUTES_NAMES %in% names(get_scene(create_test_scene()))))
    })
})

describe("set_scene_attributes()", {
    it("returns TRUE", {
        defer(delete_test_resources())
        test_scene_id <- create_test_scene()

        test_scene_id |>
        set_scene_attributes(name = "renamed test scene") |>
        expect_true()

        get_scene(test_scene_id)$name |>
        expect_identical("renamed test scene")
    })
})

describe("set_scene_lightstate()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        test_scene_id <- create_test_scene()
        expect_true(all(map_lgl(get_scene(test_scene_id)$lightstates, "on")))
        light_id <- names(get_scene(test_scene_id)$lightstates)[[1]]
        bri <- get_scene(test_scene_id)$lightstates[[light_id]]$bri
        expect_true(bri < 254)
        expect_true(set_scene_lightstate(test_scene_id, light_id, bri = bri + 1))
        expect_equal(get_scene(test_scene_id)$lightstates[[light_id]]$bri, bri + 1)
    })
})

describe("delete_scene()", {
    it("returns TRUE", {
        defer(delete_test_resources())

        delete_test_resources()
        test_scene_id <- create_test_scene()
        expect_true("test scene" %in% get_scene_names())
        expect_true(delete_scene(test_scene_id))
        expect_false("test scene" %in% get_scene_names())
    })
})
