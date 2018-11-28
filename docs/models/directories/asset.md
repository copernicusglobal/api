# Asset Model (Currency)

One of the most exiting feature of the Copernicus Gold platform is its ability to issue own electronic
assets. They can be linked to some real value like gold, silver, other precious metals, also, US dollar, Euro
in a bank. At the same time you can issue you own asset and manage it. All functions from our high-level API
will be automatically available for any kind of assets.

All assets are linked to the current [provider](./provider.md) of the [application](./application.md).
The platform global assets are available for all applications but custom assets are always restricted to
applications.

Below are provided some examples of assets.

A commodity asset: gold.

```
{
    "asset_code": "XAU",
    "asset_id": "XAU",
    "description": "Gold",
    "kind": "Commodity",
    "scale": 5,
    "state": "Active"
}
```

An asset based on a fiat currency
```
{
    "asset_code": "USD",
    "asset_id": "USD",
    "description": "US Dollar",
    "kind": "Currency",
    "scale": 2,
    "state": "Active"
}
```

Another currency-like asset:
```
{
    "asset_code": "BTC",
    "asset_id": "BTC",
    "description": "Bitcoin",
    "kind": "Currency",
    "scale": 8,
    "state": "Active"
}
```

Or a custom asset - token:
```
{
    "asset_code": "COIN",
    "asset_id": "3aadb70fa8c14cddacf2ef6154709b3d",
    "description": "Loyalty Coins",
    "kind": "Token",
    "scale": 0,
    "state": "Active"
}
```

### asset_id

The unique identifier of the asset. It has some predefined values for own platform's assets or is generated
randomly for custom assets (for example, '3aadb70fa8c14cddacf2ef6154709b3d').

### asset_code

The human-readable value for the asset which appears in applications, messages and transactions. The issuer
of the asset can specify any value here.

### description

An internal description of the asset for understanding its purpose. 

### kind

Defines the kind of the asset. It can have the following values:

* Commodity - if the asset is a commodity like gold, silver or other precious metals.
* Currency  - if the asset is a currency both fiat or cryptocurrency. 
* Token     - if the asset represents a custom token.

### scale

The number of digits after the comma (fraction digits). For example, if the scale is equals to 2, the possible
values look like 1233.30, 0.24 or 0.01. If the scale is zero, then we can operate with integer values only.
The latter is useful for the case when we create loyalty points. 
