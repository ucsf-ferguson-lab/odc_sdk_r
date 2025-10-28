library(dotenv)

# try to import api key, throw error if missing or empty
import_api_key <- function(
  envfile = "odc_sdk_generated.env", key = "ODC_API_KEY"
) {
  dotenv::load_dot_env(file = envfile)
  api_key <- Sys.getenv(key)

  if (is.null(api_key) || api_key == "") {
    stop(paste(key, "environment variable is missing or empty."))
  }

  api_key
}

# create .env file at current working directory
create_env_file <- function(
  envfile = "odc_sdk_generated.env", key = "ODC_API_KEY", value
) {
  line <- paste0(key, "=\"", value, "\"\n")
  cat(line, file = file.path(getwd(), envfile), append = TRUE)
}
