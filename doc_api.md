#JSON API Endpoints

- GET `/products`

Will return a list of products available in local data store.

response: 
  HTTP OK 200
``` json
[
  {
    "id": 57,
    "name": "Hudson Wall Cup",
    "remote_id": "xxxxxxxxxxxxxxxxxxxxxx",
    "slug": "hudson-wall-cup",
    "description": "Wall Hanging Glass Flower Vase and Terrarium",
    "size_type_color": "3 x 3 x 5 inches; 5.3 ounces",
    "price": 11,
    "quantity": 101,
    "sku": "SKU444444",
    "website": "http://www.amazon.com/dp/SKU444444/",
    "categories": [
      {
        "id": 33,
        "remote_id": "xxxxxxxxxxxxxxxxxxxxxx",
        "title": "Home & Kitchen",
        "description": "Shop for furniture, bedding, bath, vacuums, kitchen products, and more"
      }
    ],
    "tags": [
      { "value": "vase" },
      { "value": "flowers" },
      { "value": "accessories" }
    ]
  },
  {
    "id": 58,
    "name": "SoSo Wall Clock",
    "remote_id": "xxxxxxxxxxxxxxxxxxxxxx",
    "slug": "soso-wall-clock",
    "description": "The newly released SoSo Clock from Lemnos marries simple, clean design.",
    "size_type_color": "10\" x 2.2\"",
    "price": 120,
    "quantity": 3,
    "sku": "SKU555555",
    "website": "http://store.dwell.com/soso-wall-clock.html",
    "categories": [
      {
        "id": 33,
        "remote_id": "xxxxxxxxxxxxxxxxxxxxxx",
        "title": "Home & Kitchen",
        "description": "Shop for furniture, bedding, bath, vacuums, kitchen products, and more."
      }
    ],
    "tags": [
      { "value": "home décor" },
      { "value": "clocks" },
      { "value": "interior design" },
      { "value": "yellow" },
      { "value": "gifts" }
    ],
    "asset": {
      "id": 83,
      "remote_id": "xxxxxxxxxxxxxxxxxxxxxx",
      "title": "SoSo Wall Clock",
      "description": "by Lemnos",
      "remote_file_url": "http://images.contentful.com/irjb6cmr6p6c/xxxxxxxxxxxxxxxxxxxxxx/5j5j5j5j5j5/soso.clock.jpg"
    }
  }
]
```


- GET `/products/sync_all`

Will update all local product records with data from Contentful API.

response: 
  HTTP OK 200


- GET `/products/reset_and_sync_all`

Will clear all the product records and repopulate them with data from Contentful API.

response: 
  HTTP OK 200
