# Accounts

Returns a list of accounts of the current customer with their balances, types and other information.

### REQUEST:
       GET     /api/v1/accounts
### ARGUMENTS:
       none
### EXAMPLES:

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/accounts
```

### RESPONSE:
```javascript
{
    "code"   : 0,
    "account":
        [
          { "description":"Current", "id":4750,  "balance": 1117.97000, "type":"Common", 
                 "currency": {"description": "USD","value": "USD"} },
          { "description":"Deposit", "id":4751,  "balance": 120.30000,  "type":"Deposit", 
                 "currency": {"description": "AU","value": "XAU"}}
        ]
}
```

The account types require more explanation. After registration of a user the System opens a set of accounts (in USD, EUR and gold).
There are two gold accounts: with the Common and Deposit types.

The Deposit type means that the account can't be used for money sending directly to other users' accounts, just only 
to send between own accounts. But the Common account can be used for any operations.
