library(httr2)
library(jsonlite)

# add api_key on call (pass by reference instead)
# TODO: consider lambda function inside auth_get_request
create_full_auth_url <- function(route_snippet) {
  paste0(
    "https://services.scicrunch.io/odc/",
    route_snippet,
    "/?api_key="
  )
}

# used in: user info, dataset, dataset info, data dict
auth_get_request <- function(url, api_key, retries = 3, delay = 10) {
  # ideal design is api_key in json body only
  # current backend duplicated api_key in query param & json body
  headers <- c(
    "x-auth-token" = api_key
  )

  # debug
  # last_error <- NULL  # nolint: commented_code_linter

  full_url <- paste0(url, api_key)
  # print(full_url) # nolint: commented_code_linter

  for (attempt in seq_len(retries)) {
    try(
      {
        # create full url with api_key as query param
        # see headers comment for ideal design notes
        response <- request(full_url) |>
          req_headers(!!!headers) |>
          req_error(is_error = function(resp) FALSE) |>
          req_perform()

        status <- resp_status(response)

        if (status == 200) {
          return(resp_body_json(response))
        }

        message(
          sprintf(
            "Attempt %s/%s failed with status %s",
            attempt,
            retries,
            status
          )
        )

        message(resp_body_string(response))
      },
      silent = TRUE
    )

    if (attempt < retries) {
      Sys.sleep(delay)
    }
  }

  stop(
    sprintf(
      "Failed to retrieve data from %s after %s attempts",
      url,
      retries
    )
  )
}
