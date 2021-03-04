# rCoda

A bare bones R package to import Coda tables.

To get started...
```
library(devtools)

install_github("hudsonsuds/rCoda")

```

## Usage

1. Gather a Coda API token with the right permissions (account page)[https://coda.io/account]

2. Pass your api token, doc_id, and table_id to the `getTableRows` method
```
library(rCoda)
library(tidyr)
library(dplyr)

bearer_token <- 'add-your-token-here'
doc_id <- 'doc_id'
table_id <- 'table_id'

t <- getTableRows(doc_id, table_id, bearer_token)
```

This package doesn't do any column formating and is read-only for now.
