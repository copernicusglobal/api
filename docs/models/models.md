# API Models

Here we provide a list of all API models that are used in the API requests and responses.

A model represents a structure like this:
```
{ 
  "id": 12345,
  "created": "2015-07-21T15:44:54.947+0000",
  "state": "Active",
  "details": "Not specified"
} 
```

Usually, all models are suitable for requests and responses, but the responses contain often more
information (e.g. time stamps, states, paging details).

For example, let's consider a request for opening a new account (wallet). It has the following fields:
```
{
  "description": "My precious",
  "currency": { "asset_id": "USD" },
  "type": "Common"
}
```

The resulted response will have more fields:

```
{
    "balance": 0.00,
    "currency": {
        "asset_code": "USD",
        "asset_id": "USD",
        "description": "US Dollar",
        "kind": "Currency",
        "scale": 2,
        "state": "Active",
        "value": "USD"
    },
    "description": "My precious",
    "estimated": 0.00,
    "id": 17357501,
    "state": "Active",
    "type": "Common"
}
```

The model provided above represents a so called object model - it includes the ID of the object and its state.
A basic object model has the fields:
```
{
  "id": 12345,
  "state": "Active",
  "created": "2015-07-21T15:00:00.000+0000",
  "modified": "2015-07-21T16:00:00.000+0000",
  "state_changed": "2015-07-21T17:00:00.000+0000"
}
```

The meaning of the fields is quite strait - they give the unique ID of the object, describe its current state
and provide some information on several time stamps: when the object was created, when it was modified recently
and when the last change of the state occurred.

There is another category of responses which may not be connected with objects, for example, here is the response
to a exchange rate request:
```
{
    "code": 0,
    "log": "1 Au = 39.09799089 USD",
    "rate": 39.09799089,
    "source_code": "XAU",
    "source_value": 1.0,
    "target_code": "USD",
    "target_value": 39.1
}
```
It does not have any IDs but it has the 'code' field which is equals to '0' in case of successful responses.
If the request has errors, the 'code' value will be a non-zero value. For detailed information on errors, please
refer to the [specification introduction](../specification.md).

1. [Application](./application.md)
2. [Provider](./provider.md)
3. [Customer](./customer.md)
4. [Message](./message.md)
5. [File](./file.md)
6. [Contact](./contact.md)
7. [Avatar](./avatar.md)
8. [Details of Individuals](./individual.md)
9. [Details of Corporate Entities](./corporate.md)
10. [Fees](./fee.md)
11. [Asset](./asset.md)
12. [Transaction](./transaction.md)    


Directories:
1. [Legal Address](./directories/address.md)
3. [Business Categories](./directories/businesscategory.md)
4. [Country](./directories/country.md)
5. [Common Directory](./directories/directory.md)
6. [Document Types](./directories/documents.md)
7. [Genders](./directories/gender.md)


 
