# Countries

Returns a full list of the world countries. The result contains a big list of all countries where the system currently operates.

### REQUEST:
       GET   /api/v1/countries
### ARGUMENTS:
       none
### EXAMPLES:

```bash
TOKEN="your access token here"
curl -X GET -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/countries
```
 
### RESPONSE:
```javascript
[
  {
    "value" : "US",
    "description": "The United States"
  },
  {
    "value" : "RU",
    "description" : "Russia"
  },
  .......
]
```

The resulted list is big enough and can be successfully cached in a local application. The value attribute of country
record is the ISO 3166-1 A2 code (two-letter).

# Document Types

Returns a list of available document types. The result contains a list with all types of documents which can be used
to register and open an account in the system.

### REQUEST:
       GET   /api/v1/documents/types
### ARGUMENTS:
       none
### EXAMPLES

```bash
TOKEN="your access token here"
curl -X GET  -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/documents/types
```

### RESPONSE:

```javascript
[
    {
        "description": "Passport",
        "value": "Passport"
    },
    {
        "description": "Birth certificate",
        "value": "BirthCertificate"
    },
    {
        "description": "NRID",
        "value": "NRID"
    }
]
```

The current result list is specific for the jurisdiction where the system operates.
 
# Gender Types

Returns a list of available gender. The result contains a list currently for two values: Male or Female.

### REQUEST:

       GET   /api/v1/sex
       
### ARGUMENTS:

       none

### EXAMPLE:

```bash
TOKEN="your access token here"
curl -X GET -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/sex
```

### RESPONSE:

```javascript
[
    {"description": "Male",  "value": "Male"  },
    {"description": "Female","value": "Female"}
]
```
