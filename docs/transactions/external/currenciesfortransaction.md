# Retrieving the list of currencies for transactions

This function allows to retrieve the list of all the currencies which are available for the particular
external transaction. This list of currencies can be specific for each transaction type.

### REQUEST:
```
    GET /api/v1/currencies/:type
```    
### ARGUMENTS:
       type = 'fromcard" (to deposit funds from cards), "tocard" (to send funds to cards) or "toaccount" (to send
       funds to bank accounts).
### EXAMPLE:

```bash
   curl -X GET -H "Accept: application/json" \
               -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/currencies/fromcard
```

### RESPONSE:

```javascript
[
{
    "scale": 2,
    "description": "Singapore Dollar",
    "state": "Active",
    "asset_id": "SGD",
    "asset_code": "SGD",
    "kind": "Currency",
    "value": "SGD"
  },
  {
    "scale": 2,
    "description": "US Dollar",
    "state": "Active",
    "asset_id": "USD",
    "asset_code": "USD",
    "kind": "Currency",
    "value": "USD"
  }
]
```

The specified values should be used as the **related\_currency** attribute in transaction operations.
