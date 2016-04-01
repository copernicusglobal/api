#!/bin/sh

source ./tests/functions

#
# Creating an application:  /api/v1/applications
#
testCreateApplication() {

   # Obtaining a DEMO token
   getTestToken

   # Switching to a corporate entity
   switchToCorporate

   # Creating an application
   MODEL='{}'
   rs=`curl -s -X POST -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications -d $MODEL`
   echo "Created App:"
   echo $rs | jq

   APP_ID=$(echo $rs | jq .app_id | trim)
   APP_SECRET=$(echo $rs | jq .app_secret | trim)

   assertNotNull $APP_ID
   assertNotNull $APP_SECRET

   assertEquals '"authorization_code"' $(echo $rs | jq '.grant_types[0]')
   assertEquals '"password"' $(echo $rs | jq '.grant_types[1]')   
   assertEquals '"refresh_token"' $(echo $rs | jq '.grant_types[2]')

   # Now trying to authenticate in the Application
   buildBasic $APP_ID $APP_SECRET

   rs=`curl -s -X POST -H 'Accept: application/json' -H 'Content-Type: application/x-www-form-urlencoded' -H "Authorization: Basic $BASIC" -d "grant_type=password&username=$USER_DEMO&password=$USER_PWD&scope=full" https://testapi.copernicusgold.com/auth/oauth/token`

   local TKN=$(echo $rs | jq .access_token | trim)

   rs=`curl -s -X GET -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TKN" https://testapi.copernicusgold.com/api/v1/users`
   
   # If all is OK
   assertEquals 0 $(echo $rs | jq .code)
   assertEquals '"demo"' $(echo $rs | jq .name)
}

#
# Update Application:  /api/v1/applications
#

xxxtestUpdateApplication() {

   # Creating an application
   testCreateApplication

   # Changing the password (secret) and redirects
   MODEL='{ "redirects":"http://localhost/login", "app_secret"}'
   rs=`curl -s -X PUT -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/applications -d $MODEL`
   
   echo "Updated App: $rs"  
}

. shunit2-source/2.1.6/src/shunit2
