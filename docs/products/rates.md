# Exchange Rates

Returns calculates amounts with use the current exchange rates.

Provides the exchange rate, converted amounts for some parameters of the exchange deal. In the body of the request you should
provide a currency code (the asset's identifier) both source and target currencies ("source\_code" and "target\_code" fields)
and some amount to convert. 

The value can be specified in source or target currency ("source\_value" or "target\_value").

### REQUEST:

```
    PUT /api/v1/rates
```

### ARGUMENTS:
    
       none
       
### EXAMPLE

```bash

MODEL='{"source_code":"XAU", "target_code":"USD", "source_value":"1.00000"}'
curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/rates -d $MODEL

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

The result contains mostly the same fields and also the field missed in the request ("source\_value" or "target\_value" which
will have the converted value).

Depending on the exchange rate the original target or source value can be also recomputed to ensure the correct rounding,
i.e. you can't buy less than, for instance, 0.01 USD or less than 0.00001 grams of gold (XAU) - it always will be rounded.
