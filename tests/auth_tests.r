source("./src/env_var.r")
source("./src/auth_endpoints.r")

api_key <- import_api_key()
datasetid <- 1024

response <- httr::GET(
  # string concat workaround
  paste0(
    "https://services.scicrunch.io/odc/dataset/", datasetid,
    "/info/?api_key=", api_key
  ),
  httr::add_headers(
    accept = "application/json",
    "x-auth-token" = api_key
  )
)

if (response$status_code == 200) {
  print(response)
} else {
  print(response$status_code)
}
