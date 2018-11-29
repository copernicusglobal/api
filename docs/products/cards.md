# Cards

If you use a card to replenish the balance of an account, the information about the card is saved in the secured
storage which is provided by our partner. After storing, the card can be just used by its ID to avoid
providing the whole information about the card again.

There is a way to obtain all previously stored cards.

### REQUEST:
```
    GET /api/v1/cards
```       
### ARGUMENTS:
       none
### EXAMPLES:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/cards
```

### RESPONSE:
```javascript
[
    {
        cardholder_name: "Alex Loh"
        created: "2018-11-08T19:07:44.175+0000"
        id: 43326200
        last_four_digits: "4242"
        modified: "2018-11-08T19:07:45.934+0000"
        state: "Active"
        valid_thru: "4/2025"
}
]
```

This data can be used to create transaction - see, for example, 
[filling an account from a card](../transactions/external/externaltransactionfromcard.md)
