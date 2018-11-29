# Creating a New Transaction

Creates a new transaction by the specified model.

### REQUEST:
```
    POST /api/v1/transactions
```    

### ARGUMENTS:
```
{ 
    "amount" : "...", 
    "details" : "...", 
    "contact_type" : "...", 
    "contact" : "...", 
    "account" : "..."
}
```
### EXAMPLE:

```bash
MODEL='{ \
        "amount":"5.003",\
        "details":"Invoce # 2433",\
        "contact_type" : "Phone",\
        "contact":"79122437136" \
        "account": {"id": 4750}}'
       
curl -X POST -H "Accept: application/json" \
             -H "Content-Type: application/json" \
             -H "Authorization: Bearer $TOKEN" \
             -d $MODEL $API_HOST/api/v1/transactions
```

### RESPONSE:
```javascript
{
  "created":"2015-05-13T12:19:17.512+0000",
  "id": 1234567,
  "details":"Invoce # 2433",
  "amount": 5.003,
  "account": {
              "description":"Current",
              "id": 1234567,
              "type":"Common"
              },
  "contact":"79122400000", 
  "contact_type":"Phone",
  "state":"New", 
  "direction":0
}
```

The fields in the provided transaction model are the same as for lists of transactions,
([see transaction model examples](../models/transaction.md)).

There is an ability to specify for the 'contact_type' field the value 'Address' (not only 'Phone' or 'Email'). In this
case you need to provide an address for the target account
(see [using addresses](../products/accounts.md#obtaining-an-encoded-address-for-accounts) for details).
