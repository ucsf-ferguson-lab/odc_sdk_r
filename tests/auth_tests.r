source("./src/env_var.r")
source("./src/auth_endpoints.r")

# todo: get dataset
api_key <- import_api_key()
datasetid <- 1024
endpoint <- paste0(
  "https://services.scicrunch.io/odc/dataset/", datasetid,
  "/info/?api_key=", api_key
)

response <- request(endpoint) |>
  req_headers("x-auth-token" = api_key) |>
  req_perform()

if (response$status_code == 200) {
  print(
    resp_body_string(response) |>
      fromJSON()
  )
} else {
  print(response$status_code)
}
