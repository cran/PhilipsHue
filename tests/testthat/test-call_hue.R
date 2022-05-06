
library(mockery)

test_that("call_hue() throws an error when !has_local_auth()", {
    stub(call_hue, "has_local_auth", FALSE)
    expect_error(call_hue(), "Unable to find authentication parameters")
})

test_that("call_hue() creates proper requests for each HTTP verb, local auth", {
    stub(call_hue, "has_local_auth", TRUE)
    stub(call_hue, "status_code", 200)
    stub(call_hue, "content", "mock response content")

    mock_do <- mock(list(), cycle = TRUE)
    stub(call_hue, "do.call", mock_do)

    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "mock_ip",
            PHILIPS_HUE_BRIDGE_USERNAME = "mock_username"
        ), {
            expect_identical(call_hue(), "mock response content")
            expect_identical(call_hue("get"), "mock response content")
            expect_identical(call_hue("post"), "mock response content")
            expect_identical(call_hue("put"), "mock response content")
            expect_identical(call_hue("delete"), "mock response content")
        }
    )

    expect_called(mock_do, 5)

    expect_args(mock_do, 1,
        what = "GET",
        args = list(url = "http://mock_ip/api/mock_username/"),
        envir = pkgload::ns_env("httr")
    )

    expect_args(mock_do, 2,
        what = "GET",
        args = list(url = "http://mock_ip/api/mock_username/"),
        envir = pkgload::ns_env("httr")
    )

    expect_args(mock_do, 3,
        what = "POST",
        args = list(url = "http://mock_ip/api/mock_username/"),
        envir = pkgload::ns_env("httr")
    )

    expect_args(mock_do, 4,
        what = "PUT",
        args = list(url = "http://mock_ip/api/mock_username/"),
        envir = pkgload::ns_env("httr")
    )

    expect_args(mock_do, 5,
        what = "DELETE",
        args = list(url = "http://mock_ip/api/mock_username/"),
        envir = pkgload::ns_env("httr")
    )
})

test_that("call_hue() adds optional body to PUT, POST, DELETE requests", {
    stub(call_hue, "has_local_auth", TRUE)
    stub(call_hue, "status_code", 200)
    stub(call_hue, "content", "mock response content")

    mock_do <- mock(list(), cycle = TRUE)
    stub(call_hue, "do.call", mock_do)

    with_envvar(
        c(
            PHILIPS_HUE_BRIDGE_IP = "mock_ip",
            PHILIPS_HUE_BRIDGE_USERNAME = "mock_username"
        ), {
            expect_identical(call_hue("put", body = "mock body"), "mock response content")
            expect_identical(call_hue("post", body = "mock body", encode = "form"), "mock response content")
            expect_identical(call_hue("delete", body = "mock body"), "mock response content")
        }
    )

    expect_called(mock_do, 3)

    expect_args(mock_do, 1,
        what = "PUT",
        args = list(url = "http://mock_ip/api/mock_username/", body = "mock body", encode = "json"),
        envir = pkgload::ns_env("httr")
    )

    expect_args(mock_do, 2,
        what = "POST",
        args = list(url = "http://mock_ip/api/mock_username/", body = "mock body", encode = "form"),
        envir = pkgload::ns_env("httr")
    )

    expect_args(mock_do, 3,
        what = "DELETE",
        args = list(url = "http://mock_ip/api/mock_username/", body = "mock body", encode = "json"),
        envir = pkgload::ns_env("httr")
    )
})

test_that("call_hue() returns newly created IDs when present", {
    stub(call_hue, "has_local_auth", TRUE)

    mock_do <- mock("mock response")
    stub(call_hue, "do.call", mock_do)

    stub(call_hue, "status_code", 200)
    stub(call_hue, "content", list(list(success = list(id = "new_id"))))

    with_envvar(
        c(PHILIPS_HUE_BRIDGE_IP = "ip", PHILIPS_HUE_BRIDGE_USERNAME = "u"),
        y <- call_hue("post", "endpoint", body = "mock body")
    )

    expect_args(mock_do, 1,
        what = "POST",
        args = list(url = "http://ip/api/u/endpoint", body = "mock body", encode = "json"),
        envir = pkgload::ns_env("httr")
    )

    expect_equal(y, "new_id")
})
