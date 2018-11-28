# Accounts

Accounts are used to hold information about amount of assets you have. You can open an account using one of the supported
currencies or even using your own asset [inside of your applications](../applications/applications.md).

1. [List of all accounts](#list-of-all-accounts)
2. [Obtaining an Encoded Address for Accounts](#obtaining-an-encoded-address-for-accounts)

# List of all accounts

Returns a list of accounts of the current customer with their balances, types and other information.

### REQUEST:
```
   GET /api/v1/accounts
```
### ARGUMENTS:
       none
### EXAMPLES:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/accounts
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
                 "currency": {"description": "Gold","value": "XAU"}}
        ]
}
```

The account types require more explanation. The Deposit type means that the account can't be used for
sending funds directly to other users' accounts, just only to send between own accounts. 

The Common account can be used for any operations.


# Obtaining an Encoded Address for Accounts

In the case when you don't wish to provide a email address and a mobile phone number for receiving money, you can
generate a receive address for the specific account.


### REQUEST:
```
    GET /api/v1/accounts/:id/address
```    
### ARGUMENTS:
       
       id - the identifier of an account which is used as a target for receiving money.
       
### EXAMPLES:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/accounts/4750/address
```

### RESPONSE:
```javascript
{
    "code"   : 0,
    "address": "bsBYBkhtEAa89jQFHrjRTvvZMezTYMZ46B"
}
```

After that you can specify this address value in the field 'contact' and the field 'contact_type' to be 'Address'
in [creation of a transaction](../transactions/createtionransaction.md).

