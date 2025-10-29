library(httr)
library(jsonlite)

# todo: fix x-auth-token 403 error
auth_get_request <- function(endpoint, api_key) {
  response <- httr::GET(
    endpoint,
    httr::add_headers(
      accept = "application/json",
      "x-auth-token" = api_key
    )
  )
  res_status_code <- response$status_code

  if (res_status_code != 200) {
    stop(paste("Error, request returned status code:", res_status_code))
  }

  content <- httr::content(response, "text")
  jsonlite::fromJSON(content)
}
