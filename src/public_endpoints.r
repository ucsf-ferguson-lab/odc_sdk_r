library(httr)
library(jsonlite)

stats_raw_response <- function(endpoint) {
  response <- httr::GET(endpoint)
  res_status_code <- response$status_code

  if (res_status_code != 200) {
    stop(paste("Error, request returned status code:", res_status_code))
  }

  content <- httr::content(response, "text")
  jsonlite::fromJSON(content)
}

# call this function directly if advanced user
stats_wrapper <- function(stat_category) {
  stats_base_endpoint <- "https://services.scicrunch.io/odc/stats/"
  stats_full_endpoint <- paste(stats_base_endpoint, "datasets")

  if (stat_category == "") {
    stop("stat_category arg cannot be empty")
  }

  raw_response <- stats_raw_response(stats_full_endpoint)
  data.frame(raw_response)
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
