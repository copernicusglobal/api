# Application Concept

Applications are a way to build your own services using the system and its opportunities to store and to carry out
financial transactions using different assets including those you have created for your own goals.

1. [Creating a new application](#creating-new-application)


# Creating New Application

This operation allows you to create an application and to obtain app\_id and app\_secret for it, which can be used
in the OAUTH2 [authentication procedure](../authentication.md).

**To perform the creation you need to be logged as a corporate customer.** 

### REQUEST:
    POST /api/v1/applications
### ARGUMENTS:

```
    The model: {"redirects" : ["http://localhost:8080", "https://www.com"] }
```
    The 'redirects' array must be filled with urls in the case when you use the web authorization flow and need to
    provide a callback url to make a redirection from the authorization server back to your application. 

### EXAMPLE

```bash
TOKEN="put your access token is here"
MODEL='{"redirects" : ["http://localhost:8080", "https://www.com" ] }'
curl -X POST -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications -d $MODEL
```

### RESPONSE:

```javascript
  {
    "code":0,
    "created":"2016-04-03T14:06:58.620+0000",
    "app_id":"3a16d63129c94e7d93b0d0bb6a898691",
    "app_secret":"18fa73f6ab8c45779c1c66de6a6ede1d",
    "grant_types":["authorization_code","password","refresh_token"],
    "redirects":["http://localhost:8080", "https://www.com"]
  }
```

Now, you can provide for your clients the opportunity to login via your own application using the given app\_id and app\_secret.
See, for example, [this test](../tests/applications_test.sh)

