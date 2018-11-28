# Common Directory

A directory is an index with some data. Its structure is very simple:

```
{
    "description":"01111 - GROWING OF LEAFY AND FRUIT VEGETABLES",
    "id":230189
}
```

### id

The unique ID of the record.

### description

The human-readable description for the record: INDUSTRY\_CODES, OCCUPATION\_CODES, CORPORATE\_TYPES
There are several types of common directories: 

Each of them can be obtained with use of the following endpoint:
```
    curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/directory/$DIRECTORY_CODE
```

The values for $DIRECTORY_CODE are: INDUSTRY\_CODES, OCCUPATION\_CODES, CORPORATE\_TYPES.