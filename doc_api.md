#JSON API Endpoints

- GET `/products`

Will return a list of products available in local data store.

response: 
  HTTP OK 200
``` json
[
  {
    "id": 1,
    "name": "Hudson Wall Cup",
    "remote_id": "3DVqIYj4dOwwcKu6sgqOgg",
    "created_at": "2016-06-16T16:34:04.929Z",
    "updated_at": "2016-06-16T18:16:00.231Z",
    "slug": "hudson-wall-cup",
    "description": "Wall Hanging Glass Flower Vase and Terrarium",
    "size_type_color": "3 x 3 x 5 inches; 5.3 ounces",
    "price": 11,
    "quantity": 101,
    "sku": "B00E82D7I8",
    "website": "http://www.amazon.com/dp/B00E82D7I8/",
    "tag_values": [
      "vase",
      "flowers",
      "accessories"
    ]
  },
  {
    "id": 2,
    "name": "SoSo Wall Clock",
    "remote_id": "4BqrajvA8E6qwgkieoqmqO",
    "created_at": "2016-06-16T16:34:05.430Z",
    "updated_at": "2016-06-16T18:16:00.505Z",
    "slug": "soso-wall-clock",
    "description": "The newly released SoSo Clock from Lemnos.",
    "size_type_color": "10\" x 2.2\"",
    "price": 120,
    "quantity": 3,
    "sku": "B00MG4ULK2",
    "website": "http://store.dwell.com/soso-wall-clock.html",
    "tag_values": [
      "home décor",
      "clocks",
      "interior design",
      "yellow",
      "gifts"
    ]
  },
  {
    "id": 3,
    "name": "Whisk Beater",
    "remote_id": "6dbjWqNd9SqccegcqYq224",
    "created_at": "2016-06-16T16:34:05.896Z",
    "updated_at": "2016-06-16T18:16:00.748Z",
    "slug": "whisk-beater",
    "description": "A creative little whisk that comes in 8 different colors.",
    "size_type_color": "0.8 x 0.8 x 11.2 inches; 1.6 ounces",
    "price": 22,
    "quantity": 89,
    "sku": "B0081F2CCK",
    "website": "http://www.amazon.com/dp/B0081F2CCK/",
    "tag_values": [
      "accessories",
      "kitchen",
      "whisk",
      "scandinavia",
      "designssssss"
    ]
  },
  {
    "id": 4,
    "name": "Playsam Streamliner Classic Car, Espressooooooooooooooo",
    "remote_id": "5KsDBWseXY6QegucYAoacS",
    "created_at": "2016-06-16T16:34:06.345Z",
    "updated_at": "2016-06-16T18:15:59.952Z",
    "slug": "playsam-streamliner-classic-car-espresso",
    "description": "A classic Playsam design, the Streamliner Classic Car",
    "price": 44,
    "quantity": 56,
    "sku": "B001R6JUZ2",
    "website": "http://www.amazon.com/dp/B001R6JUZ2/",
    "tag_values": [
      "design",
      "wood",
      "toy",
      "car",
      "sweden"
    ]
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
