
test_that("has_local_auth() returns TRUE with proper env vars and FALSE otherwise", {
    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "0.0.0.0",
            PHILIPS_HUE_BRIDGE_USERNAME = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        ),
        expect_true(has_local_auth())
    )

    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "",
            PHILIPS_HUE_BRIDGE_USERNAME = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        ),
        expect_false(has_local_auth())
    )

    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "0.0.0.0",
            PHILIPS_HUE_BRIDGE_USERNAME = ""
        ),
        expect_false(has_local_auth())
    )

    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "invalid IP address",
            PHILIPS_HUE_BRIDGE_USERNAME = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        ),
        expect_false(has_local_auth())
    )

    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "0.0.0.0",
            PHILIPS_HUE_BRIDGE_USERNAME = "invalid username"
        ),
        expect_false(has_local_auth())
    )
})

test_that("`write_auth` writes the current enviornment variables to the specified file", {
    f <- tempfile()
    on.exit(unlink(f))

    mock_vars <- c(
        PHILIPS_HUE_BRIDGE_IP = "MOCK_BRIDGE_IP",
        PHILIPS_HUE_BRIDGE_USERNAME = "MOCK_BRIDGE_USERNAME"
    )

    expect_true(with_envvar(mock_vars, write_auth(f, append = FALSE)))
    y <- readLines(f)
    expect_length(y, length(mock_vars))
    expect_false(any(duplicated(y)))
    expect_true(all(grepl('^PHILIPS_HUE_[^= ]+="MOCK_', y)))
    expect_true(with_envvar(mock_vars, write_auth(f)))
    expect_length(readLines(f), 2 * length(mock_vars))
})

test_that("`reset_auth` resets local authentication environment variables", {
    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "MOCK_BRIDGE_IP",
            PHILIPS_HUE_BRIDGE_USERNAME = "MOCK_BRIDGE_USERNAME"
        ),
        {
            expect_equal(Sys.getenv("PHILIPS_HUE_BRIDGE_IP"), "MOCK_BRIDGE_IP")
            expect_equal(Sys.getenv("PHILIPS_HUE_BRIDGE_USERNAME"), "MOCK_BRIDGE_USERNAME")
            expect_true(reset_auth())
            expect_equal(Sys.getenv("PHILIPS_HUE_BRIDGE_IP"), "")
            expect_equal(Sys.getenv("PHILIPS_HUE_BRIDGE_USERNAME"), "")
        }
    )
})
