source("./src/env_var.r")

# import existing
test_api_key <- import_api_key(envfile = ".env", key = "API_KEY")
print(test_api_key)

# create new & fetch
test_value <- "temp"
create_env_file(value = test_value)

test_api_key <- import_api_key()

if (test_api_key == test_value) {
  print("Pass")
} else {
  stop("Fail")
}
