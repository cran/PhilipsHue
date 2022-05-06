
describe("search_for_new_lights()", {
    it("returns TRUE", {
        while (get_new_lights()$lastscan == "active") Sys.sleep(2)
        expect_false(get_new_lights()$lastscan == "active")
        expect_true(search_for_new_lights())
        expect_true(get_new_lights()$lastscan == "active")
    })
})

describe("get_new_lights()", {
    it("returns a list", {
        expect_identical(get_new_lights(), list(lastscan = "active"))
    })
})

describe("get_lights()", {
    it("returns a list", {
        get_lights() |>
        map(names) |>
        reduce(intersect) |>
        expect_identical(LIGHT_ATTRIBUTES_NAMES)
    })
})

describe("get_light()", {
    it("returns a list", {
        light_id <- sample(names(get_light_names()), 1)

        expect_true(
            all(LIGHT_ATTRIBUTES_NAMES %in% names(get_light(light_id)))
        )
    })
})

describe("rename_light()", {
    it("returns TRUE", {
        light_id <- sample(names(get_light_names()), 1)
        light_name <- get_light(light_id)$name
        defer(rename_light(light_id, light_name))

        expect_true(rename_light(light_id, "renamed light"))
        expect_identical(get_light(light_id)$name, "renamed light")
        expect_true(rename_light(light_id, light_name))
        expect_identical(get_light(light_id)$name, light_name)
    })
})

describe("set_light_state()", {
    it("returns TRUE", {
        light_id <- get_lights() |>
            keep(~ .$state$on) |>
            sample(1) |>
            names()


        expect_true(get_light(light_id)$state$on)
        bri <- get_light(light_id)$state$bri
        expect_true(bri < 254)
        expect_true(set_light_state(light_id, bri_inc = 1))
        expect_equal(get_light(light_id)$state$bri, bri + 1)
        expect_true(set_light_state(light_id, bri_inc = -1))
        expect_equal(get_light(light_id)$state$bri, bri)
    })
})

describe("delete_light()", {
    it("returns TRUE")
})
