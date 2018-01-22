# API-CUPOM

## API to serve and manage promotions and coupons using Micro-services structure

The API-CUPOM was designed to be easy to integrate with another systems, taking
the responsibility of create, maintain and control the promotions data, and, specifically,
their respective coupons.

With API-COUPON, other systems will be able to burn coupons and generate reports of
the promotion's used coupons

### Getting a coupon
To request a new coupon based on a given promotion, use the route
/api/promotions/:id/next_coupon
Where the :id is the promotion unique id

This route is indicated when you try to get a new coupon, skipping validations.
For this other purpose, please, use the route:
```
/api/coupons/:coupon_code
```

Success
Status: 200

Not found:
Status: 404

Expired promotion:
Status: 403

### Example

Request: GET GET
/api/promotions/1/next_coupon

Response:
``` json
{
  "code":"VWMEF1F",
  "created_at":"2016-02-24T16:37:44.722Z",
  "updated_at":"2016-02-24T16:37:44.722Z",
  "discount":58.0,
  "promotion_path":"/api/promotions/1",
  "expired?":false,
  "burned?":false
}
```

Or, in order to test if a coupon is valid, is possible to use the following route:

```
/api/coupons/:coupon_code
```

Success
Status: 200

Not found:
Status: 404

Expired promotion:
Status: 200 (it has a flag indicating if the coupon was expired)

### Example:
Request: GET
```
/api/coupons/VWMEF1F
```
Response:
``` json
{
  "code":"VWMEF1F",
  "created_at":"2016-02-24T16:37:44.722Z",
  "updated_at":"2016-02-24T16:37:44.722Z",
  "discount":58.0,
  "promotion_path":"/api/promotions/1",
  "expired?":false,
  "burned?":false
}
```


### Listing promotions
To list all promotions: /api/promotions

### Example

Request: GET
```
/api/promotions
```
Response:
``` json
[
    {
        "id": 1,
        "title": "Kaleigh Hessel",
        "description": "waml7hwru2cpmrlq7nhslocrtt3225rpca2ndd1hb7e6opud6a52oi3p2meybxp6yc7lpnbzcbxxrv3h472lhf68x768w705rru1szve7sm4fmmglwyvojl82i6mmm837eezwut9ok185v1ui6fs70nbaq8mo0crq6yqgkhmhmliiofo1u198be77ypqngjq4m3e9jhelvfebyxhjy4ok9e0n5ox2i9zfmgcpf0zzfb1a1k65xvqqqgwii9wgse",
        "discount": 58,
        "start_at": "28/02/2016 16:37",
        "end_at": "04/03/2016 16:37",
        "prefix": "VWM",
        "quantity": 5,
        "created_at": "2016-02-24T16:37:44.684Z",
        "updated_at": "2016-02-24T16:37:44.684Z",
        "duration": 5,
        "promotion_path": "/api/promotions/1",
        "next_coupon_path": "/api/promotions/1/next_coupon"
    },
    {
        "id": 2,
        "title": "asdas",
        "description": "asdas",
        "discount": 1,
        "start_at": "2016-07-21T00:00:00.000Z",
        "end_at": "2016-07-22T00:00:00.000Z",
        "prefix": "weq",
        "quantity": 1,
        "created_at": "2016-02-24T19:07:14.355Z",
        "updated_at": "2016-02-24T19:07:14.355Z",
        "duration": 1,
        "promotion_path": "/api/promotions/2",
        "next_coupon_path": "/api/promotions/2/next_coupon"
    }
]

```

### Show a single promotion
Use the route:
```
/api/promotion/:id
```

### Example

Request: GET
```
/api/promotions/1
```
Response:
``` json
{
    "id": 1,
    "title": "Kaleigh Hessel",
    "description": "waml7hwru2cpmrlq7nhslocrtt3225rpca2ndd1hb7e6opud6a52oi3p2meybxp6yc7lpnbzcbxxrv3h472lhf68x768w705rru1szve7sm4fmmglwyvojl82i6mmm837eezwut9ok185v1ui6fs70nbaq8mo0crq6yqgkhmhmliiofo1u198be77ypqngjq4m3e9jhelvfebyxhjy4ok9e0n5ox2i9zfmgcpf0zzfb1a1k65xvqqqgwii9wgse",
    "discount": 58,
    "start_at": "2016-02-28T16:37:44.677Z",
    "end_at": "2016-03-04T16:37:44.677Z",
    "prefix": "VWM",
    "quantity": 5,
    "created_at": "2016-02-24T16:37:44.684Z",
    "updated_at": "2016-02-24T16:37:44.684Z",
    "duration": 5,
    "promotion_path": "/api/promotions/1",
    "next_coupon_path": "/api/promotions/1/next_coupon"
}
```

### Burning a coupon

In order to burn a coupon, use the following route:
```
/api/coupons/:code/burn
```

By this route, you must pass some parameters via post, via JSON:
``` json
{
  "client_name": "Client Complete Name",
  "salesman_name": "Salesman Complete Name",
  "discount_value": 10.0,
  "client_phone": "99999-5555"
}
```

Success
Status: 200

Not found:
Status: 404

Expired promotion:
Status: 403

Already burned coupon:
Status: 403

### Example

Request: POST
```
/api/coupons/:code/burn
```

Response:
``` json
{
    "id": 1,
    "client_name": "Client Complete Name",
    "client_phone": "'99999-5555'",
    "salesman_name": "'Salesman Complete Name'",
    "discount_value": 10,
    "coupon_id": 1,
    "created_at": "2016-02-29T17:23:29.773Z",
    "updated_at": "2016-02-29T17:23:29.773Z"
}
```
