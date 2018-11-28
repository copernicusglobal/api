# Document Types

This directory gives a list of possible type of identification documents:

```
[
    {
        "description": "Passport",
        "value": "Passport"
    },
    {
        "description": "Employment Pass",
        "value": "EmploymentPass"
    },
    {
        "description": "NRIC",
        "value": "NRIC"
    }
]
```

### value

The unique code of the document.

### description

The readable description of the document.

In order to obtain the list of the documents please use the endpoint:

```
    curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/docuemnts/types
```
