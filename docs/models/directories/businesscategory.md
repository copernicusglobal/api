# Business Category

Business categories is a directory for the high level of classification of businesses. It has Singaporean
origins but is suitable for most other countries.

```
{
    "code": "K",
    "description": "Financial And Insurance Activities",
    "value": 11
}
```

It is always used in conjunction with Business sub-category:

```
{
    "code": "649",
    "description": "Other Financial Services Activities, Except Insurance And Pension Funding Activities",
    "value": 141
}
```

The following endpoint must be used for obtaining business categories:

```
    curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/businesscategories
```

### code

The public code.

### description

The human-readable description.

### value

The value in the system's database.