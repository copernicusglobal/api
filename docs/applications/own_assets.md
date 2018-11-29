# Introduction to Assets

Assets represent some values which can be stored in the system. Those can be currencies like US dollar or euro, but
at the same time assets depict a more wide class of values: gold, silver, oil, bitcoin or others.

Originally, Copernicus Gold has two categories of assets: gold-linked currency (or electronic gold) and common fiat currencies.
The fiat currencies can be currently: USD, EUR, SGD (Singapore Dollar). In the nearest future the number of the currencies
will be increased. For additional details on asset objects please refer to [the asset model](../models/asset.md).

You can open accounts using these standard assets, send such currencies between your clients (using 
[transactions](../transactions/transactions.md)) or even [convert assets](../products/exchangetransaction.md) from one
to others (using our market-based exchange rates).


But at the same time if you use your [own applications](./registration.md), you can register own assets and provide
different aforementioned operations with these assets for your own clients. The assets can be tokens, loyalty points or
any other type of assets which are not the securities.

1. [Creating Assets](#creating-a-new-asset)
2. [Modifying Assets](#modifying-an-asset)
3. [Querying Assets](#querying-assets)
4. [Querying a Single Asset](#querying-a-single-asset)
5. [Removing Assets](#removing-assets)


# Creating a New Asset

To create an asset you need to provide its code, the description and the scale.

### REQUEST:
```
    POST /api/v1/assets
```    
### ARGUMENTS:

```
    {"asset_code" : "...", "description" : "...", "scale": "..." }
```

    The field 'scale' means how many fraction digits should have the asset. For example, it must be set 2 for US Dollar
    or it is set 5 for the Copernicus Gold gold-linked currency.

### EXAMPLE

```bash
MODEL='{"asset_code" : "BTC", "description" : "Stable SuperBitcoin", "scale": "8" }'

curl -X POST -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/assets -d $MODEL
```

### RESPONSE:

```javascript
{
  "code":0,
  "scale":8,
  "description":"Stable SuperBitcoin",
  "asset_id":"b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121",
  "asset_code":"BTC"
}
```

In the generated response the 'asset\_id' field represents the unique identifier of the asset which must be used further
in all operations.


# Modifying an Asset

You can modify some fields like 'description', 'asset_code' and 'scale'.

### REQUEST:
```
    PUT /api/v1/assets
```
### ARGUMENTS:

```
    {"asset_code" : "...", "description" : "...", "scale": "...", "asset_id" : "..." }
```

The only difference from the POST query is the presence of the field 'asset\_id'.

### EXAMPLE

```bash
MODEL='{"asset_code" : "ETH", "description" : "Ethereum", "scale": "8", "asset_id" : "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" }'
curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/assets -d $MODEL
```

### RESPONSE:

```javascript
  {
    "code":0,
    "scale":8,
    "description":"Ethereum",
    "asset_id":"b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121",
    "asset_code":"ETH"
  }
```

Be careful changing the field 'scale' - for existing transactions and accounts it will mean **denomination**.


# Querying Assets

Using this query you will be able to get the whole list of own assets. The request will work if only you are logged via
the application which has been used to create these assets.

### REQUEST:
```
    GET /api/v1/assets
```
### ARGUMENTS:
    none
### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/assets
```

### RESPONSE:

```javascript
[
  {
    "code":0,
    "scale":8,
    "description":"Ethereum",
    "asset_id":"b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121",
    "asset_code":"ETH"
  },
  {
    "code":0,
    "scale":0,
    "description":"OIL (barrels)",
    "asset_id":"dc6054c0-792e-4979-afca-f66f89ee4586",
    "asset_code":"OIL"
  },
  ...
]
```

In the case when you wish to obtain the list of all assets available for you including the public assets from Copernicus
Gold, you need to use the '/api/v1/currencies' endpoint.


# Querying a Single Asset

Use this query to get information about one asset.

### REQUEST:
```
    GET /api/v1/assets/:id
```
### ARGUMENTS:

    id - the identifier of the asset (the 'asset\_id' in the previous queries).

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/assets/b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121
```

### RESPONSE:

```javascript
  {
    "code":0,
    "scale":8,
    "description":"Ethereum",
    "asset_id":"b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121",
    "asset_code":"ETH"
  }
```

# Removing Assets

In the case when some asset is not required anymore you can remove it. If you have some transactions and accounts for
this asset, the asset will change its state to 'Inactive' and it will be unable to use.

### REQUEST:
```
    DELETE /api/v1/assets/:id
```
### ARGUMENTS:

    id - the identifier of the asset (the 'asset\_id' in the previous queries).
    
### EXAMPLE

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/assets/b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121
```

### RESPONSE:

```javascript
{
    "code":0,
    "scale":8,
    "description":"Ethereum",
    "asset_id":"b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121",
    "asset_code":"ETH"
}
```

The response represents the model of the deleted asset.
