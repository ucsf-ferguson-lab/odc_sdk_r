source("./src/env_var.r")
source("./src/auth_endpoints.r")

# NOTE: using non-defaults
api_key <- import_api_key(envfile = ".env", key = "API_KEY")

# user info proof of concept, visual confirm
# TODO: add asserts
user_info_res <- auth_get_request(
  url = create_full_auth_url("user/info"),
  api_key = api_key
)
print(user_info_res)
