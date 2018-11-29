# Details of Transaction

Returns the details of a certain transaction. 

### REQUEST:
```
    GET     /api/v1/transactions/:id
```
### ARGUMENTS:
       id - the identifier of the transaction
### EXAMPLE:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/transactions/1234567
```

### RESPONSE:
```javascript
[
  {  "created":"2015-05-13T12:19:17.512+0000",
     "id": 1234567, 
     "details":"Invoce # 2332",
     "amount": 5.00000,
     "account": { 
                   "description":"Current",
                   "id":4750,
                   "type":"Common"
                },
     "contact":"79122437136", 
     "contact_type":"Phone",
     "state":"Cancelled", 
     "direction":0,
     "modified": "2015-03-16T11:00:12.375+0000",
     "state_changed": "2015-05-13T14:36:53.270+0000"
  }
]
```

The fields in the provided transaction model are the same as for lists of transactions,
([see completed transaction model](../models/transaction.md)).
