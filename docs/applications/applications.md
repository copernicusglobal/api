# Application Concept

Applications are a way to build your own services using the system and its opportunities to store and to carry out
financial transactions using different assets including those you have created for your own goals.

1. [Creating a new application](#Creating New Application)


# Creating New Application

This operation allows you to create an application and to obtain app\_id and app\_secret for your own application, 
which can be used in the OAUTH2 [authentication procedure](../authentication.md).

**To perform the creation you need to be logged as a corporate customer.** 

### REQUEST:
    POST /api/v1/applications
### ARGUMENTS:

    The model: '{}'

### EXAMPLE

```bash
TOKEN="put your access token is here"
curl -X POST -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications
```

### RESPONSE:

