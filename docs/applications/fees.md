# Fees

Each application can set specific fees for transactions which are carried out under it. You can set your
own list of fees if you are logged as a corporate customer inside one of your application.
(see [Application](./registration.md))

More information on the fee model you can find [here](../models/fee.md)


1. [Creation of Fees](#creation-of-fees)
2. [Modifying Fees](#modifying-fees)
3. [Querying a Fee](#querying-a-fee)
4. [Removing a Fee](#removing-a-fee)
5. [Specifying an Account for Fees](#specifying-an-account-for-fees)


# Creation of Fees

To create a new fee please use the following request:

### REQUEST:
```
    POST /api/v1/fees
```    
### ARGUMENTS:

```
    {"fee_code" : "...", "algorithm" : "...", "value": "..." , "asset_id" : "..."}
```

### EXAMPLE

The example creates a new 12 USD fee for each transaction between customers.

```bash
MODEL='{"fee_code" : "Transfer", "algorithm" : "fixed", "value": 12.00 , "asset_id" : "USD"}'

curl -X POST -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/fees -d $MODEL
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "asset_id":"USD",
    "fee_code":"Transfer",
    "algorithm":"fixed",
    "value":12.00
}
```

The important field in this response is the identifier 'id' which can be used to uniquely identify the fee.
This value is used in further operations (like modifying, removing, etc.).


# Modifying Fees

You can modify all fields of a fee providing new values for the fee model. The only difference from the creation of
fees is the 'id' field in the body of the modification requests.

### REQUEST:
```
    PUT /api/v1/fees
```
### ARGUMENTS:

```
   {"fee_code" : "...", "algorithm" : "...", "value": "..." , "asset_id" : "...", 'id': 6000 }
```

### EXAMPLE

```bash
MODEL='{"fee_code" : "Transfer", "algorithm" : "percent", "value": 2 , "id" : 6000 }'

curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/fees -d $MODEL
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "fee_code":"Transfer",
    "algorithm":"percent",
    "value": 2
}
```

The example above sets the fee 2% for all transfers between two clients.


# Querying a Fee

Use this query to get details about a concrete fee.

### REQUEST:
```
    GET /api/v1/fees/:id
```    
### ARGUMENTS:

    id - the identifier of the fee

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/fees/6000
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "fee_code":"Transfer",
    "algorithm":"percent",
    "value": 2
}
```


# Removing a Fee

Use this query to remove the fee which is not required anymore.

### REQUEST:
```
    DELETE /api/v1/fees/:id
```    
### ARGUMENTS:

    id - the identifier of the fee

### EXAMPLE

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/fees/6000
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "fee_code":"Transfer",
    "algorithm":"percent",
    "value": 2
}
```

The response contains information about the deleted fee.

# Specifying an Account for Fees

By using this query you can set one of your accounts as an account for gaining fees. You can open such account
for each currency.

### REQUEST:
```
    PUT /api/v1/fees/account/:id
```
### ARGUMENTS:

    id - the identifier of the account to set, please refer to [Account Model](../models/account.md) and
         [account functions](../products/accounts.md).

### EXAMPLE

```bash
curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/fees/account/4750
```

### RESPONSE:

```javascript
{
    "description":"Current", 
    "id":4750,
    "balance": 1117.97000, 
    "type":"Common", 
    "currency": { ... }
}
```

The response contains the data about the account which has been set. Please refer to [the asset model](../models/asset.md)
for more details on the 'currency' field. 

*Please be aware, if you did not set the fee account for some asset (currency), any corresponding transactions with this fee will fail.*
