# List of Completed Transactions

Returns a list of completed transactions available for the current customer.

### REQUEST:
       GET     /api/v1/transactions
### ARGUMENTS:
       
       Additional request parameters can be used for paging transactions in the list:
       
       page - number of current page
       per_page - number of items in the page

### EXAMPLE:

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/transactions?page=0&per_page=5
```

### RESPONSE:

```javascript
[
  {  "created":"2015-05-13T12:19:17.512+0000",
     "id":12301, 
     "details":"Invoce # 2332",
     "amount": 5.00000,
     "account": { 
                   "description":"Current",
                   "id":4750,
                   "type":"Common"
                },
     "contact":"7 912 2437136", 
     "contact_type":"Phone",
     "state":"Cancelled", 
     "direction":0,
     "modified": "2015-03-18T07:45:24.806+0000",
     "state_changed": "2015-03-18T07:45:24.797+0000"
  },
  {  "created":"2015-03-18T15:46:04.160+0000",
     "id":6400,
     "details":"Money transfer",
     "amount":23.01000,
     "account": {
                  "description":"Current",
                  "id":4750,
                  "type":"Common"
                },
     "contact":"alexey.p.romanchuk@gmail.com", 
     "contact_type":"Email",
     "state":"Completed", 
     "direction":1,
     "modified": "2015-03-16T11:00:12.375+0000"
   }
]
```

It's a list of transaction models each contains a set of fields. The transaction models fields:

- **id** - the unique identifier of a transaction
- **created** - exact time of creation of the transaction and **modified** - the time of latest modifications
- **details** - information about this money transfer (like 'the payment purpose')
- **amount** - amount of money to be sent or received
- **account** - details of own account used in the transaction
- **contact** - an address where you send or from where receive the money, **contact_type** - type of the address (Phone, Email)
- **state** - a status of the transaction (**Completed, Cancelled**) and **state_changed** - the time when the current state was set
- **direction** - a direction of money sending (0 - for the outgoing transactions, 1 - for the incoming)
