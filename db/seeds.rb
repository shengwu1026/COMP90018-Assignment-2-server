Building.create({
      "id": "4631e89b-2948-485c-b48c-cead1673b067",
      "address": {
        "city": "Geelong",
        "state": "Victoria",
        "suburb": "Geelong",
        "post_code": 3000,
        "street_name": "Street",
        "unit_number": "0",
        "street_number": "0"
      },
      "name": "Phillip's House",
      "floor_levels": [
        {
          "int": 0.0,
          "text": "Ground Floor",
          "units": "Metres",
          "width": 100.0,
          "height": 3.0,
          "length": 100.0
        }
      ],
      "created_at": "2017-09-30 15:56:45 +1000",
      "updated_at": "2017-09-30 15:56:45 +1000"
})

Lot.create({
      "id": "b2596dd9-e207-49c2-ba92-252802fdb567",
      "building_id": "4631e89b-2948-485c-b48c-cead1673b067",
      "lot_type": "Bedroom",
      "name": "Phillip's Room",
      "floor_level": 0,
      "dimensions": {
        "units": "metres",
        "width": 4.93,
        "height": 2.4,
        "length": 7.1
      },
      "created_at": "2017-09-30 15:57:26 +1000",
      "updated_at": "2017-09-30 15:57:26 +1000"
})

Beacon.create([
    {
      "id": "0b2e0762-7e7d-476a-8f33-0967f67d8d6c",
      "lot_id": "b2596dd9-e207-49c2-ba92-252802fdb567",
      "manufacturer_uuid": "b9407f30-f5f8-466e-aff9-25556b57fe6d",
      "major": 63689,
      "minor": 23053,
      "coordinates": {
        "x": -2.98,
        "y": 1.64
      },
      "last_activity": nil,
      "created_at": "2017-09-30 15:57:58 +1000",
      "updated_at": "2017-09-30 15:57:58 +1000"
    },
    {
      "id": "1e729fc5-923f-489f-894a-e65dce0faa48",
      "lot_id": "b2596dd9-e207-49c2-ba92-252802fdb567",
      "manufacturer_uuid": "b9407f30-f5f8-466e-aff9-25556b57fe6d",
      "major": 22175,
      "minor": 6525,
      "coordinates": {
        "x": 0.0,
        "y": 0.0
      },
      "last_activity": nil,
      "created_at": "2017-09-30 15:58:19 +1000",
      "updated_at": "2017-09-30 15:58:19 +1000"
    },
    {
      "id": "78981bb2-bf53-47a9-a65a-a8fe27b5ceb8",
      "lot_id": "b2596dd9-e207-49c2-ba92-252802fdb567",
      "manufacturer_uuid": "b9407f30-f5f8-466e-aff9-25556b57fe6d",
      "major": 54350,
      "minor": 21775,
      "coordinates": {
        "x": 2.48,
        "y": -2.2
      },
      "last_activity": nil,
      "created_at": "2017-09-30 15:58:37 +1000",
      "updated_at": "2017-09-30 15:58:37 +1000"
    }
 ])

User.create(
      "id": "1dc7488f-bd72-4f95-9c23-1f383fde7faa",
      "username": "phillip",
      "password_digest": "$2a$10$wwhoumnWt1i4TRYW5lbXmuWlmPgZ2rXeX4Di3RF5SYl2X1WTLTb8W",
      "first_name": "Phillip",
      "last_name": "M",
      "created_at": "2017-09-30 15:56:18 +1000",
      "updated_at": "2017-09-30 15:56:18 +1000")

LittleBrotherChip.create(
      "id": "92dd88b8-6df7-48a7-91ef-33dbf5ccc5de",
      "user_id": "1dc7488f-bd72-4f95-9c23-1f383fde7faa",
      "created_at": "2017-09-30 15:58:56 +1000",
      "updated_at": "2017-09-30 15:58:56 +1000")

Location.create(
    little_brother_chip_id: LittleBrotherChip.first.id,
    lot_id: Lot.first.id,
    coordinates: {
        x: 10,
        y: 20
    })
