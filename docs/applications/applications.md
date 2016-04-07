# Application Concept

Applications are a way to build your own services using the system and its abilities to store and to carry out
financial transactions using different assets including those you have created for your own goals.

1. [Creating a new application](#creating-new-application)
2. [Removing an Application](#removing-application)
3. [Editing an Application](#editing-application)
4. [Receiving Application Details](#getting-application-details)
5. [Getting All Applications](#getting-all-applications)

You can see some examples for these operations: [application_test](../../tests/applications_test.sh) 


# Creating New Application

This operation allows you to create an application and to receive app\_id and app\_secret from the server, which can be used
in the OAUTH2 [authentication procedure](../authentication.md).

**To perform the creation you need to be logged as a corporate customer.** 

### REQUEST:
    POST /api/v1/applications
### ARGUMENTS:

```
    The model: {"redirects" : ["http://localhost:8080", "https://www.com"] }
```
    The 'redirects' array must be filled with urls in the case when you use the web authorization flow and you need to
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
See, for example, [this test](../../tests/applications_test.sh)


# Removing Application

Performs removing of the specified application.

### REQUEST:
    DELETE /api/v1/applications/:app_id
### ARGUMENTS:

    app_id - the identifier of the application to be removed

### EXAMPLE

```bash
TOKEN="put your access token is here"
APP_ID=<..identifier..>
curl -X DELETE -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications/$APP_ID
```

### RESPONSE:

```javascript
  {
    "code":0,
    "created":"2016-04-03T14:06:58.620+0000",
    "app_id":"3a16d63129c94e7d93b0d0bb6a898691",
    "grant_types":["authorization_code","password","refresh_token"],
    "redirects":["http://localhost:8080", "https://www.com"]
  }
```

In the response you can see the model of the application being removed.

# Editing Application

You can also modify application's attributes using PUT requests with the same model as for
POST requests. The only difference is when you provide the app_secret value in the model you can
change the application's password.

### REQUEST:
    PUT /api/v1/applications
### ARGUMENTS:

```
    The model: { "redirects" : ["http://localhost:8080", "https://www.com"],
                 "app_secret" : "....." }
```
    The 'redirects' array must be filled with urls in the case when you use the web authorization flow and need to
    provide a callback url to make a redirection from the authorization server back to your application.
    
    The 'app_secret' is a new password for the application. 

### EXAMPLE

```bash
TOKEN="put your access token is here"
MODEL='{"redirects" : ["http://localhost:8080", "https://www.com" ], "app_secret": "xxx" }'
curl -X PUT -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications -d $MODEL
```

### RESPONSE:

```javascript
  {
    "code":0,
    "created":"2016-04-03T14:06:58.620+0000",
    "app_id":"3a16d63129c94e7d93b0d0bb6a898691",
    "grant_types":["authorization_code","password","refresh_token"],
    "redirects":["http://localhost:8080", "https://www.com"]
  }
```

# Receiving Application Details

Returns information about a concrete application by its identifier.

### REQUEST:
    GET /api/v1/applications/:app_id
### ARGUMENTS:

    app_id - the identifier of the application

### EXAMPLE

```bash
TOKEN="put your access token is here"
APP_ID=<..identifier..>
curl -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications/$APP_ID
```

### RESPONSE:

```javascript
  {
    "code":0,
    "created":"2016-04-03T14:06:58.620+0000",
    "app_id":"3a16d63129c94e7d93b0d0bb6a898691",
    "grant_types":["authorization_code","password","refresh_token"],
    "redirects":["http://localhost:8080", "https://www.com"]
  }
```

In the response you can see the model of the application.


# Getting All Applications

Returns a list of all applications available for the current customer (must be a corporate entity).

### REQUEST:
    GET /api/v1/applications
### ARGUMENTS:
    none
### EXAMPLE

```bash
TOKEN="put your access token is here"
curl -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications
```

### RESPONSE:

```javascript
[
  {
    "created":"2016-04-03T14:06:58.620+0000",
    "app_id":"3a16d63129c94e7d93b0d0bb6a898691",
    "grant_types":["authorization_code","password","refresh_token"],
    "redirects":["http://localhost:8080", "https://www.com"]
  },
  {
    "created":"2016-04-06T08:16:39.648+0000",
    "app_id":"e56800d31b294181851e504e4f4e25db",
    "grant_types":["authorization_code","password","refresh_token"],
    "redirects":[]
  },
  ...
]  
```

In the response you can see the model of the application.
