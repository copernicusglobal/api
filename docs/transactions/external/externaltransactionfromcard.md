# Receiving Funds from a Bank Card

The key attributes for this type of transaction are "transaction\_type", "direction" and "external_channel".
The "transaction\_type" must be specified as "External", the "external\_channel" field must be equal to "Card" 
and the "direction" should be equal to "1" (i.e. an incoming transaction).

In the case when the "related\_currency" and account's currency are not equal - the currency exchange should be used.

First of all, [see the currencies](./currenciesfortransaction.md) to obtain the list of available currencies for the
operation. This currency value must be put in the 'related\_currency' field below.

Then, use [the "/api/v1/rates"](../../products/rates.md) to get current exchange rates and the technique from 
[here](../../products/exchangetransaction.md) to fill the appropriate fields in the transaction model.

Be aware that when creating a new transaction, we do not send the sensitive card data (the card number and CVC/CVV)
to the server. [See below how we deal with that](#validating-card-transaction).

### REQUEST:

```
    POST /api/v1/transactions
```
    
### ARGUMENTS:

```javascript
{ 
    "transaction_type" : "External", 
    "external_channel" : "Card", 
    "direction" : 1, 
    "account" : { "id":"..." , ...}, 
    "amount" : "...", 
    "related_currency" : {"value" : "..."}, 
    "card":
    { 
       "card_bin": "...",
       "last_four_digits":"...",
       "cardholder_name" : "...",
       "valid_thru" : "..." 
    }
}
```

### EXAMPLE:

```bash
MODEL=' {
            "transaction_type" : "External", \
            "external_channel" : "Card", \
            "direction" : 1, \
            "account" : {"id": 1234567 }, \
            "related_currency":{"value" : "EUR"}, \
            "amount" : 100.00, \
            "card" :  \
             { \
                "card_bin" : "111111", \
                "last_four_digits":"1111", \
                "cardholder_name" : "John Smith", \
                "valid_thru" : "09/2018" \
             } \
        }'
        
curl -X POST -H "Accept: application/json"
             -H "Content-Type: application/json"
             -H "Authorization: Bearer $TOKEN" 
             -d $MODEL $API_HOST/api/v1/transactions
```

### RESPONSE:

```javascript
{
  "account": {
        "currency": {
            "description": "USD",
            "value": "USD"
        },
        "description": "Bucks",
        "id": 650650,
        "type": "Common"
    },
    "amount": 100.0,
    "card": {
        "card_bin":"411111",
        "last_four_digits":"1111",
        "cardholder_name": "John Smith",
        "valid_thru": "09/2018"
    },
    "code": 0,
    "created": "2015-08-10T03:53:28.549+0000",
    "details": "Fill or withdraw transaction",
    "direction": 1,
    "external_channel": "Card",
    "id": 1234567,
    "modified": "2015-08-10T04:23:12.126+0000",
    "related_amount": 0,
    "related_currency": {
        "description": "EUR",
        "value": "EUR"
    },
    "state": "New",
    "state_changed": "2015-08-10T04:23:12.128+0000",
    "transaction_type": "External"
}
```

The most of the fields are the same as for general transaction [see Transactions](../transactions.md). 

The expected format for the "valid_thru" field is "MM/YYYY" - the month and year of card expiration.
The same model is applied in case of editing a transaction but instead of **POST** you need to use a **PUT** request 
(in the latter you need to specify the "id" field in its transaction model).

# Validating Card Transaction

***Never send the sensitive card data (like a full PAN and CVC/CVV) to the API Server***. 

We use preliminary tokenization for these sensitive data and then we perform the card transaction using the obtained
token only.

Information about card is always stored during all successful transactions. You can retrieve a list of such cards
using [the endpoint '/api/v1/cards'](../../products/cards.md).

In the case when you would like to use an existing card from the list, you need to specify the '**id**' of the card
in the request model.

To complete a transaction we must calculate the '**encrypt_data**' value and put it in the model of request.
For information how to do that [see the link](./encryptcarddata.md).

To link a transaction with a card you need to perform the 'validation' procedure, see the example below.

### REQUEST:
```
   PUT /api/v1/transactions/:id/validate
```
### ARGUMENTS:

```
{ 
    "transaction_type" : "External", 
    "external_channel" : "Card",
    "id": ..., 
    "direction" : 1, 
    "account" : { "id":"..." , ...}, 
    "amount" : "...", 
    "related_currency" : {"value" : "..."},
    "card" : 
    { 
        "id": "...",
        "last_four_digits":"...",
        "cardholder_name" : "...",
        "valid_thru" : "...", 
        "encrypt_data" : "..." 
    }
}
```
### EXAMPLE:

```bash
MODEL='{ 
         "id": 1234567,
         "transaction_type" : "External", \
         "external_channel" : "Card",\
         "direction" : 1, \
         "account" : {"id": "1234567"}, \
         "related_currency":{"value" : "EUR"}, "amount" : 100.00,\ 
         "card" : 
            {
                "last_four_digits":"1111", \
                "cardholder_name" : "John Smith", \
                "valid_thru" : "09/18",\ 
                "encrypt_data" : "1qxZVgjVyyziayLtky9UpQ18e7DeHU2OaGKiIpzD574CKSBdsWNtRNUIQJdfrEjQBfXG5Mw5/NbfAUbXolqdSEaIvocf+rWaf+Z7+jGlabJboCQWrFW3AFapRQ9BGHMyXXEn1CZfTYgc8A+A1BS1ctuG1GADrorFcvUH958XVABUwSYkUSifkqtBSaLzKpclCUXJx5FRE2y4EdgMBMNaAytBmpXOEFQuzDfl1bRF+GrQ0CXdn+k1CazySW7FdLFvrRv6K/mV3SrUHRTVy51ztwovDDNl9Wt6dXy5Xhdc0xw+Om5RPPvrqz6J5sEMGsIdKCK3VWwrYOyqCMqFd/rFBg==$r1RSGOiE0bfNyWYHQIlYjnhjKgsD1Q1cwqyDMnpGcSAdGwvIBik4VatqauebFEKQO634arRLpmTxD1e2w+bcPIM9pKeeQ/BZj5Kd6BFBXMuK/XqLaC//RKenDGKJqFNZmf8V3mzBKDN9w30/Wj8sVjb0Lxpnnj2Hxwv7ma3Z42CE25gJN4pgG+hQj+KIkN0u+41ADNYHUNgD72pjDVTZOB5oKWOgmYNsdj+z77XVpJMUjLr2nsGBG78RaCfLcA5eTspK/cKAukLi0dlyiKDlyZbe30/9nUfcoAmJjMTvdmq2/XZX3imPvFAQAdWvOqsQ3NmHdsv6eftuXLEYBlRGm2iNNaVwZ4tAx+YBApbyG6Ucqn2ysMFNo+qUAl8="
            }
       }'
       
curl -X PUT -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $TOKEN"\ 
            -d "$MODEL" $API_HOST/api/v1/transactions/1234567/validate
```

### RESPONSE:

```javascript
{
  "account": {
        "currency": {
            "description": "USD",
            "value": "USD"
        },
        "description": "Bucks",
        "id": 1234567,
        "type": "Common"
    },
    "amount": 100.0,
    "card": {
        "last_four_digits":"1111",
        "cardholder_name": "John Smith",
        "valid_thru": "09/18"
    },
    "code": 0,
    "created": "2015-08-10T03:53:28.549+0000",
    "details": "Fill or withdraw transaction",
    "direction": 1,
    "external_channel": "Card",
    "id": 1234567,
    "modified": "2015-08-10T04:23:12.126+0000",
    "related_amount": 0,
    "related_currency": {
        "description": "EUR",
        "value": "EUR"
    },
    "state": "Validate",
    "state_changed": "2015-08-10T04:23:12.128+0000",
    "transaction_type": "External"
}
```

All further processing stages ('sign', 'retrieving', 'removing') are currently the same as in case of a general
transaction [see Transactions](../transactions.md).
