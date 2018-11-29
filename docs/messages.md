# Messaging Concept

Messaging is a part of the System which allows users to communicate with the service provider. Currently, we support
communication (in the form of a chat) with the Copernicus Gold technical support.

1. [Getting a number of unread messages](#getting-a-number-of-unread-messages)
2. [Retrieving Messages](#retrieving-messages)
3. [Submitting Messages](#submitting-messages)
4. [Uploading and Downloading Attachments](#uploading-and-downloading-attachments)


# Getting the Number of Unread Messages

### REQUEST:
```
    GET    /api/v1/messages/counter
```
### ARGUMENTS:
       none 
       
```bash       
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/messages/counter
```

### RESPONSE:

```javascript
2
```

It is just a number which depicts the number of messages which are unread yet.
After performing the [retrieve](#Retrieving Messages) operation by a customer, the number of unread will be reset to zero
for this customer.


# Retrieving Messages

This operation returns a list with messages for the current customer. Customers have their own list of messages (or one
conversation per customer).

### REQUEST:
```
    GET    /api/v1/messages
```
### ARGUMENTS:
       page - a number of page to load
       per_page - how many items should be on the page

```bash       
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/messages?page=0&per_page=10
```

### RESPONSE:

```javascript
{
    "code": 0,
    "messages": [
        {
            "attachments": [{...}, {...} ],
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

Please refer to [the message model](./models/message.md) to see meaning for all fields here.


# Submitting Messages

The operation submits a text message with possibly attached files. The identifiers of the files should be
specified in the "attachments" field and preliminarily uploaded (see uploading files below).

### REQUEST:
       POST   /api/v1/messages
### ARGUMENTS:
       none

```bash
curl -X POST -H "Accept: application/json" \
             -H "Authorization: Bearer $TOKEN" \
             -d {"message" : "Some text", "attachments":[{"id" : 31952}]} $API_HOST/api/v1/messages
```
 
### RESPONSE:

```javascript
{
    "attachments": [ {...}, ...],
    "code": 0,
    "date": "2015-07-21T15:52:38.940+0000",
    "direction": "OUT",
    "id": 31953,
    "message": "Some text"
}
```


# Uploading and Downloading Attachments

Please refer to [files](./models/file.md) to get information how to work with files.

