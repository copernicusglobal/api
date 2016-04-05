# Editing of a transaction

This method allows to change transaction fields (if it has **Draft** or **New** states) or it changes the state
of a transaction. 

Mostly the fields are the same as in the case of creation a transaction with one exception: there is the obligate
field '**id**' which identifies the transaction to modify.

Modification of the transaction works for 'New' and 'Draft' states of the transaction. If the transaction has other states,
the modification will result an error ("Transaction state is invalid").

### REQUEST:
       PUT     /api/v1/transactions
### ARGUMENTS:
```
   The request body - { "id", "...",  "amount" : "...", "details" : "...", 
                        "contact_type" : "...", "contact" : "...", "account" : {...} }
```
   id - an obligate field

### EXAMPLE:

```bash
TOKEN="your access token here"
MODEL='{"id" : "3455", "amount":"5.003","details":"Invoce # 2433","contact_type" : "Phone","contact":"79122437136"}'
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d $MODEL https://testapi.copernicusgold.com/api/v1/transactions
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
  "state":"Draft", 
  "direction":0,
  "modified": "2015-05-13T14:36:53.280+0000"
}
```

The fields in the provided transaction model are the same as for lists of transactions,
([see completed transactions](./completedtransactions.md)).
 
Each modification sets the current state of a transaction to '**Draft**'.
