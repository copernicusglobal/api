# User Roles and Permissions

Returns the current user's roles which can be used to restrict access in your interface according to user's permissions.
For example, if the user has not yet entered the PIN.

### REQUEST:
```
    GET /api/v1/users/roles
```
### ARGUMENTS:
       none
### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/users/roles
```

### RESPONSE:
1. ["ROLE\_USER"] - for a fully authenticated user
2. ["ROLE\_EXPECT\_PASSWORD"] - in the case when the system is still expecting entering the PIN code.
3. ["ROLE\_SET\_PASSWORD"] - when the system is expecting to set a new PIN during the registration procedure
