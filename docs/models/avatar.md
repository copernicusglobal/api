# Avatar Model

The avatars are the pictures or photo snapshot uploaded by user and shown in applications.
Actually, the avatar is just a thin wrapper around its uploaded file.

```
{
    "file": {...},
    "customer_id": 1234567
}
```

### file

It is a [file model](./file.md) for an uploaded file.

### customer_id

The identifier of the current customer.