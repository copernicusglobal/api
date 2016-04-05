# Introduction

Copernicus Gold provides a very simple REST API to integrate its power to your own business application. 
This Reference Guide gives you the information about all available resources and endpoints.

## Using Access Token

After you have received an access token (see [Authentication](./authentication.md) for details) you can use it in queries.
In accordance with the [OAuth 2 specification](https://tools.ietf.org/html/rfc6749) you need to add the special authorization header.
Here is an example for it:

```bash
TOKEN="your access token here"
curl -X GET -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/users/roles
```

## Error Processing

In case of any API error the response has a status 400 (Bad request) and it includes some information about the error code,
message and description. 

For example:
```javascript
{"code": 64, "message": "A system error", "description":"You forgot to create a database"}
```

Also an appropriate http status code and JSON body are returned in the case of "Access denied" error (403 Forbidden) and "Internal server error" (500)

All successful API responses contain the code 0 (means "success").

# API Details:

1. [Creating Own Applications](./applications/applications.md)
  1. [Setting Own Fees](./applications/fees.md)
2. [User's Permissions](./roles.md)
3. [Customers](./customers.md)
4. [Customer Profiles](./profile/profiles.md)
5. [Products](./products/products.md)
  1. [Accounts](./products/accounts.md)
  2. [Currency/Asset Exchange](./products/assets.md)
  3. [Exchange Transaction](./products/exchangetransaction.md)
6. [Messages](./messages.md)

