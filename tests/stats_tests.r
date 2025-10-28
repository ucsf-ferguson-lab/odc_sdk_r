source("./src/public_endpoints.r")

# test abstracted function
abstracted_res <- stats_labs()

print(head(abstracted_res), length(abstracted_res))

# test wrapper function (advanced users)
subroute <- "downloads"
subroute_res <- get_wrapper(subroute)

print(head(subroute_res), length(subroute_res))
