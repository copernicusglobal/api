# Sending money to a bank card

The key attributes for this type of transaction are "transaction\_type", "direction" and "external_channel". 

The "transaction\_type" must be specified as "External", the "external_channel" field must be equal to "Card" and
the "direction" should be equal to "0" (i.e. outgoing).

In the case when the "related_currency" and account's currency are not equal - the currency exchange should be applied
([see currency exchange](../../products/exchangetransaction.md)). To obtain a valid exchange rate you need to specify
the value "ToCard" as the "product" field value in "/api/v1/rates".

### REQUEST:
       POST     /api/v1/transactions
### ARGUMENTS:
```
   The request body: { 
                        "transaction_type" : "External", 
                        "external_channel" : "Card", 
                        "direction" : 0, "account" : { "id" , ...}, "amount" : ...., 
                        "related_currency" : {"value" : "..."}, "card" : {"card_number": "..." }  }
```
### EXAMPLE:

```bash
TOKEN="your access token here"
MODEL='{ "transaction_type" : "External", "external_channel" : "Card", "direction" : 0, "account" : {"id", 650650}, \
         "related_currency":{"value" : "EUR"}, "amount" : 100.00, "card" : {"card_number" : "1111111111111111"}  }'
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d $MODEL https://testapi.copernicusgold.com/api/v1/transactions
```

The same model is applied in case of editing a transaction but instead of a **POST** you need to use a **PUT** request
and also to specify the "**id**" field in a transaction model in the body of request.

All further processing stages (validation, sign, retrieving, deletion) currently the same as in case of general
transaction ([see transactions](../transactions.md)).
