# Customer Profile

Copernicus Gold supports both *individual* and *corporate* customers. Each of them has their own profile model containing
the appropriate fields.

1. [Individual Customer Model](./individuals.md)
2. [Profile Directories Used in the Model](./profile_directories.md)
3. [Corporate Profile Model](./corporate.md)
4. [Retrieving Customer Profile](#retrieving-customer-profile)
5. [Submitting or Editing Customer Profile](#submitting-or-editing-customer-profile)


# Retrieving Customer Profile

This function returns the data model for the current authorized customer who must be an individual person (not a 
corporate entity).

### REQUEST:
       GET    /api/v1/customers/individual/data
### ARGUMENTS:
       none
### EXAMPLE

```bash
TOKEN="your access token here"
curl -X  -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/customers/individual/data
```
 
### RESPONSE:

```javascript
{
    "code": 0,
    "first_name": "Alexey",
    "full_name": "Romanchuk Alexey Petrovich",
    "id": 652450,
    ...
}
```

The result is a customer model. In the case if the current customer doesn't have any profile data, the result will 
be  ```{ "code" : 0  }```. The identifier ("id") must be used to edit the profile (see the PUT command below).
The whole list of fields can be obtained [here](./individuals.md) 


# Submitting or Editing Customer Profile

This operation performs creation of new profile data based on the individual or corporate model specified in the request's body. 
In the case of editing the PUT method must be used and the identifier ("id") must be included in the request body.

## REQUEST:
       POST | PUT    /api/v1/customers/individual/data
### ARGUMENTS:
      none
### EXAMPLE

```bash
TOKEN="your access token here"
MODEL={"id" : ... ,  "birth_date" : "...", "sex" : {...}, ..."}
curl -X POST -H "Authorization: Bearer $TOKEN" -d $MODEL https://api.projectdgc.com/api/v1/customers/individual/data
```

### RESPONSE:

```javascript
 {
    "code"   : 0,
    "birth_date": "1978-11-14",
    "id": 652450,
    ..
 }
```

The operation returns a customer model. In the case of creation of a new profile this method also returns the identifier for
the profile included in the response model.
