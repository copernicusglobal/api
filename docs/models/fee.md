# Fee Model

Here are two examples of the fee model.

The first manages the 1.2% fee for all transfers between customers.

```
{
    "algorithm": "percent",
    "fee_code": "Transfer",
    "id": 1234567,
    "value": 1.2
}
```

The second gives an example of a fixed 0.02 USD fee for all currency conversions.

```
{
    "algorithm": "fixed",
    "asset_id": "USD",
    "fee_code": "Exchange",
    "id": 7654321,
    "value": 0.02
}
```

### algorithm

Currently, there are two supported values: 'percent' and 'fixed'. The percent algorithm expects a percent
value in the 'value' field and calculates the fee as percent from the amount of the transactions.
The fixed algorithm withdraws some fixed value in the currency given in the 'asset\_id' field.

### fee_code

The concrete location of the fee. Currently, we support custom fees with the following codes:
* 'Transfer' - a fee for transactions between customers
* 'Exchange' - a fee for all conversions.

### asset_id

It is relevant in the case when the algorithm field is 'fixed'. Here you can specify the currency (asset)
that will be used for withdrawing the fee.

### value

Just a value of the fee: a percent value (for example, 1.2 or 5) or a concret value 25.00 or 0.05.
Please bare in mind that a percent value 25% should be set as 25 and NOT as 0.25. 

