# Currencies and Assets

Initially, Copernicus Gold deals with two categories of currencies: fiat currencies (like USD, EUR, SGD, etc.) and 
the unique digital gold currency. We provide a very simple way to open accounts in those currencies and to perform
exchange using the current market prices.

If you run a custom CG application, you have an opportunity to create own currency (we prefer the term 'asset') and
to perform exchange operations. For creation of own asset please refer to [the asset section](../applications/own_assets.md).

Here we consider functions connected with conversions of assets (currencies):

1. [Get Available Assets/Currencies](#get-available-assets)
2. [Exchange Rates](./rates.md)
3. [Creating Exchange Transaction](./exchangetransaction.md)


## Get Available Assets

The endpoint to receive a list of the available assets:

```
    curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/currencies
```

The result will be a [list of assets](../models/asset.md).
