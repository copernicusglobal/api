# Corporate Data Model

The corporate data model represents an object that provides full details on the given corporate entity like
the registration date, the legal address, the business activity, etc.

```
{
    "business_category": { ... },
    "business_sub_category": { ... },
    "email": "welcome@copernicusgold.com",
    "id": 1234567,
    "name": "Copernicus Gold Singapore",
    "owner_id": 1234567,
    "registration_address": { ... },
    "registration_date": "2016-06-26T00:00:00.000+0000",
    "registration_number": "0000-201203-2132",
    "corporate_phone_number": "6511112222",
    "corporate_type": {...},
    "biz_files": [ 1000, 2000 ],
    "company_constitution_files": [122312],
    "other_documents": [32312,412312,5231231]
    
    "affiliates": [ { ... }, ... ]
}
```

### business_category / business_sub_category

A reference to a record from the business category directory which is used for the classification of
business activities. Please refer to [description of the directory](./directories/businesscategory.md) for
some details.


### email

The primary business email address which is utilized also as the main address for receiving payments.

### name

The official name of the company.

### owner_id

The ID of the linked [customer object](./customer.md).

### registration_address

The reference to the legal address of this corporate entity. For more details on the structure of this
field, please refer to [the address directory](./directories/address.md).

### registration_date

The date of the official registration of the company.

### registration_number

The government registration code of the company.

### corporate_phone_number

The phone number of the company. It is used just for information and cannot be used for receiving payments.

### corporate_type

The type of the corporate entity. The full list of the values can be obtained from the API endpoint:

```
    curl -x GET -H "Authorization: Bearer $TOKEN"   $API_HOST/api/v1/directory/CORPORATE_TYPES
```

### biz_files

The IDs of uploaded files (see [file models](./file.md)) with the details of company's business profile (BizFile).

### company_constitution_files

The IDs of uploaded files with the Company Constitution or Memorandum of Association and Articles of Association.

###  other_documents

The IDs of other documents that can be used for the identification of this corporate entity. For example, 
these can be the documents to confirm the authority of the head of the organization and the business activity. 

### affiliates

A list of people who have a permission to manage the company. The structure of this field is almost the same
as [for individuals](./individual.md) with several additional fields:

```
{
    ...
    is_beneficial: false,
    is_director: true,
    is_organization_management: true,
    is_partner: false,
    phone_number: "79122437136",
    ...
}
``` 

The fields 'is\_beneficial'/'is\_director'/'is\_partner' describe the role of the individual in the company. 
The 'is\_organization\_management' field gives a permission to manage the company via the system applications
(for example, to make payments).

The 'phone\_number' field allows to provide the mobile phone number of the person, which may be used to
connect the person to the company's access list automatically if the person has a registered account in the system
for this phone number.




