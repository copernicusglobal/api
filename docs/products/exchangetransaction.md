# Creating new exchange transaction

Creates a new transaction from the JSON model. The operations looks very similar to the creation of ordinal transaction.
But in the case of exchange transaction we need to provide both source and target accounts in the transaction. 

A list of accounts available for the current customer can be obtained by [Accounts query](./accounts.md). 
Also you need to specify the transaction\_type field to be "Transfer".

### REQUEST:

       POST     /api/v1/transactions
       
### ARGUMENTS:
       
       Request body: { "transaction_type" : "Transfer", 
                       "account" : {"id" : ... }, "related_account" : { "id" : ... } , 
                       "amount" : ..., "related_amount" : ...  }

### EXAMPLE

```bash
TOKEN="your access token here"
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" 
     -d '{"transaction_type":"Transfer", "account" : {"id" : 650650}, "related_account" : {"id" : 935450} }' https://testapi.copernicusgold.com/api/v1/transactions
```
 
### RESPONSE:

```javascript
{
    "account": { "currency": { "description": "USD", "value": "USD" },  "id": 650650 },
    "code": 0,
    "created": "2015-08-03T07:35:25.270+0000",
    "details": "Transfer between accounts",
    "direction": 0,
    "id": 935552,
    "modified": "2015-08-03T07:35:25.274+0000",
    "related_account": { "currency": { "description": "EUR", "value": "EUR" }, "id": 935450 },
    "state": "New",
    "state_changed": "2015-08-03T07:35:25.270+0000",
    "transaction_type": "Transfer"
}
```

The fields in the provided transaction model are mostly the same as for lists of transactions (see [Transactions](../transactions/transactions.md)).
But also the 'Transfer' transactions  contain the field "transaction_type" to be equal to "Transfer" and 
the "related_account" field with information about the second account used in a transfer.


# Editing Exchange Transaction

This method works for a transaction in the 'New' or 'Draft' state with the "Transfer" "transaction_type". 
Mostly all transaction fields are exactly the same as in the case of editing a "Default" transaction
but the transaction model also contains the fields connected with other side of transaction like "related\_account", "related\_amount".

In the case when the currencies of the accounts in the transaction are different we need to calculate the related\_amount
field using the [Exchange Rate function](./rates.md).

For example, if you have two accounts in the USD (source) and EUR (target) currencies and you need to convert 100 USD
to some EUR value, you should perform the ['api/v1/rates'](./rates.md) operation specifying the the source_code in USD,
the target_code as EUR and the source_amount to be 100. 

As the response you will get the target_value field with amount of converted currency (in EUR). Then you should use 
these calculated values as the amount and related\_amount fields respectively.
 
In case of changing the current exchange rate you will get a validation message when performing the validation procedure
(Http 400, Bad Request error).

In this situation you should recalculate the amounts and perform the validation again.

### REQUEST:

       PUT  /api/v1/transactions
       
### ARGUMENTS:
       Request body: 
            { "id", "...",  "amount" : "...", "related_amount" : "...", "account" : "...", "related_account" : "..." }.  
               id - an obligate field

### EXAMPLE:

```bash               
TOKEN="your access token here"
curl -X PUT -H "Authorization: Bearer $TOKEN" -d '{"id" : "3455", "amount":"5.003","related_amount" : 100.00}' https://testapi.copernicusgold.com/api/v1/transactions
```
 
### RESPONSE:

```javascript
{
    "account": { "currency": { "description": "USD", "value": "USD" }, "id": 650650 },
    "amount": 3.0,
    "code": 0,
    "created": "2015-08-03T07:35:25.270+0000",
    "details": "Transfer between accounts",
    "direction": 0,
    "id": 3455,
    "modified": "2015-08-03T08:28:26.516+0000",
    "related_account": { "currency": { "description": "EUR", "value": "EUR" }, "id": 935450 },
    "related_amount": 100.0,
    "state": "Draft",
    "state_changed": "2015-08-03T09:28:37.232+0000",
    "transaction_type": "Transfer"
}
```

The fields in the provided transaction model are the same as for lists of transactions. 