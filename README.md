[![Build Status](https://travis-ci.org/copernicusglobal/api.svg?branch=master)](https://travis-ci.org/copernicusglobal/api)


# General Information

Here we provide the information about Application Programming Interface (API) 
for Copernicus Gold services which enables you to create applications, to register users, to open accounts, to replenish
them and, of course, to send money to other people, organizations, etc.

We use the OAuth2 authentication scheme that means you need an access token to deal
with the API queries.

# API Endpoint

Currently, we use **https://testapi.copernicusgold.com/api/** as the **test** entry point for all API queries.

All examples here for API were prepared with *cUrl* utility which can be downloaded from: http://curl.haxx.se/download.html.

API requests should use **https** and provide the content type as JSON (application/json) or XML (application/xml). 
This depends on the headers "Accept" and "Content-Type" you use. The default type is JSON (if you didn't specify any
headers).

# API Specifications

1. [Authentication](./docs/authentication.md)
2. [API Reference](./docs/specification.md)
