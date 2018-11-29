# Number of Uncompleted transactions

Returns a number of **uncompleted** transactions for the current customer.

### REQUEST:
```
    GET     /api/v1/transactions/notcompleted/count
```
### ARGUMENTS:
       none
### EXAMPLE:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/transactions/notcompleted/count
```
### RESPONSE:

```
2
```

The result is just a number.
