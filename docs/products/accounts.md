# Accounts

Accounts are used to hold information about amount of assets you have. You can open an account in one of the supported
currencies or even use your own asset inside of your applications.

1. [List of all accounts](#list-of-all-accounts)
2. [Obtaining an Encoded Address for Accounts](#obtaining-an-encoded-address-for-accounts)

# List of all accounts

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


# Obtaining an Encoded Address for Accounts

In the case when you don't wish to provide a email address and a mobile phone number for receiving money, you can
generate a receive address for the specific account.


### REQUEST:
       GET     /api/v1/accounts/:id/address
### ARGUMENTS:
       
       id - the identifier of an account which is used as a target for receiving money.
       
### EXAMPLES:

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/accounts/4750/address
```

### RESPONSE:
```javascript
{
    "code"   : 0,
    "address": "bsBYBkhtEAa89jQFHrjRTvvZMezTYMZ46B"
}
```

After that you can specify this address value in the field 'contact' and the field 'contact_type' to be 'Address'
in [creation of a transaction](../transactions/createtransaction.md).

