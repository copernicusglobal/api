# Accounts

Accounts are used to hold information about amount of assets you have. You can open an account using one of the supported
currencies or even using your own asset [inside of your applications](../applications/applications.md).

1. [List of all accounts](#list-of-all-accounts)
2. [Get Account Details](#get-account-details)
3. [Modifying Account Description](#modifying-account-description)
4. [Open New Account](#open-new-account)
5. [Closing Account](#closing-account)
6. [Obtaining an Encoded Address for Accounts](#obtaining-an-encoded-address-for-accounts)


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
          {
            "balance": 228.76,
            "currency": {...},
            "description": "Bucks",
            "estimated": 228.76,
            "id": 1234567,
            "state": "Active",
            "type": "Common"
          },
          {
            "balance": 2.15516
            "currency": {...}
            "description": "Golden"
            "estimated": 2.15516
            "id": 7654321
            "state": "Active"
            "type": "Common"
           }
        ]
}
```

Please refer to [the account model details](../models/account.md) to get information on the fields of the
given model.


# Get Account Details

A very simple endpoint for getting information on the given account by its ID.

### REQUEST:
```
    GET /api/v1/accounts/:id
```    
### ARGUMENTS:
       
       id - the identifier of an account
       
### EXAMPLES:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/accounts/1234567
```

### RESPONSE:
```javascript
{
    "balance": 228.76,
    "currency": {...},
    "description": "Bucks",
    "estimated": 228.76,
    "id": 1234567,
    "state": "Active",
    "type": "Common"
}
```


# Modifying Account Description

It is possible to change the description field for the account.

### REQUEST:
```
    PUT /api/v1/accounts/:id
```    
### ARGUMENTS:
       
``` {"id": ..., "description": "..." } ```
       
### EXAMPLES:

```bash
MODEL='{"id": 1234567, "description": "A new description" }'

curl -X PUT -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/accounts/1234567 \
            -d "$MODEL"
```

### RESPONSE:
```javascript
{
    "balance": 228.76,
    "currency": {...},
    "description": "A new description",
    "estimated": 228.76,
    "id": 1234567,
    "state": "Active",
    "type": "Common"
}
```


# Open New Account

There is no restriction on opening as much accounts as you need. You need to set the description of the
account, the asset identifiers (please see [the asset article](./assets.md) to learn how to get all
available currencies/assets). Also, you need to specify the type of the account,
see [the account models](../models/account.md).

### REQUEST:
```
    POST /api/v1/accounts
```    
### ARGUMENTS:
       
``` {"description": "...", "currency": {...}, "type": "..." } ```
       
### EXAMPLES:

```bash
MODEL='{"description": "Description", "currency": {"asset_id": "XAU"}, "type": "Common"}'

curl -X POST -H "Accept: application/json" \
             -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/accounts/1234567 \
             -d "$MODEL"
```

### RESPONSE:
```javascript
{
    "balance": 0.00000,
    "currency": {"asset_id": "XAU", "asset_code": "XAU", "scale": 5},
    "description": "Description",
    "estimated": 0.00000,
    "id": 1234567,
    "state": "New",
    "type": "Common"
}
```

Then you need to confirm the action. Please refer to [confirmation documentation](../confirmations.md)
for more details on how to invoke confirmations.

The example of the confirmation query for the SMS channel:

```
MODEL='{"otp": 1234, "description": "Description", "currency": {"asset_id": "XAU"}, "type": "Common"}'

curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/confirm/account/1234567 \
            -d "$MODEL"
```


# Closing Account

If you do not need some account anymore, you can close it. The only requirement - its balance must be zero.

### REQUEST:
```
    PUT /api/v1/accounts/:id/close
```    
### ARGUMENTS:
       
``` {"id" : 1234567, "close_reason": "Just a need" } ```
       
### EXAMPLES:

```bash
MODEL='{"id" : 1234567, "close_reason": "Just a need"}'

curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/accounts/1234567/close -d "$MODEL"
```

You need to always [confirm your query](../confirmations.md) by the way which depends on your
authorization channel.

The example for the confirmation via SMS:

```
MODEL='{"otp": 1234, "id" : 1234567, "close_reason": "Just a need"}'

curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/confirm/close/account/1234567 \
            -d "$MODEL"
```


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
in [creation of a transaction](../transactions/creationransaction.md).

