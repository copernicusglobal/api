# Introduction

Copernicus Gold provides a very simple REST API to integrate its power to your own business application. 
This Reference Guide gives you the information about all available resources and endpoints.

## Using Access Token

After registering your [own application](./applications/registration.md) and receiving an access token 
(see [Authentication](./authentication.md) for details) you can use it in API queries.

In accordance with the [OAuth 2 specification](https://tools.ietf.org/html/rfc6749) you need to add the special authorization header.
Here is an example for it:

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/users/roles
```

## Error Processing

In case of any API error the response has a status 400 (Bad request) and it includes some information about the error code,
message and description. 

For example:
```javascript
    {"code": -1, "message": "A system error", "description":"You forgot to create a database", "error_id": "no.database.found"}
```

Also an appropriate http status code and JSON body are returned in the case of an "Access denied" error (403 Forbidden)
or "Internal server error" (500).

All successful API responses contain the **code** to be equal 0 (That means "success"). The value "-1" is mainly used
for different validation errors, the value "1" means "Just an error". The identifier "error_id" may be used to
determine an concrete error.



# API Reference:

1. [User's Permissions](./roles.md)
2. [Customers](./customers.md)
3. [Customer Profiles](./profile/profiles.md)
4. [Products](./products/products.md)
    1. [Accounts](./products/accounts.md)
    2. [Currency/Asset Exchange](./products/assets.md)
    3. [Exchange Transaction](./products/exchangetransaction.md)
5. [Money Transfer, Depositing or Withdrawing Funds](./transactions/transactions.md)  
6. [Messages](./messages.md)
7. [Creating Own Applications](./applications/applications.md)
    1. [Setting Own Fees](./applications/fees.md)
    2. [Creating Assets/Currencies](./applications/own_assets.md)
8. [Rewenable Energy API](./products/energy.md)
