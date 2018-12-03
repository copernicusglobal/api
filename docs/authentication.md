# General Concept

The authentication procedure in CG is based on [OAuth 2 protocol](https://tools.ietf.org/html/rfc6749) and
provides two main abilities to obtain an access token: *the authorization code flow* (mostly used for web applications)
and *the resource password flow* (usually used in the applications which are unable to work with html view, for instance,
mobile applications).

First of all, you need app\_id and app\_secret values which are unique for your application. If you have a corporate
account in CG, you can create your [own CG application](./applications/registration.md) and get
a pair app\_id/app\_secret.

The CG's authentication cycle has one principal distinction from other applications: the authentication is based on
usage of USSD or SMS services which interact with your final user as a secondary authentication factor.

*Please be aware the USSD channel may not operate for some regions or cellular carriers. In this case please
use the SMS channel.*

*During the authentication process the user is restricted by 3 attempts to enter the valid PIN or OTP.
After that, they will be blocked up to 5 minutes, then, if there are more wrong attempts, 15 minutes and so on
increasing the interval.*

# Authentication Code Flow

This scenario is generally used in web applications because it requires an interactive communication with
the authentication server and the user's browser. To start the flow you need to configure the valid *redirect\_url*
parameter for your application. (see [Applications](./applications/applications.md)).

Below, we consider examples of how the authentication process works. Different OAuth 2.0 Client implementations
hide most of these steps making the whole procedure much more simple for developers.

Please use the following endpoint for receiving an authorization code
(usually, you need to use this url string in the browser):

``` 
APP_ID=... app\_id ...
REDIRECT_URL=...

curl $AUTH_HOST/auth/oauth/authorize?response_type=code&client_id=$APP_ID&redirect_uri=$REDIRECT_URL&scope=full 
```

In the process of authentication users are redirected to the authorization server and they must choose
the authentication channel: SMS or USSD and then type their mobile phone number.

If the user chooses the USSD channel, an OTP is immediately sent to the mobile phone as a USSD request. The user
must enter this OTP in the field of the web form. If the user selects SMS, on the next step he or she
is asked to enter the PIN-code first on the web form.

This discrepancy of the algorithms is due to less safety of the SMS-based authentication. In this case we
make the user enter the PIN-code in a more secure zone - our authorization server. 

After that, in both cases the user is redirected back to the *redirect\_url* used in creation of the application.
An example of the redirection url:
```
   $REDIRECT_URL?code=JKrjHw
```

and for obtaining a token after receiving the code, please use the following request:
```

APP_ID=...app_id...
APP_SECRET=...app_secret...
CODE=... the code from the authentication server response ...
REDIRECT_URL=...

curl -X POST -H "Accept: application/json" \
             -d "client_id=$APP_ID&client_secret=$APP_SECRET&grant_type=authorization_code&code=$CODE&redirect_uri=$REDIRECT_URL" \
             $AUTH_HOST/auth/oauth/token
```

The result will look like this:
```javascript
{
  "access_token":"06935b2e-6639-4b49-8c8a-71452082a420",
  "token_type":"bearer",
  "refresh_token":"c01b926a-cf78-4b43-be92-5fe21ef712d0",
  "expires_in":1209599,
  "scope":"full",
  "client_id":"..."}
```

At this moment, you've got a token but the authentication procedure is not yet completed. All API operations will
return the 403 error. Please refer to the [check role query](#check-user-roles) in order to understand how
to check whether the authentication process has completed or not. 

#### USSD Authentication Completion

For the USSD authentication the user is asked to enter their PIN-code directly on the mobile phone via a USSD dialog.
You can track the user's roles as mentioned above or there is a way to receive the roles [via websockets](./websockets.md).
The roles will be 'ROLES\_USER` as the user enters the valid PIN.

If the user for some reasons does not receive a USSD request or occasionally closes the USSD dialog, you
can query for another USSD dialog using such a query:

```
curl -X PUT -H "Authorization: Bearer $TOKEN" -d "{}"  $API_HOST/api/v1/authentication/repeat
```

#### SMS Authentication Completion

For the SMS channel the user receives an OTP as SMS message. To finalize the authorization, you need to
invoke the following request with the OTP provided:

```
MODEL='{ "otp" : "..." }'

curl -X PUT -H "Authorization: Bearer $TOKEN" -d "$MODEL"   $API_HOST/api/v1/authentication/confirm
```

If the provided OTP is wrong, there is a way to send another OTP:
```
curl -X PUT -H "Authorization: Bearer $TOKEN" -d "{}"   $API_HOST/api/v1/authentication/otp
``` 

Please notify the user that the number of wrong OTP/PIN attempts is limited (see [the notice above](#general-concept)).



# Resource Password Flow

The main difference between this flow and the previous one is absence of interaction inside of a browser. This
approach can be applied not only for mobile applications but also for any integrated solutions that use some
embedded pieces of the CG platform. 

The authentication procedure starts with requesting an OTP:

### Querying an OTP
```bash
MODEL='{ "login":"79122437136",
         "auth_channel" : "SMS",
         "client_id": "myapplication" }'

curl -X PUT -d "$MODEL"  $AUTH_HOST/auth/api/v1/otp
```

The 'login' field requires the mobile phone number of the user. The 'auth\_channel' may have two possible
values: SMS or USSD. The last parameter - 'client\_id' is used when you need to receive SMS/USSD messages
specific to your applications. For example, instead of the standard SMS title of CG applications,e.g.
'Copernicus Gold: OTP #54: 9618' you may change to 'My Great Application: OTP #54: 9618'.

The 'client\_id' attribute means here the identifier of your application. Please refer to
the [application section](./applications/applications.md) and [provider section](./models/provider.md)
for more information on custom applications.

The generated OTP will be sent to the specified mobile phone number as a USSD or an SMS message.
After receiving the code can be used to obtain an access token from the authorization server:

### Obtaining a token
```bash

APP_ID=... the app_id of your application ...
APP_SECRET=... the app_secret of your application ...

BASIC=`echo -n "$APP_ID:$APP_SECRET" | base64`

PHONE="...mobile phone number..."
OTP_CODE="... OTP code from above ..."

curl -X POST -H "Accept: application/json" \
             -H "Authorization: Basic $BASIC" \
             -d "grant_type=password&username=$PHONE&password=$OTP_CODE&scope=full" \
             $AUTH_HOST/auth/oauth/token
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
  "client_id":"myapplication"}
```

As already discussed above, at this stage the token is not fully authorized. You can always check the current
authorization state by using the [role check query](#check-user-roles).

For the USSD channel, the further authentication technique is the same as above for the authentication code
flow. You need to use [the same as above](#ussd-authentication-completion).

But for SMS authentication, we change the algorithm comparing with the authentication code flow because
there is no browser interaction takes place.

To complete the authorization we need to provide the user's PIN-code. This can be done by the following
example:

```
curl -X PUT -H "Authorization: Bearer $TOKEN" -d '{"pin": "..."}' $AUTH_HOST/auth/api/v1/pin/check
```

After successful checking the PIN, the user will have enough roles.

For more examples please take a look at [authentication tests](../tests/authenticate_test.sh)
 
# Working With the Token

Once you have received an access token you can invoke API operations as HTTP REST queries providing the token value
in the headers of the query. 

### Check User Roles
For example:

```bash
TOKEN=06935b2e-6639-4b49-8c8a-71452082a420

curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/users/roles
```

The last example will return something like 'ROLE\_USER'. But if the user didn't complete the authentication process 
by entering the PIN-code (for USSD) or an OTP (for SMS), this 'roles' query would return a role like
'ROLE\_EXPECT\_PASSWORD' instead of 'ROLE\_USER'.

Also without entering the PIN code all the API functions return the **403 Forbidden Error** because the authentication 
has not been completed yet.

*In all examples here in the documentation we will denote a token as the $TOKEN variable.*
 
 
### Refresh Tokens 

A typical response to a token request looks like this:
```javascript
{
  "access_token":"06935b2e-6639-4b49-8c8a-71452082a420",
  "token_type":"bearer",
  "refresh_token":"c01b926a-cf78-4b43-be92-5fe21ef712d0",
  "expires_in":1209599,
  "scope":"full",
  "client_id":"myapplication"}
``` 


The provided access\_token will work in this example during the next 1209599 seconds (2 week) and will expire after.
By using the given refresh\_token you can receive a new access_token.

The expiration time of refresh_token is generally much longer than for the access\_token.

Use the following query to get a new access token by the refresh\_token:

```bash

REFRESH=c01b926a-cf78-4b43-be92-5fe21ef712d0
APP_ID=<..your app id..>
APP_SECRET=<..your app secret..>

curl -X POST -H "Accept: application/json" \
             -d "grant_type=refresh_token&client_id=$APP_ID&client_secret=$APP_SECRET&refresh_token=$REFRESH" \
             $AUTH_HOST/auth/oauth/token
```
 
 
# Mobile Applications - the Specific Logins

For mobile applications we can use more simple authentication technique if the user once has passed the full authentication
as described above. There is a wide-spread practice when users just enter their PIN via the digital keyboard
on their mobile phones. And no more actions. To support this we need to generate a special login linked to
the device ID which is used later during the authentication procedure.

At the first step, after a successful authentication we generate a login:

```bash

MODEL='{"device_id" : "1234567890"}'

curl -X POST -H "Content-Type: application/json" \
             -H "Authorization: Bearer $TOKEN"  \
             -d "$MODEL" $API_HOST/api/v1/logins
```

The result with a login:
```javascript
{
    "code" : 0,
    "login":"M06935b2e-6639-4b49-8c8a-71452082a420"
}
```

The returned login *M06935b2e-6639-4b49-8c8a-71452082a420* now can be used for authentication directly
with the user's PIN code in *a single step*. Use the following request to get an access token via
the obtained login:

```bash

BASIC=`echo -n "$APP_ID:$APP_SECRET" | base64`

PIN=... User's PIN ...
LOGIN=M06935b2e-6639-4b49-8c8a-71452082a420

curl -X POST -H "Accept: application/json" \
             -H "X-Device-Id: 1234567890" \
             -H "Authorization: Basic $BASIC" \
             -d "grant_type=password&username=$LOGIN&password=$PIN&scope=full" \
             $AUTH_HOST/auth/oauth/token
```

Take a look at usage of the "x-device-id" header. Without this identifier which was used to generate the login
the authentication will fail.
