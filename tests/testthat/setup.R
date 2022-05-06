
expect_true(reset_auth())
expect_false(has_local_auth())

library(mockery)
library(withr)

test_api_wrapper <- function(function_name, args = list(), ...) {
    f <- get(function_name)

    test_that(sprintf("%s() calls call_hue() as expected", function_name), {
        mock_call_hue <- mock(TRUE)
        stub(f, "call_hue", mock_call_hue)

        expect_true(do.call(f, args))
        expect_called(mock_call_hue, 1)
        expect_args(mock_call_hue, 1, ...)
    })
}
