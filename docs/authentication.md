# General Concept

The authentication procedure in Copernicus Gold is based on [OAuth 2 protocol](https://tools.ietf.org/html/rfc6749) and
provides two main abilities to obtain an access token: *the authorization code flow* (mostly used in web applications)
and *the resource password flow* (usually used in the applications which are unable to work with html view, for instance,
mobile applications).

First of all, you need app\_id and app\_secret values which are unique for your application. If you have a corporate
account in Copernicus Gold (**CG**), you can create your [own CG application](./applications/registration.md) and get
a pair app\_id/app\_secret.

The CG authentication cycle has one principal distinction from other applications: the authentication is based on
the usage of USSD or SMS services which interact with your final user as a secondary authentication factor.

# Authentication Code Flow

This scenario is generally used in web applications because it requires interactive communication with the authentication
server and the user's browser. To start the flow you need to configure a valid *redirect_url* parameter for your
application. (see [Applications](./applications/applications.md))

# Resource Password Flow

The main difference between this flow and the previous one is absence of interaction inside of a browser. But still this
authentication scheme requires at least two http requests to get an access token. The first one performs checking
the provided mobile phone number and sends a one-time password (OTP) to the mobile phone, which is required for 
further authentication.

You need:

### Querying an OTP
```bash
curl -X PUT -d '{"login":"..phone number.."}'  $API_HOST/api/v1/otp
```

The generated password will be sent to the specified mobile phone number as a USSD message. After receiving the code it can be used
to obtain an access token from the authorization server. You need the following request:

### Obtaining a token
```bash
BASIC=base64("app_id:app_secret")
PHONE="...mobile phone number..."
OTP_CODE="... otp code from above ..."
curl -X POST -H "Authorization: Basic $BASIC" \
             -d "grant_type=password&username=$PHONE&password=$OTP_CODE&scope=full" \
             $API_HOST/auth/oauth/token
```

Here the 'username' is a user's mobile phone number and the 'password is a one-time password sent to you above. 
The example above will return something like this:

```javascript
{
  "access_token":"06935b2e-6639-4b49-8c8a-71452082a420",
  "token_type":"bearer",
  "refresh_token":"c01b926a-cf78-4b43-be92-5fe21ef712d0",
  "expires_in":1209599,
  "scope":"full",
  "client_id":"testapp"}
```

The provided access\_token will work in this example during the next 1209600 seconds (2 week) and will expire after. By using the given refresh\_token
you can receive a new access_token. The expiration time of refresh_token is generally much longer than for the 
access\_token.

Use the following query to get a new access token by the refresh\_token:

```bash
REFRESH=c01b926a-cf78-4b43-be92-5fe21ef712d0
APP_ID=<..your app id..>
APP_SECRET=<..your app secret..>
curl -X POST -d "grant_type=refresh_token&client_id=$APP_ID&client_secret=$APP_SECRET&refresh_token=$REFRESH" \
             $API_HOST/auth/oauth/token
```

The result will be the same as above in the case of receiving the first access token. For more details and examples please take a look
at [authentication tests](../tests/authenticate_test.sh)

**Important**

*The provided request gives you the tokens immediately but in the same time it sends a specific USSD menu to the specified 
mobile phone number and the user should enter the PIN code to get access to CG. 
This PIN code is always set during the initial registration in the system and the user knows it. 
If the user tries to close the menu due to some reasons, it will be impossible to complete the authentication and the procedure must start
from the very beginning*.
 
# Working With the Token

Once you have received an access token you can invoke an API operation as http query providing the token value in the headers of the query. 
For example:
```bash
TOKEN=06935b2e-6639-4b49-8c8a-71452082a420
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/users/roles
```

The last example will return something like 'ROLE\_USER'. But if the user didn't complete the authentication process 
by entering the PIN code in the USSD menu, this 'roles' query would return a role like 'ROLE\_EXPECT_PASSWORD' instead of 'ROLE\_USER'.
Also without entering the PIN code all the API functions return the **403 Forbidden Error** because the authentication 
has not been completed yet.

*In all examples here in the documentation we will denote a token as the $TOKEN variable.*
 
# Mobile Applications - the specific logins

For mobile applications we can use more simple authentication due to the wide-spread practice when users just enter
a short password via a digital keyboard of their mobile phones. And no more actions. To support this we need to generate
a special login linked to the device identifier which is used later during the authentication procedure.

At the first step we generate a login:

```bash
curl -X POST -H "Authorization: Bearer $TOKEN"  \
             -d '{"device_id" : "1234567890"}' $API_HOST/api/v1/logins
```

The result with the token:
```javascript
{"code" : 0, "login":"M06935b2e-6639-4b49-8c8a-71452082a420"}
```

The returned login *M06935b2e-6639-4b49-8c8a-71452082a420* now can be used for authentication directly in conjunction with
the user's PIN code. Use the following request to get an access token via the obtained login:

```bash
BASIC=base64("client_id:client_secret")
curl -X POST -H "X-Device-Id: 1234567890" \
             -H "Authorization: Basic $BASIC" \
             -d "grant_type=password&username=M06935b2e-6639-4b49-8c8a-71452082a420&password=PIN&scope=full" \
             $API_HOST/auth/oauth/token
```

Take a look at usage of the "x-device-id" header. Without this identifier which was used to generate the login
the authentication will fail.
