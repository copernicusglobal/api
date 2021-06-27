
# General Information

Here we provide the information about the Application Programming Interface (API)
for [Copernicus Gold (**CG**)](https://www.copernicusgold.com) services which enables you to create applications, register users,
open accounts (wallets), replenish them, send funds to other people, organizations and even to create own
digital assets.


We use the OAuth2 authentication schema that means you need an access token to work
with the API queries (see the [Authentication](./docs/authentication.md) section).

# API Endpoints

Currently, we use **https://api.projectdgc.com/api/** as the **test** entry point for all API queries. In the
production mode the main host should be change to 'api.copernicusgold.com' instead of 'api.projectdgc.com'.
In all examples here we use the **$API_HOST** variable for substitution of this 'https://api.projectdgc.com' or
'https://api.copernicusgold.com'.

Several API operations connected mostly with the authorization are located on the authorization host.
In this case we use the **$AUTH_HOST** variable to denote 'https://auth.projectdgc.com' and
'https://auth.copernicusgold.com' for the test and production authorization server respectively.

All examples of the API here were prepared with *cUrl* utility that can be downloaded from http://curl.haxx.se/download.html
and usually is installed on most of OS platforms. The main reason to use it is to provide a clear way how exactly our
REST API works and all 'curl' commands can be easily converted to any other languages. 

API requests should use **https** and provide the content type as JSON (application/json) or XML (application/xml). 
This depends on the "Accept" and "Content-Type" headers you use. The default type is JSON (if you didn't specify any
headers).

In some example you may be asked to register via the web application. Please use the following url for **test** environment - 
https://web.projectdgc.com or https://web.copernicusgold.com for the production stage.

# API Specifications

1. [Application Registration](./docs/applications/registration.md)
2. [Authentication](./docs/authentication.md) and [Registration](./docs/registration.md)
3. [API Reference](./docs/specification.md)
4. [API Models](./docs/models/models.md)
