#' Retrieves a paginated batch of rows and returns tibble
#'
#' @param coda_url A Coda API request URL for rows
#' @param bearer_token A valid Coda API token
#' @import jsonlite
#' @import httr
#' @import tidyr
#' @import dplyr
#' @export
getTableRowsHelper <- function(coda_url, bearer_token) {

  response <- GET(coda_url, add_headers(Authorization = paste0('Bearer ', bearer_token)))

  ## Stop for errors
  if (http_type(response) != "application/json") {
    stop("API did not return json")
  }

  if (http_error(response)) {
    stop(
      sprintf(
        "Coda API request failed [%s]",
        status_code(response)
      )
    )
  }

  response.content <- fromJSON(content(response, "text"), simplifyVector = FALSE)

  data.rows <- tibble(row = response.content$items) %>%
    unnest_wider(row) %>%
    unnest_wider(values)

  return(list(data=data.rows, next_url=response.content$nextPageLink))
}
