
skip_on_cran()
skip_on_ci()
skip_if_not(file.exists(".Renviron"))

readRenviron(".Renviron")
skip_if_not(has_local_auth())

source("bdd-helpers.R")

source("bdd-lights_api.R")
source("bdd-capabilities_api.R")
source("bdd-configuration_api.R")
source("bdd-groups_api.R")
source("bdd-resource_links_api.R")
source("bdd-rules_api.R")
source("bdd-scenes_api.R")
source("bdd-schedules_api.R")
source("bdd-sensors_api.R")
