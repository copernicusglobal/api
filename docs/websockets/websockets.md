# WebSocket Support

In order to start a new websocket session you need to query a JWT token from an authenticated session.
It means that you must complete the authentication before 
(please refer to [the authentication section](../authentication.md)).

You can request a new JWT token:

```
curl -H "Authorization: Bearer $TOKEN" $AUTH_HOST/auth/api/v1/jwt
```

The result will be something like that:
"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMjdmM2JlNy02YWY2LTQ2MjMtOTVlOC1mODVkMzg4MWVhZjIiLCJleHAiOjE1NDM4MTU1OTEsImNsaWVudElkIjoiN2UwMWFiYzBiMWJmODNlM2NlOTViZmRiNjYzNjc0YTc3MjQ5ZDE4YjMxZTc2MGMyNTI0M2U1MGNkZGJhNmU4YSJ9.vT34fVwWspTiOspfhtfK91Z3MTUdFQyM6SJSDUiT-N94uGaKTOyr5nlLBaKYWdZPLQ2RxNbEvt4_dje89OIrpw"

This JWT token can be used to create new subscriptions on the websocket server.
Let's denote the websocket as $WS_HOST variable.

For the test stage, WS_HOST=https://testws.copernicusgold.com/ws. 

After establishing a new connection to the websocket server, you can subscribe on some topics providing
the JWT token in the 'jwt' header.

Currently, we support the following topics:

1. `/auth/topic/events` for common messages (like a notification on changed user roles)
2. `/exchange/exchange.rate` for notification on changed exchange rates.


