# Exchange Rates

Returns calculates sums for the current exchange rates.

Provides the exchange rate, converted amounts for some parameters of the exchange deal. In the body of the request you should
provide a currency code (the asset's identifier) both source and target currencies ("source\_code" and "target\_code" fields)
and some amount to convert. 

The value can be specified in source or target currency ("source\_value" or "target\_value"). The product value may depend
on the deal: in the case of general currency exchange (when you just transfer money between your own accounts) you should
use product = "Default".

### REQUEST:
       PUT     /api/v1/rates
### ARGUMENTS:
       none

```bash
TOKEN="your access token here"
MODEL='{"source_code":"XAU", "target_code":"USD", "source_value":"1.00000", "product":"Default"}'
curl -X PUT -H "Authorization: Bearer $TOKEN" -d $MODEL https://testapi.copernicusgold.com/api/v1/rates
```
 
### RESPONSE:

```javascript
{
    "code": 0,
    "rate": 31.95784209,
    "source_code": "XAU",
    "source_value": 1.00007,
    "target_code": "USD",
    "target_value": 31.96
}
```

The result contains mostly the same fields and also the field missed in the request ("source_value" or "target_value" which
will have the converted value).

Depending on the exchange rate the original target or source value can be also recomputed to ensure the correct rounding,
i.e. you can't buy less than, for instance, 0.01 USD or less than 0.00001 grams of gold (XAU) - it always will be rounded.
