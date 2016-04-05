# Number of Uncompleted transactions

Returns a number of **uncompleted** transactions for the current customer.

### REQUEST:
       GET     /api/v1/transactions/notcompleted/count
### ARGUMENTS:
       none
### EXAMPLE:

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/transactions/notcompleted/count
```
### RESPONSE:

```
2
```

The result is just a number.
