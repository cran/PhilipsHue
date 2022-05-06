
test_api_wrapper(
    "get_config", list(),
    "get", "config"
)

test_api_wrapper(
    "set_config_attributes", list(a = 1),
    "put", "config", list(a = 1)
)

test_that("create_user() throws an error if the bridge IP env var isn't set", {
    expect_error(
        with_envvar(c(PHILIPS_HUE_BRIDGE_IP = ""), create_user("u")),
        "[Cc]heck environment variable.+PHILIPS_HUE_BRIDGE_IP"
    )
})

test_that("create_user() returns the new ID upon success", {
    mock_post <- mock("mock POST response")
    stub(create_user, "POST", mock_post)

    stub(create_user, "status_code", 200)

    mock_content <- mock(list(list(success = "new ID")))
    stub(create_user, "content", mock_content)

    expect_equal(
        with_envvar(c(PHILIPS_HUE_BRIDGE_IP = "0.0.0.0"), create_user("u")),
        "new ID"
    )

    expect_args(mock_post, 1,
        url = "http://0.0.0.0/api",
        body = list(devicetype = "u", generateclientkey = TRUE),
        encode = "json"
    )

    expect_args(mock_content, 1,
        "mock POST response",
        as = "parsed",
        encoding = "UTF-8"
    )
})

test_that("get_state() calls call_hue() as expected then recursively calls get_scene()", {
    mock_call_hue <- mock(list(scenes = list(a = list(), b = list())))
    stub(get_state, "call_hue", mock_call_hue)

    mock_get_scene <- mock(list(lightstates = list(a = 1)), cycle = TRUE)
    stub(get_state, "get_scene", mock_get_scene)

    expect_identical(
        get_state(),
        list(scenes = list(
            a = list(lightstates = list(a = 1)),
            b = list(lightstates = list(a = 1))
        ))
    )
    expect_called(mock_call_hue, 1)
    expect_args(mock_call_hue, 1)
    expect_called(mock_get_scene, 2)
    expect_args(mock_get_scene, 1, "a")
    expect_args(mock_get_scene, 2, "b")
})
