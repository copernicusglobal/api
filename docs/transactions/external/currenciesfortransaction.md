# Retrieving list of currencies for a transaction

This function allows to retrieve a list of all currencies which are available for a required external transaction.
This list of currencies can be specific for each transaction type.

### REQUEST:
       GET     /api/v1/currencies/:type
### ARGUMENTS:
       type = 'fromcard" (to deposit money from a card), "tocard" (to send money to a card) or "toaccount" (to send money
       to a bank account).
### EXAMPLE:

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/currencies/fromcard
```

### RESPONSE:

```javascript
 [
    {"description": "USD", "value": "USD"}, {"description": "EUR", "value": "EUR"}
 ]
```

The specified values should be used as the **related\_currency** attribute in transaction operations.
