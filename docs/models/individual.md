# Individual Model

This model is used for description of individual people.

```
{
     ... This part is used for setting the basic customer profile
     
    "birth_date": "1978-11-14T00:00:00.000+0000",
    "fatca": true,
    "first_name": "Alexey",
    "middle_name": "Petrovich",
    "full_name": "Romanchuk Alexey",
    "id": 1234567,
    "last_name": "Romanchuk",
    "nationality": {...},
    "pep": true,
    "sex": {...},
    
    ... The part below - for the identification (KYC) procedure
    
    "current_address": { ... },
    "document_number": "6501 555555",
    "document_type": {...},
    "document_issue_date":"2012-02-02T00:00:00.000+0000",
    "document_expire_date":"2027-02-02T00:00:00.000+0000",
    "industry":{ ... },
    "occupation":{ ... },
    "documents": [100000, 200000],
    "residentials":[3000000],
    "photo_id":500000
}
```

### birth_date

The birth date of the person.

### current_address

The address of residence of the person. Please refer to [the address model](./directories/address.md) for
details on its structure.

### document_number

The number of the identification document of the person.

### document_type

The type of the identification document. Please refer to [the document types directory](./directories/documents.md)
for details.

### document_issue_date

The date when the document was issued.

### document_expire_date

The date when the document will expire

### fatca

The value is true if the person does NOT have any relations to the US residence, the taxation in accordance
with Foreign Account Tax Compliance Act (FATCA).

### pep

If is set as true, it means the person is NOT a Politically Exposed Person.

### first_name, middle_name, last_name and full_name

Different parts of the name including the full name of the individual.

### nationality

The citizenship of the person. Should be a value from the [country directory](./directories/country.md).

### sex

Here must be one of the value from [the gender directory](./directories/gender.md).

### industry

A value from the [industry directory](./directories/directory.md).

### occupation

A value from the [occupation directory](./directories/directory.md).

### documents

Here is an array of the IDs of [uploaded files](./file.md) with photographs of the identification documents.

### residentials

Here are the IDs of uploaded files with scanned documents proving the residence of the person.


### photo_id

Here is the ID of a uploaded file with the photograph of the person (selfie). To improve the security of
the snapshot we usually ask the person to provide on this photo a paper with the drawn individual code.

This code is changed daily and can be obtained as follows:

```
   curl -x GET -H "Authorization: Bearer $TOKEN"  $HOST/api/v1/identification/code
```
The result will be a plain string with quotes, e.g. "3385"


