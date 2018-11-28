# Contact Model

Contacts are communication channels with the customer. Currently, they can be mobile phones or email addresses.

Each contact object has the following structure:

```
{
    "id": 1234567,
    "kind": "Other",
    "state": "Confirmed",
    "type": "Phone",
    "value": "6500001111"
}
```

Fields:

### kind

Can have two values: 'Main' or 'Other'. The 'main' contacts are used primary for the authentication and delivering
notifications. Other contacts may be used as payment addresses.

### state

Possible values are 'New' and 'Confirmed'. If a contact is confirmed, it means that the user has proved their
ownership of the contact (e.g. by the provided OTP which was sent to the mobile phone or by accepting the link
sent to the email address).

### type

There are two possible values:
* Phone - for mobile phones
* Email - for email addresses

### value

The value of the contact itself - the mobile phone number or the email address.