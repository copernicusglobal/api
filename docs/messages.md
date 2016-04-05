# Messaging Concept

Messaging is a part of the System which allows users to communicate with a service provider. Currently, we support
communication (in the form of a chat) with the Copernicus Gold technical support.

1. [Getting a number of unread messages](#Getting a number of unread messages)
2. [Retrieving Messages](#Retrieving Messages)
3. [Submitting Messages](#Submitting Messages)
4. [Uploading Files](#Uploading Files)
5. [Downloading Files](#Downloading Files)

# Getting Unread Messages Number

### REQUEST:
       GET    /api/v1/messages/counter
### ARGUMENTS:
       none 
       
```bash       
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/messages/counter
```

### RESPONSE:

```javascript
2
```

It is just a number which depicts a number of messages which are unread yet. After performing the [retrieve](#Retrieving Messages)
operation, the number of unread will be reset to zero.


# Retrieving Messages

This operation returns a list with messages for the current customer. Customers have their own list of messages (or one
conversation per customer).

### REQUEST:
       GET    /api/v1/messages
### ARGUMENTS:
       page - a number of page to load
       per_page - how many items should be on the page

```bash       
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/messages?page=0&per_page=10
```

### RESPONSE:

```javascript
{
    "code": 0,
    "messages": [
        {
            "attachments": [
                {
                    "created": "2015-07-21T15:44:54.947+0000",
                    "id": 31952,
                    "mime_type": "text/plain",
                    "modified": "2015-07-21T15:44:54.952+0000",
                    "original_file_name": "sample.txt",
                    "size": 18,
                    "state": "Active"
                }
            ],
            "date": "2015-07-21T15:52:38.940+0000",
            "direction": "OUT",
            "id": 31953,
            "message": "A new message"
        },
        {
            "attachments": [],
            "date": "2015-07-21T15:31:18.639+0000",
            "direction": "OUT",
            "id": 31950,
            "message": "A new message"
        }
    ],
    "total_messages": 2
}
```

The response contains a number of the messages which have been retrieved (the "total_messages" field) and the "messages"
array with detailed information about each message. The "message" field represents a text part of each message, 
the "attachments" field gives information about files attached to the message. 

The "direction" field can have two values : "IN" or "OUT", the "IN" direction means an incoming message (from Copernicus Gold
or other members of the conversation) and the "OUT" means an outgoing message (to Copernicus Gold or other members 
of the conversation sent from the current customer).

Each attachment has the "id" field which can be used to download the attachment as a file (see below).

# Submitting Messages

The operation submits a text message with possibly attached files. The identifiers of the files should be specified in the "attachments" field and preliminarily uploaded (see ).

### REQUEST:
       POST   /api/v1/messages
### ARGUMENTS:
       none

```bash
TOKEN="your access token here"
curl -X POST -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" -d {"message" : "Some text", "attachments":[{"id" : 31952}]} https://testapi.copernicusgold.com/api/v1/messages
```
 
### RESPONSE:

```javascript
{
    "attachments": [
        {
            "created": "2015-07-21T15:44:54.947+0000",
            "id": 31952,
            "mime_type": "text/plain",
            "modified": "2015-07-21T15:44:54.952+0000",
            "original_file_name": "sample.txt",
            "size": 18,
            "state": "Active"
        }
    ],
    "code": 0,
    "date": "2015-07-21T15:52:38.940+0000",
    "direction": "OUT",
    "id": 31953,
    "message": "Some text"
}
```

The fields in the response are exactly the same as above.

# Uploading Files

This operation allows to perform uploading a file and store it in a temporal storage. Then the uploaded file can be used as an attached file for a message

### REQUEST:
      POST   /api/v1/files
### ARGUMENTS:
       none

```bash
TOKEN="your access token here"
curl -X POST -H "Accept: application/json" -H "Content-Type: multipart/form-data" -H "Authorization: Bearer $TOKEN" -F file=@sample.txt https://testapi.copernicusgold.com/api/v1/files
```

### RESPONSE:

```javascript
{
    "code": 0,
    "created": "2015-07-21T16:33:19.863+0000",
    "id": 31954,
    "mime_type": "text/plain",
    "original_file_name": "sample.txt",
    "size": 18,
    "state": "Active"
}
```

The "id" field retrieved here can be used to attach the uploaded file to a message (see [Submitting Message](#Submitting Messages).

# Downloading Files

Performs downloading a file by the specified identifier. 

### REQUEST:
       GET   /api/v1/files/:id
### ARGUMENTS:
       id - the identifier of the file

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/octet-stream" -H "Authorization: Bearer $TOKEN"  https://api.projectdgc.com/api/v1/files/31954
```
 
### RESPONSE:

Content of the file.

Depending on the curl parameters you can choose different ways to get and store the resulted file.
