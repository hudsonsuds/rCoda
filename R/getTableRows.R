#' Retrieves all rows from Coda table
#'
#' @param doc_id The doc id for the Coda doc (10 characters long)
#' @param table_id The table or view id to query
#' @param prod Which Coda environment to send API requests to
#' @import tidyr
#' @import dplyr
#' @export
getTableRows <- function(doc_id, table_id, bearer_token, prod=TRUE) {

  base_url <- ifelse(prod, 'https://coda.io/apis/v1/docs/', 'https://staging.coda.io/apis/v1/docs/')
  coda_url <- paste0(base_url, doc_id, '/tables/', table_id,'/rows?valueFormat=simple&useColumnNames=true')

  response <- getTableRowsHelper(coda_url, bearer_token)
  data <- response$data
  next_url <- response$next_url

  ## Paginate through any additional rows
  while(!is.null(next_url)) {
    warning("Getting more rows...")

    response <- getTableRowsHelper(next_url, bearer_token)
    data <- data %>%
      bind_rows(response$data)

    next_url <- response$next_url

  }

  return(data)
}

