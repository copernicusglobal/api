# File Model

Files can be uploaded by customers when chatting with the support service or the files can be some documents
participating in the KYC procedure or other processes.

A typical model for an uploaded file looks like this:

```
{
    "created": "2017-07-03T09:50:12.503+0000",
    "id": 1234567,
    "mime_type": "image/jpeg",
    "modified": "2017-07-03T09:50:12.523+0000",
    "original_file_name": "gav_userpic_by_600v.jpg",
    "size": 29071,
    "state": "Active"
}
```

Fields:

### mime_type

The mime type which describes the nature of the file.

### original_file_name

The original name of the file befire it was uploaded to the platform.

### size

The size of the file in bytes.

Typical file functions:

## Uploading a File

```
    curl -X POST -H 'Content-Type: multipart/form-data'
                 -F filex=@sample.txt
                 $API_HOST/api/v1/files
```

Here is the sample.txt - the path to the file to be uploaded.
The result is the model similar to the described above.


## Downloading the File

```bash
curl -X GET -H 'Accept: application/octet-stream' \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/files/:id 
```

The results is a stream with the file opened for downloading.

## Obtain the File Model by ID

In case if you need to get details of the file you can query:

```bash
curl -X GET -H 'Accept: application/json' \
            -H 'Content-Type: application/json' \
            -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/files/:id
```

Where 'id' if the ID of the file.

## Get the Content of the File as a Base64-string

```
curl -X GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/files/:id/base64
```

The result will be a string "...." with the base64-encoded data.

## Removing a File

```
curl -X DELETE -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/files/:id
```

