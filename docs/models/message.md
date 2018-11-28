# Message Model

Messages are objects used for transferring text and files between the customer and the support service of
the application.

Each messages has the following structure:

```
{
    "id": 1234567,
    "message": "Hi, it's me. Just writing you to complain",
    "direction": "OUT",
    "date": "2018-10-10T12:30:38.527+0000",
    "attachments": [ {...}, {...} ],
    "author": { ... },
    "customer": { ... }
}
``` 

The fields:

### message

The text of the messages itself.

### direction

It can have two values: OUT (for outward messages) and IN (for incoming messages) from the point of the
current customer.

### date

It is the time stamp when the message was posted.

### attachments 

A list of [file models](./file.md) that are linked to the given message.

### author

An individual customer who created the message.

### customer

A customer who owns the messages. It may differ from the author when an individual person write on behalf
of a corporate entity. In this case the customer of the message is the corporate entity.




When requested, the messages are combined to lists which have the structure like this:

```
{
    [ {...}, {...}, ...],
    "total_messages": 100
}
```
Where the {...} means Message models.

### total_messages

The total number of the messages.
