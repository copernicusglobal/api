# Signing a transaction

Queries a user to approve a transaction.

First of all, this method changes the state of a transaction to '**Unconfirmed**' and sends a USSD query to the user's
mobile phone or an SMS (please see [the confirmation section](../confirmations.md)). 

### REQUEST:
       PUT     /api/v1/transactions/:id/sign
### ARGUMENTS:
       id - is an mandatory field passed as a part of the url.
### EXAMPLE:

```bash
MODEL='{...}'
curl -X PUT -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/transactions/123456/sign -d "$MODEL"
```

### RESPONSE:
```javascript
{
  "created":"2015-05-13T12:19:17.512+0000",
  "id":1234567, 
  "details":"Invoce # 2433",
  "amount": 5.003,
  "account": { 
              "description":"Current",
              "id":4750,
              "type":"Common"
              },
  "contact":"79122437136", 
  "contact_type":"Phone",
  "state":"Unconfirmed", 
  "state_changed": "2015-03-18T07:48:27.729+0000",
  "direction":0,
  "modified": "2015-05-13T14:36:53.280+0000"
}
```

The fields in the provided transaction model are the same as for lists of transactions,
([see transaction models](../models/transaction.md)).
