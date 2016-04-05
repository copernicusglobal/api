# Multi-customer applications

Some functions can work for a current customer only. The system supports both individual and corporate clients who
are accessible via a single authorized user. If you have added at least one corporate customer, you can switch
your application between a default individual client and a newly added corporate.

1. [Retriving Current Customer](#Retrieving Current Customer)
2. [Available Customers](#Available Customers)
3. [Changing the Current Customer](#Changing the Current Customer)


# Retrieving Current Customer

This operation is used to retrieve the main fields of the current customer like the "name", "state" and "type", 
which can be use to determine valid interaction with the customer (like not allowing them to do something 
until the state is not "Active").

### REQUEST:
       GET   /api/v1/customers/current
### ARGUMENTS:
       
       none
       
```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN"  https://testapi.copernicusgold.com/api/v1/customers/current
```

### RESPONSE:

```javascript
{
    "code"   : 0,
    "created": "2015-03-16T09:37:19.659+0000",
    "id": 10,
    "modified": "2015-07-14T15:08:03.174+0000",
    "name": "Customer Demo",
    "state": "Active",
    "state_changed": "2015-07-14T15:08:03.161+0000",
    "type": "Individual"
}
```

The important fields in the response are "name", "state", "id" and "type".  The "name" field gives the full name of the
current customer. The "state" field can be "Active", "Confirmed" or "New". 

Immediately after registration a customer has the "New" state, then after confirming their mobile phone number via USSD,
the state is changed to "Confirmed". But after providing the whole and the valid information in the [profile](./profile/profiles.md)
the state is transformed to the "Active". 

The customers who have states less then "Active" cannot sign any documents or payments.
The "id" field is just the identifier of the customer and it should be stored for further usage (for example, 
to change the current customer). The "type" describes either the customer is a "Individual" or "Corporate" one.

# Available Customers

Retrieves a list with all customers included (corporate or individual) who are available for the current user.

### REQUEST:
       GET   /api/v1/customers
### ARGUMENTS:
       none

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN"  https://testapi.copernicusgold.com/api/v1/customers
```

```javascript
RESPONSE:
[
    {
        "created": "2015-03-16T09:37:19.659+0000",
        "id": 10,
        "modified": "2015-07-14T15:08:03.174+0000",
        "name": "Customer Demo",
        "state": "Active",
        "state_changed": "2015-07-14T15:08:03.161+0000",
        "type": "Individual"
    },
    {
        "created": "2015-07-16T12:07:27.756+0000",
        "id": 779050,
        "kind": "Organization",
        "name": "Demo Company Inc.",
        "state": "New",
        "type": "Corporate"
    }
]
```

In the response you can see a list of brief customer data with the same fields as described above.

# Changing the Current Customer

This operations gives you a way to change the current customer to a one from the list of available customers. After performing the operation all API function will work with the new customer.

### REQUEST:
       PUT   /api/v1/customers/:id/current
### ARGUMENTS:
       id - the identifier of a customer

```bash
TOKEN="your access token here"
curl -X PUT -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/customers/779050/current
```

### RESPONSE:

```javascript
{
    "created": "2015-07-16T12:07:27.756+0000",
    "id": 779050,
    "kind": "Organization",
    "name": "Demo Company Inc.",
    "state": "New",
    "type": "Corporate"
}
```

The fields are the same as above and describe the new current customer.

