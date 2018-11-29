# Confirmation of Actions

For some operations that occurs in the system, the customers need to provide their confirmations. The confirmation
strategy depends on the channel which was used by the customer during the [authentication](./authentication.md).

There are two currently supported channels: USSD and SMS.

### USSD confirmation

The confirmation via USSD is quite simple - the user is requested to enter their PIN-code through a USSD
request which is sent to the mobile phone at the moment of the confirmation. After successful entering
the PIN, the action will be done immediately.

### SMS confirmation

The SMS confirmation requires providing the OTP which is sent as an SMS message. You need to conduct a special
API operation to complete SMS confirmation. Usually, it is carried out by provided the same JSON/XML model
that was used for the initial operation but with the added OTP section. 

For example, if you have the following model for the action of opening a new account: 
```
{
    "description": "Description",
    "currency": {"asset_id": "XAU"},
    "type": "Common"
}
```

The confirmation model for this JSON will be the following:

``` 
{
    "otp": 1234,
    "description": "Description",
    "currency": {"asset_id": "XAU"},
    "type": "Common"
}
```

You can note the otp field with the value of the OTP received via SMS.

Then, usually there is a special endpoint to provide this model to the API server. For the aforementioned
opening account operation, it will be like this:
```
curl -X PUT -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/confirm/account/1234567 \
            -d "$MODEL"
```

The reason why the platform requires to repeat the model again is more safety. The system always
compares the model used for the initialization of the action and the model at the moment of the confirmation.


The confirmation endpoints are similar to each other:

```
/api/v1/confirm/transaction/:id (for transactions)
```

```
/api/v1/confirm/assets/:id (for assets)
```

```
/api/v1/confirm/close/account/:id (for closing accounts)
```

```
/api/v1/confirm/corporate/:id (for confirmation of corporate entities)
```

```
/api/v1/confirm/contact/:id (for confirmation of contacts)
```

```
/api/v1/confirm/contact/set/main/:id (for confirmation of setting the main contact)
```


