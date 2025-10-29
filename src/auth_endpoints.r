library(httr2)
library(jsonlite)

# todo: fix x-auth-token 403 error
# used in: user info, dataset, dataset info, data dict
auth_get_request <- function(endpoint, api_key) {
  response <- request(endpoint) |>
    req_headers("x-auth-token" = api_key) |>
    req_perform()

  res_status_code <- resp_status(response)
  if (res_status_code != 200) {
    stop(paste("Error, request returned status code:", res_status_code))
  }

  resp_body_string(response) |>
    fromJSON()
}
