# Transaction Model

Below are provided several examples of transactions:

```
{
    "total": 333,
    "id": 44467402,
    
    "state": "Completed",
    "created": "2018-11-25T13:27:43.061+0000",
    "modified": "2018-11-25T13:30:00.191+0000",
    "state_changed": "2018-11-25T13:29:41.304+0000",
    "details": "Payment for the invoice # 009-323A",
    "amount": 12034,
    "related_amount": 12034,
    
    "account": {...},
    "related_currency": {...},
    "contact": "a@copernicusgold.com",
    "related_name": "OOO \"Helios\"",
    "contact_type": "Email",
    "direction": 0,
    "transaction_type": "Default",
    "exchange_rate": 1,
    "transaction_kind": "Instant",
    "is_parent": false,
    "fee": [],
    "totals": [
      {
        "code": "Total",
        "amount": 12034,
        "currency": "EUR",
        "mode": 0
      },
      {
        "code": "TotalRelated",
        "amount": 12034,
        "currency": "EUR",
        "mode": 1
      }
    ],
    "hash": "c44d09fb9cbb230e23b1a0b2d72d02d2a9e3594bd169a040ca4e7174e59bbd92",
    "height": 2864168
  }
```

## Deposit via Bank Card

```
{
    "total": 333,
    "id": 44466800,
    "state": "Completed",
    "created": "2018-11-25T13:04:53.999+0000",
    "modified": "2018-11-25T13:10:05.318+0000",
    "state_changed": "2018-11-25T13:09:36.070+0000",
    
    "details": "Adding funds from *4242 card",
    "amount": 10000,
    "related_amount": 11355.24,
    "account": {...},
    "related_currency": {...},
    "related_name": "Alex Loh",
    "contact_type": "Phone",
    "direction": 1,
    "transaction_type": "External",
    "exchange_rate": 1.13552439,
    "card": {
      "id": 43326200,
      "state": "Active",
      "created": "2018-11-08T19:07:44.175+0000",
      "modified": "2018-11-08T19:07:45.934+0000",
      "last_four_digits": "4242",
      "valid_thru": "4/2025",
      "cardholder_name": "Alex Loh"
    },
    "external_channel": "Card",
    "transaction_kind": "Instant",
    "is_parent": false,
    "fee": [
      {
        "code": "CardInFee",
        "amount": 339.45,
        "currency": "USD",
        "mode": 1
      }
    ],
    "totals": [
      {
        "code": "Total",
        "amount": 10000,
        "currency": "EUR",
        "mode": 0
      },
      {
        "code": "TotalRelated",
        "amount": 11694.69,
        "currency": "USD",
        "mode": 1
      }
    ],
    "hash": "d3ac89c4b65a5d1f37fd58a0dd022dc197dd017007965ecac1d20225c12176b4",
    "height": 2864067
  }
```

## Conversion Between Accounts

```
{
    "total": 333,
    "id": 43780772,
    "state": "Completed",
    "created": "2018-11-15T05:27:15.056+0000",
    "modified": "2018-11-15T05:28:17.541+0000",
    "state_changed": "2018-11-15T05:28:17.478+0000",
    
    "details": "Transfer between accounts",
    "amount": 64.46,
    "related_amount": 1.89,
    "account": {...},
    "related_account": {...},
    "related_currency": {...},
    "contact": "79122437136",
    "related_name": "Romanchuk Alexey",
    "contact_type": "Phone",
    "direction": 1,
    "transaction_type": "Transfer",
    "exchange_rate": 34.10375307,
    "is_parent": false,
    "id_parent": 43780771,
    "fee": [],
    "totals": [
      {
        "code": "Total",
        "amount": 64.46,
        "currency": "EUR",
        "mode": 0
      },
      {
        "code": "TotalRelated",
        "amount": 1.89,
        "currency": "XAU",
        "mode": 1
      }
    ],
    "hash": "11bb5651bb35e41923a7b5d2e5f0ba1fa30030e6fcaf276db69c8442e69d17cd",
    "height": 2805007
}
```

## Transfer To Bank Account

```
{
    "code":0,
    "id":43286897,
    "state":"Completed",
    "created":"2018-11-08T19:19:13.528+0000",
    "modified":"2018-11-08T19:22:10.079+0000",
    "state_changed":"2018-11-08T19:21:30.606+0000",

    "details":"Bank transfer to 098043-34200 account",
    "amount":1.05807,
    "related_amount":41.33,
    "account":{...},
    "related_currency":{...},
    "direction":0,
    "transaction_type":"External",
    "exchange_rate":39.06158202,
    "bank_account":
        {
            "id":2,
            "state":"Active",
            "modified":"2018-11-08T19:20:23.515+0000",
            "state_changed":"2018-11-08T19:20:23.475+0000",
            "account_owner_name":"Romanchuk Alexey",
            "bank_code":"INSECHZZ",
            "bank_name":"SIX SIS AG",
            "account_number":"098043-34200",
            "country":{...}
        },
    "external_channel":"BankAccount",
    "transaction_kind":"Instant",
    "is_parent":false,
    "fee":[ 
            {
                "code":"BankOutFee",
                "amount":0.20000000,
                "currency":"USD",
                "mode":1
            }
          ],
    "totals":[
                {
                    "code":"Total",
                    "amount":1.05807000,
                    "currency":"XAU",
                    "mode":0
                },
                {
                    "code":"TotalRelated",
                    "amount":41.53000000,
                    "currency":"USD",
                    "mode":1
                }
          ],
    "hash":"8285133e664075d6fae71dbeafb2a9b7441f67255ac5eac399643ff9b1dd1fb0",
    "height":3269343
}
```

## Transaction To Unregistered User

```
{
    "code":0,
    "id":40873300,
    "state":"Completed",
    "created":"2018-10-06T13:26:22.431+0000",
    "modified":"2018-10-06T13:29:27.953+0000",
    "state_changed":"2018-10-06T13:29:17.780+0000",
    
    "details":"A transfer",
    "amount":1.56,
    "related_amount":1.56,
    "account":{...},
    "related_currency":{...},
    "contact":"79122400000",
    "related_name":"79122400000",
    "contact_type":"Phone",
    "direction":0,
    "transaction_type":"Unregistered",
    "exchange_rate":1.00000000,
    "transaction_kind":"Instant",
    "is_parent":false,
    "fee":[],
    "totals":[
        {"code":"Total","amount":1.56000000,"currency":"USD","mode":0},
        {"code":"TotalRelated","amount":1.56000000,"currency":"USD","mode":1}
    ],
    "hash":"62df3b3914e772fef37b91aaea519eb25e38da6f8644cc2dc892a72127ae8f46",
    "height":2641912
}
```
