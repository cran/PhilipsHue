
describe("get_capabilities()", {
    it("returns a list", {
        get_capabilities() |>
        map(names) |>
        expect_snapshot()
    })
})
