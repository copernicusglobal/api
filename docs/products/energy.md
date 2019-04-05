# Renewable Energy API

CG as a platform may be used for the tasks of issuance of the currencies backed by electric energy produced
by some external sources, for example, the renewable energy sources. In this case we operate with special types of currencies
measured in kilowatt-hours or megawatt-hours. The latter is used by Reneable Energy Certicates (REC).

For such projects we utilize the data coming from some real devices, meters.

1. [Retrieving Devices](#1-retrieving-devices)
2. [Loading Transaction for Devices](#2-loading-energy-transactions-for-a-device)
3. [Daily Aggregations for Transactions](#3-loading-energy-transaction-groupped-by-days)
4. [Loading RECs](#4-loading-recs)
5. [List of Transactions for a REC](#5-retrieving-transaction-for-the-given-rec)


## 1. Retrieving Devices 

From the point of CG all devices are sort of external sources used for issuing electronic assets.

### REQUEST:
```bash
GET /api/v1/energy/sources?page=...&per_page=...
```

### ARGUMENTS:
       
  * **page** - The number of the page to retrieve
  * **per_page** - The number of records to have per page
       
       
### EXAMPLES:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/energy/sources?page=0&per_page=25
```

### RESPONSE:
```json
[
    {
            "total": 57,
        
            "id": 49912057,
            "created": "2019-02-20T17:17:42.106+0000",
            "modified": "2019-04-05T03:16:49.747+0000",
            "name": "Hill Valley Site - Revenue Meter",
            "external_id": "5c38b26915d03d01774f0921",
            "node_type": "meter",
            "state": "active",
            "type": "solar",
            "parent": {
                "id": 49912055,
                "created": "2019-02-20T17:17:42.085+0000",
                "external_id": "5c38b26915d03d01774f0920",
                "modified": "2019-02-27T07:28:47.288+0000",
                "name": "Hill Valley Site",
                "node_type": "site",
                "state": "active",
                "type": "site"
            },
            "rec_number": 2184,
            "rec_sum": 19.000436789,
            "new_number": 3,
            "new_sum": -2.9167e-05,
            "without_rec_number": 25,
            "without_rec_sum": 0.331558
        },
        
        ...
]
```

Here are the details of not obvious fields:

* **total** - the total number of records returned by this query. This is a common field for most of the responses which
return arrays.
* **external_id** - the ID of the source (actually, the device) in the external system. 
* **type**, **node_type**, **state**, **name** - some specific characteristics of the device.
* **parent** - the details of the parent device if exists. Sometimes the devices may have an hierarchy.
* **rec_number** and **rec_sum** - the number and the total amount of energy transactions read from the source and
linked to a REC.
* **without_rec** and **without_rec_sum** - the number and the total amount of energy transactions which have not yet
linked to a REC.
* **new_number** and **new_sum** - the number of the amount for transactions which have not yet been processed. Usually,
they include negative values which depict consumption of energy during the night periods.


## 2. Loading Energy Transactions for a Device

This request allows to get all transactions accounted for the given device.

### REQUEST:
```bash
GET /api/v1/energy/attributions/{deviceId}?page=...&per_page=...
```

### ARGUMENTS:

* **deviceId** - the ID of the device. It can be both the internal ID (the 'id' field) or the external ID (the 'external_id' field).
* **page** - the number of the page to retrieve
* **per_page** - the number of items per page

### EXAMPLES:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/energy/attributions/5c38b26915d03d01774f0921?page=0&per_page=25
```

### RESPONSE:

```json
[
  {
        "total": 2224,

        "block_id": "207684104eceee2a2eee7baf9633fd9e36da89fd3829f766824bec7f75dbba29",
        "carbon_offset": -8.822867e-06,
        "created": "2019-03-15T14:16:10.749+0000",
        "effective_time": "2019-03-15T11:00:00.000+0000",
        "external_id": "5c8bb3a20495c9baf67290c5",
        "hash": "4d53ac05489db651349433724b82deb1ef88193bd4bc49437f914b3f5191c0d2",
        "height": 2049470,
        "id": 51859849,
        "modified": "2019-03-16T04:19:58.501+0000",
        "rec": {
            "created": "2019-03-16T04:19:58.349+0000",
            "hash": "e3aa1899d598f1276b1f22abe6515cd5991974663bd53eceb23723572706ecc0",
            "height": 2052327,
            "id": 51889502,
            "modified": "2019-03-16T04:20:22.526+0000",
            "state": "Processed",
            "state_changed": "2019-03-16T04:20:22.519+0000",
            "value": 1.0
        },
        "state": "Processed",
        "state_changed": "2019-03-15T16:21:47.170+0000",
        "value": 0.012312
    },
    ...
]
```

* **total** - the total number of returned items
* **block_id** - the ID of the block in the external system where the given energy transaction was registered (if applicable)
* **effective_time** - the time when this metering was measured (in UTC)
* **external_id** - the ID of this energy transaction in the source system
* **hash** - the hash of the transaction after placing it to the CG's blockchain
* **height** - the height of the CG blockchain's block where the transaction is located
* **rec** - a REC associated with the given transaction. Please see [the fields description below](#4-loading-recs)
* **state** - the state of the transaction. It can be 'New' (just registered), 'Pending' (expects a confirmation from the blockchain network),
  'Processed' (a confirmation has been received, the transaction has been placed to the blockchain) 
* **value** - the measured value in MWh


## 3. Loading Energy Transaction Groupped by Days

From the point of reconciliations there is a need to calculate aggregated transaction reports by days. This allows to see
how many transactions where loaded per day and which the value was produced.

### REQUEST:

```bash
GET 'api/v1/energy/attributions/{deviceId}/daily?page=...&per_page=...'
```

### ARGUMENTS:

* **deviceId** - the ID of the device. It can be both the internal ID (the 'id' field) or the external ID (the 'external_id' field).
* **page** - the number of the page to retrieve
* **per_page** - the number of items per page

### EXAMPLE:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/energy/attributions/5c38b26915d03d01774f0921/daily?page=0&per_page=25
```

### RESPONSE

```json
[
    {
        "effective_time": "2019-04-05T00:00:00.000+0000",
        "number": 4,
        "state": "New",
        "total": 106,
        "value": -4.2e-05
    },
    {
        "effective_time": "2019-04-05T00:00:00.000+0000",
        "number": 2,
        "state": "Processed",
        "total": 106,
        "value": 0.008884
    },
    {
        "effective_time": "2019-03-31T00:00:00.000+0000",
        "number": 22,
        "rec": {
            "created": "2019-04-01T07:16:40.072+0000",
            "hash": "11a1cb7e2f51b7f78cdde232980fd7a7ae89de21384c166699805904311fb6fa",
            "height": 2143817,
            "id": 52886152,
            "modified": "2019-04-01T07:41:41.815+0000",
            "state": "Processed",
            "state_changed": "2019-04-01T07:41:41.762+0000",
            "value": 1.0
        },
        "state": "Processed",
        "total": 106,
        "value": 0.166221
    },
    ...    
]
```

* **total** - the total number of items in the array
* **effective_time** - the day when this aggregation was done
* **number** - the number of metering loaded at the day
* **state** - the state of processing (a generation of currency) for energy transactions. For the same effective_time
  there can be two records with 'New' and 'Processed' states in order to show that this day may have still unprocessed transactions.
* **value** - the summed up total value generated at the day.
* **rec** - a REC associated with the given number of transaction at the day. See [the REC fields below](#4-loading-recs)

## 4. Loading RECs

There is a way to retrieve all renewable energy certificates (REC) belonging to current customer.

### REQUEST

```bash
GET 'api/v1/energy/recs?page=...&per_page=...'
```

### ARGUMENTS

* **page** - the number of the page to retrieve
* **per_page** - the number of items per page

### EXAMPLE

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/energy/recs?page=0&per_page=25
```

### RESPONSE

```json
[
    {
        "created": "2019-03-14T07:56:09.822+0000",
        "hash": "27e4e77394541517491572dc444d6f913e3d0147f57314d9218c7c92305d027c",
        "height": 2041754,
        "id": 51647908,
        "modified": "2019-03-14T07:56:26.708+0000",
        "state": "Processed",
        "state_changed": "2019-03-14T07:56:26.701+0000",
        "total": 125,
        "value": 1.0
    },
    
    ...
]
```

* **total** - the total number of items
* **hash** - the hash of the corresponding blockchain transaction
* **height** - the height of the block in the blockchain where the REC was placed
* **state** - the state of the REC. It can be 'New' (just created), 'Pending' (expecting a confirmation from the blockchain),
  'Processed' (the confirmation received)
* **value** - the nominee value of the REC (1 MWh usually)

## 5. Retrieving Transaction for the Given REC

This request allows to check which transactions are included to the given REC.


### REQUEST

```bash
GET 'api/v1/energy/recs/{id}?page=0&per_page=50'
```

### ARGUMENTS

* **id** - the ID of the REC
* **page** - the number of the page to retrieve
* **per_page** - the number of items per page

### EXAMPLE

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/energy/recs/52882650?page=0&per_page=25
```

### RESPONSE

```json
{
    "code": 0,
    "created": "2019-04-01T06:15:46.538+0000",
    "hash": "17e9d97172c78798bbc90a85f72ff3b7a33c28a6584cea74a8fd7ce37516bfd4",
    "height": 2143498,
    "id": 52882650,
    "modified": "2019-04-01T06:18:38.041+0000",
    "state": "Processed",
    "state_changed": "2019-04-01T06:18:37.894+0000",
    "transactions": [
        {
            "block_id": "remainder",
            "created": "2019-03-27T21:24:15.164+0000",
            "effective_time": "2019-03-27T19:00:00.000+0000",
            "external_id": "5c9be80d919d9652bcb6736c",
            "id": 52705138,
            "modified": "2019-04-01T06:15:48.518+0000",
            "state": "Processed",
            "value": 0.002833
        },
        {
            "block_id": "86797680ce300b81d57aa61421a611363f2998e99412f401976797931c4af4af",
            "carbon_offset": 0.011157012705,
            "created": "2019-03-27T23:16:25.318+0000",
            "effective_time": "2019-03-27T20:00:00.000+0000",
            "external_id": "5c9c0430e5771ba76eab6884",
            "hash": "5bf2f1ce1419e8490dac16985405d9bdac4dad84e6ad9d35c169ed1160cc4909",
            "height": 2118781,
            "id": 52710223,
            "modified": "2019-04-01T06:15:48.518+0000",
            "state": "Processed",
            "state_changed": "2019-03-27T23:24:31.022+0000",
            "value": 0.01229
        },
        
        ...
    ]
}
```

* The fields **hash**, **height**, **state** have the same meaning as in [the previous request](#4-loading-recs).
* **transactions** - a list of energy transactions which are included to the REC. The fields are the same as described for
  [transactions above](#2-loading-energy-transactions-for-a-device).


Because a REC is issued after achieving the value of 1 MWh, there can be always the **remainder** - an excessive amount
of energy that cannot be included to the REC but stayed from the last energy transaction used for building this REC.
In this case we create a service energy transaction which value is equals to the remainder. Such transactions can be
seen in this report because they have the block_id field equals to the 'remainder' value.
  
Such remainders should not be included in calculation of generated energy because they already belong to a transaction.
But they can be used for some special reconciliation.
