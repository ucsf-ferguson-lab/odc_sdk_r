library(httr2)
library(jsonlite)

with_retries <- function(expr, times, wait_sec) {
  attempt <- 1
  repeat {
    ok <- TRUE
    result <- tryCatch(
      expr,
      error = function(e) {
        ok <<- FALSE
        if (attempt >= times) stop(e)
        message(
          "Request failed (attempt ", attempt, "/", times,
          "). Retrying in ", wait_sec, " seconds..."
        )
        Sys.sleep(wait_sec)
        NULL
      }
    )
    if (ok) {
      return(result)
    }
    attempt <- attempt + 1
  }
}

stats_raw_response <- function(endpoint, times = 3, wait_sec = 10) {
  response <- with_retries(
    request(endpoint) |>
      req_perform(),
    times,
    wait_sec
  )

  res_status_code <- response$status_code
  if (res_status_code != 200) {
    stop(paste("Error, request returned status code:", res_status_code))
  }

  resp_body_string(response) |>
    fromJSON()
}

# call this function directly if advanced user
# retry logic abstracted away for simplicity
stats_wrapper <- function(stat_category) {
  stats_full_endpoint <- paste0(
    "https://services.scicrunch.io/odc/stats/", stat_category
  )

  if (stat_category == "") {
    stop("stat_category arg cannot be empty")
  }

  stats_raw_response(stats_full_endpoint) |>
    data.frame()
}

# added layer of abstraction to simplify things for intended user
stats_datasets <- function() {
  stats_wrapper("datasets")
}

stats_users <- function() {
  stats_wrapper("users")
}

stats_labs <- function() {
  stats_wrapper("labs")
}

stats_downloads <- function() {
  stats_wrapper("downloads")
}
