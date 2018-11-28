# Customer Model

The customers are main object of the system. They are responsible for owning the information and data. There 
are two types of customers: individuals and corporate entities. The customers may own accounts, transactions,
messages, contacts and others.

Below are provided the fields of the customer object:

```
{
    "id": 1234567
    "state": "Active",
    
    "name": "Copernicus Gold Singapore",
    "type": "Corporate",
    "compliance_state": "Passed",
    "kind": "Organization" 
}
```

Field details:

### state

The state of the customer. The possible values are:
* "New" - the customer has been just created.
* "Confirmed" - at least one of the customer's contact (mobile phone or email) was confirmed.
* "Active" - the customer has fulfilled their profile.

### name

The full name of the customer.

### type

Possible values: Individual, Corporate.

### compliance_state

Possible values are:

* "Restricted" - the customer did not pass yet the identification procedure (KYC).
* "Accepted" - the identification form has been submitted by the customer
* "Pending"  - the KYC procedure has been started
* "Passed"   - the customer has been successfully passed the KYC procedure
* "Refused"  - the customer was unable to pass the KYC procedure.


