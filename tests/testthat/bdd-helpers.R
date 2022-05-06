
## get_*_names() ###############################################################

get_group_names <- function() map_chr(get_groups(), "name")

get_light_names <- function() map_chr(get_lights(), "name")

get_resourcelink_names <- function() map_chr(get_resourcelinks(), "name")

get_rule_names <- function() map_chr(get_rules(), "name")

get_scene_names <- function() map_chr(get_scenes(), "name")

get_schedule_names <- function() map_chr(get_schedules(), "name")

get_sensor_names <- function() map_chr(get_sensors(), "name")



## create_test_*() #############################################################

create_test_group <- function() {
    create_group(
        name = "test group",
        lights = names(sample(keep(get_lights(), ~ .$state$on), 2))
    )
}

create_test_resourcelink <- function() {
    create_resourcelink(
        name = "test resourcelink",
        classid = 42,
        links = list(sprintf("/scenes/%s", sample(names(get_scenes()), 1)))
    )
}

create_test_rule <- function() {
    create_rule(
        name = "test rule",
        list(condition("/sensors/1/state/daylight", "eq", "false")),
        list(action("/groups/0/action", "PUT", on = TRUE))
    )
}

create_test_scene <- function() {
    create_scene(
        name = "test scene",
        lights = names(sample(keep(get_lights(), ~ .$state$on), 2))
    )
}

create_test_group_scene <- function() {
    create_group_scene(
        name = "test scene",
        group = sample(names(get_groups()), 1)
    )
}

create_test_schedule <- function() {
    create_schedule(
        name = "test schedule",
        time = format(lubridate::now("UTC") + lubridate::minutes(5), "%Y-%m-%dT%H:%M:%S"),
        command = action("/groups/0/action", "PUT", on = TRUE)
    )
}

create_test_sensor <- function() {
    create_sensor(
        name = "test sensor",
        modelid = "test model ID",
        swversion = "0.9999",
        type = "CLIPGenericStatus",
        uniqueid = gsub("-", "", uuid::UUIDgenerate()),
        manufacturername = "test manufacturer name"
    )
}



## delete_test_resources() #####################################################

delete_test_resources <- function() {
    all(
        names(keep(get_groups(), ~ grepl("\\btest\\b", .$name))) |>
        map_lgl(delete_group) |>
        all(),

        names(keep(get_lights(), ~ grepl("\\btest\\b", .$name))) |>
        map_lgl(delete_light) |>
        all(),

        names(keep(get_resourcelinks(), ~ grepl("\\btest\\b", .$name))) |>
        map_lgl(delete_resourcelink) |>
        all(),

        names(keep(get_rules(), ~ grepl("\\btest\\b", .$name))) |>
        map_lgl(delete_rule) |>
        all(),

        names(keep(get_scenes(), ~ grepl("\\btest\\b", .$name))) |>
        map_lgl(delete_scene) |>
        all(),

        names(keep(get_schedules(), ~ grepl("\\btest\\b", .$name))) |>
        map_lgl(delete_schedule) |>
        all(),

        names(keep(get_sensors(), ~ grepl("\\btest\\b", .$name))) |>
        map_lgl(delete_sensor) |>
        all()
    ) |>
    expect_true()
}



## *_ATTRIBUTES_NAMES ##########################################################

GROUP_ATTRIBUTES_NAMES <- c(
    "name", "lights", "sensors", "type", "state", "recycle", "action"
)

LIGHT_ATTRIBUTES_NAMES <- c(
    "state", "swupdate", "type", "name", "modelid", "manufacturername",
    "productname", "capabilities", "config", "uniqueid", "swversion"
)

RESOURCELINK_ATTRIBUTES_NAMES <- c(
    "name", "description", "type", "classid", "owner", "recycle", "links"
)

RULE_ATTRIBUTES_NAMES <- c(
    "name", "owner", "created", "lasttriggered", "timestriggered", "status",
    "recycle", "conditions", "actions"
)

SCENE_ATTRIBUTES_NAMES <- c(
    "name", "type", "lights", "owner", "recycle", "locked", "appdata",
    "picture", "lastupdated", "version"
)

SCHEDULE_ATTRIBUTES_NAMES <- c(
    "name", "description", "command", "time", "created", "status",
    "autodelete", "recycle"
)

SENSOR_ATTRIBUTES_NAMES <- c(
    "state", "config", "name", "type", "modelid", "manufacturername", "swversion"
)
