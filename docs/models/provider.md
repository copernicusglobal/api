# Provider Model

The providers are the aggregates which allow to combine several application which are close to each other
from the point of the service. If you create, for instance, a loyalty point provider, you can create two
applications (e.g. web and mobile) that use the provider's loyalty points.

For more details on applications please refer to [the application section](../applications/applications.md). 

The provider's fields:

```
{
    "created": "2016-10-26T20:06:11.161+0000",
    "customer": { ... },
    "id": 1234567,
    "name": "Copernicus Gold"
}
```


### id

The unique ID of the provider in the system. It must be used for all provider-related operations.

### created

The time of creation the provider's object.

### name

The name of the provider. It appears, for example, in SMS messages or email sent by the system.

### customer

The linked customer - the owner of the provider. Each provider is linked to a corporate entity. So that you
should create a company before starting to work with providers and applications. Please refer to
[customer model section](./customer.md) for more details on customers. 


## Get Providers

You can obtain the list of currently available providers with use of the following operation:

```
    curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/providers
```

The result will be as a list of provider models.

## Get Current Provider

```
    curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/providers/current
```

## Change the Current Provider

```
    curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/providers/:id/current
```

Where ':id' - the ID of the provider object to be set.

## Modifying the Name

Also you can modify the name of the provider:

```
    MODEL='{"name": "New Name"}'
    curl -x PUT -H "Authorization: Bearer $TOKEN"  $API_HOST'api/v1/providers/:id' -d $MODEL
```

In order to modify the provider you must be logged as the *corporate customer who owns the provider*.


