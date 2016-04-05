# Validating a transaction

Changes the transaction's state to the 'Validate' one and performs checking the fields of the transaction according to
its type.

This method allows to change the transaction's state, if it is in the **Draft** state.
For other states an error will be generated ("Transaction state is invalid").

### REQUEST:
       PUT     /api/v1/transactions/:id/validate
### ARGUMENTS:
       id - is an obligate field passed as a part of the url.
```
       The request body: {"id": ..., ... } 
```
### EXAMPLE:

```bash
TOKEN="your access token here"
MODEL='{"id" : 4350, ... }
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/transactions/4350/validate
```

### RESPONSE:
```javascript
{
  "created":"2015-05-13T12:19:17.512+0000",
  "id":4851, 
  "details":"Invoce # 2433",
  "amount": 5.003,
  "account": { 
              "description":"Current",
              "id":4750,
              "type":"Common"
              },
  "contact":"79122437136", 
  "contact_type":"Phone",
  "state":"Validate", 
  "state_changed": "2015-03-18T07:48:27.729+0000",
  "direction":0,
  "modified": "2015-05-13T14:36:53.280+0000"
}
```

All the fields are the same as for others transaction requests.
