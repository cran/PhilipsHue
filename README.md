# <a href="https://fascinatingfingers.gitlab.io/philipshue" target="_blank">Open PhilipsHue documentation site</a>

# PhilipsHue: an R client for the Philips Hue API <a href="https://fascinatingfingers.gitlab.io/philipshue"></a>

<!-- badges: start -->
[![pipeline status](https://gitlab.com/fascinatingfingers/philipshue/badges/main/pipeline.svg)](https://gitlab.com/fascinatingfingers/philipshue/-/pipelines)
[![coverage report](https://gitlab.com/fascinatingfingers/philipshue/badges/main/coverage.svg)](https://gitlab.com/fascinatingfingers/philipshue)
<!-- badges: end -->

The [Philips Hue API](https://developers.meethue.com) provides fine-grained
control over your Hue lighting system, and the PhilipsHue package for R aims to
simplify making requests to the API and processing responses. The package
provides wrappers for all V1 endpoints using local authentication; remote
authentication is not supported.

## Installation

Install directly from GitHub with:

```{r}
devtools::install_github("fascinatingfingers/PhilipsHue")
library(PhilipsHue)
```

## Getting started

To connect to your Hue Bridge, you'll need to discover the Bridge IP address and
create a `username`. See `vignette("local_authentication")` for more detailed
instructions. Once you have these values, you can use `auth_local()` to save
them as environment variables.

```{r}
auth_local(ip = "999.999.999.999", username = "<Philips Hue username>")
```

Here are some examples of what you can do once you've set your credentials.

```{r}
# # Delete and re-add all lights (Warning!)
# purrr::map_lgl(names(get_lights()), delete_light)
# search_for_new_lights()
# get_new_lights()

# Rename a light
rename_light("1", "Table lamp")

# Create a room
group_id <- create_group(
    name = "Living room",
    type = "Room",
    class = "Living room",
    lights = as.character(1:4)
)

# Define a scene
scene_id <- create_scene("Default", as.character(1:4))
purrr::map_lgl(
    as.character(1:4),
    set_scene_lightstate, scene_id = scene_id,
    on = TRUE, bri = 134, ct = 316
)

# Configure a switch to turn on the scene
sensor_id <- 42
create_rule(
    name = "Living room - Default",
    conditions = list(
        condition(sprintf("/sensors/%s/state/buttonevent", sensor_id), "eq", "1002"),
        condition(sprintf("/sensors/%s/state/lastupdated", sensor_id), "dx")
    ),
    actions = list(
        action(sprintf("/groups/%s/action", group_id), "PUT", scene = scene_id)
    )
)
```
