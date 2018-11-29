# Canceling a Transaction

Changes the state of unconfirmed transactions to '**Cancelled**'

This method allows to change the transaction's state from **Unconfirmed** to **Cancelled**.
For other states the "Transaction state is invalid" error will be generated.

### REQUEST:
```
   PUT /api/v1/transactions/:id/cancel
```
### ARGUMENTS:
       id - is an obligate field passed as a part of the url.
### EXAMPLE:

```bash
curl -X PUT -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/transactions/1234567/cancel
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
  "state":"Cancelled", 
  "state_changed": "2015-03-18T07:48:27.729+0000",
  "direction":0,
  "modified": "2015-05-13T14:36:53.280+0000"
}
```

All the fields are the same as for others transaction requests, [see transactions](./transactions.md)
