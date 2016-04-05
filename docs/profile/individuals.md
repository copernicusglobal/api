# Individual Customer Model

Considering the structure of a customer profile model in case of a person (individual).

```javascript
{
    "birth_date": "1978-11-14",
    "code": 0,
    "current_address": {
        "address": "3-400 Himikov str",
        "city": "Yekaterinburg",
        "country": {
            "description": "Russia",
            "value": "RU"
        },
        "postal_code": "620000",
        "type": "Legal"
    },
    "document_number": "6500 123456",
    "document_type": {
        "description": "Passport",
        "value": "Passport"
    },
    "first_name": "Alexey",
    "full_name": "Romanchuk Alexey Petrovich",
    "id": 652450,
    "state":"Active",
    "last_name": "Romanchuk",
    "middle_name": "Petrovich",
    "nationality": {
        "description": "Russia",
        "value": "RU"
    },
    "sex": {
        "description": "Male",
        "value": "Male"
    }
}
```

Details of the model are clear due to their names. There are the part for a customer's address and nationality 
(citizenship), then the parts for names (the first, middle, last or the full name) and the part connected with customer
documents (a document type and number). 

Some of the values should be obtained via special reference like 'countries', 'sex' and 'document types' 
(see [special endpoint for them](./profile_directories.md)).
