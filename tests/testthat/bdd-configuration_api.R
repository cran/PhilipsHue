
describe("get_config()", {
    it("returns a list", {
        get_config() |>
        names() |>
        expect_identical(c(
            "name",
            "zigbeechannel",
            "bridgeid",
            "mac",
            "dhcp",
            "ipaddress",
            "netmask",
            "gateway",
            "proxyaddress",
            "proxyport",
            "UTC",
            "localtime",
            "timezone",
            "modelid",
            "datastoreversion",
            "swversion",
            "apiversion",
            "swupdate",
            "swupdate2",
            "linkbutton",
            "portalservices",
            "portalconnection",
            "portalstate",
            "internetservices",
            "factorynew",
            "replacesbridgeid",
            "backup",
            "starterkitid",
            "whitelist"
        ))
    })
})

describe("set_config_attributes()", {
    it("returns TRUE")
})

describe("get_state()", {
    it("returns a list", {
        get_state() |>
        names() |>
        expect_identical(c(
            "lights",
            "groups",
            "config",
            "schedules",
            "scenes",
            "rules",
            "sensors",
            "resourcelinks"
        ))
    })
})
