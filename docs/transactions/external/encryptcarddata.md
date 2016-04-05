# Encrypt card data on client

Currently, we suppose to use Adyen as our partner for card operations.

Library 'adyen.encrypt.nodom.min.js' used to encrypt card data:

1. to see https://github.com/Adyen/CSE-JS#javascript-only-integration
2. to get https://github.com/Adyen/CSE-JS/blob/master/js/adyen.encrypt.nodom.js

### EXAMPLE:

``` javascript

<script type="text/javascript" src="js/adyen.encrypt.nodom.min.js"></script>
<script type="text/javascript">

            var key = "..."; 
            var options = {"enableValidations" : false};  // See adyen.encrypt.nodom.html for details
            var cseInstance = adyen.encrypt.createEncryption(key, options);
            
            //for a new card
            var cardData = {
                    number : "...",
                    cvc : "...",
                    holderName "...": ,
                    expiryMonth "...": ,
                    expiryYear "...": ,
                    generationtime : "..."
                };

            var ayden_card_encrypt_data = cseInstance.encrypt(cardData);
</script>
```

The expected format for the '**expiryMonth**' field is '**MM**', and for the "expiryYear" field is "YYYY".
For fields '**key**' and '**generationtime**', please use [the information for encrypting card data](./infoforencryptcard.md)

The generated **ayden\_card\_encrypt\_data** should be used for a card object 
in [receiving money from a bank card](./externaltransactionfromcard.md).


If you have chosen an [existing card](../../products/cards.md), only **cvc** and **generationtime** are required. So
that the aforementioned card data block will look like this:

```javascript

    // for an existing card
    var cardData = {
        cvc : ...,
        generationtime : "..."
    }
```
