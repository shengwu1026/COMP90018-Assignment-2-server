# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

b = Building.create([
    {
      "id": "99d2f1f0-0db1-47ae-be14-4ce034682afa",
      "address": {
        "city": "Melbourne",
        "state": "Victoria",
        "suburb": "Parville",
        "post_code": "3052",
        "street_name": "Parville Road",
        "unit_number": "1A",
        "street_number": "239"
      },
      "name": "Seed Building",
      "floor_levels": [
        {
          "int": 0.0,
          "text": "Ground Floor",
          "units": "Metres",
          "width": 100.0,
          "height": 3.0,
          "length": 100.0
        },
        {
          "int": 1.0,
          "text": "First Floor",
          "units": "Metres",
          "width": 100.0,
          "height": 3.0,
          "length": 100.0
        }
      ],
      "created_at": "2017-09-30 15:54:46 +1000",
      "updated_at": "2017-09-30 15:54:46 +1000"
    },
    {
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
    }
  ])

Lot.create([
    {
      "id": "3cd4e25f-da10-4a4d-83a7-da4bd4cf83a7",
      "building_id": "99d2f1f0-0db1-47ae-be14-4ce034682afa",
      "lot_type": "Toilet",
      "name": "Ground Floor Section A Male Toilet",
      "floor_level": 0,
      "dimensions": {
        "units": "Metres",
        "width": 25.0,
        "height": 3.0,
        "length": 50.0
      },
      "rssi_1m_away_from_beacon": 10.0,
      "average_phone_height": 1.5,
      "path_loss": 2.0,
      "created_at": "2017-09-30 15:54:46 +1000",
      "updated_at": "2017-09-30 15:54:46 +1000"
    },
    {
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
      "rssi_1m_away_from_beacon": -59.0,
      "average_phone_height": 1.0,
      "path_loss": 0.5,
      "created_at": "2017-09-30 15:57:26 +1000",
      "updated_at": "2017-09-30 15:57:26 +1000"
    }
  ])

# b = 3.times.map{ Beacon.create(
#   lot_id: l.id,
#   manufacturer_uuid: SecureRandom.uuid,
#
#   coordinates: {
#     x: (10..100).to_a.sample,
#     y: (10..100).to_a.sample
#   },
#   last_activity: Time.now,
#   major: (10000..99999).to_a.sample,
#   minor: (10000..99999).to_a.sample
# )}

Beacon.create([
    {
      "id": "74ba9a5a-aa7a-469c-9d8e-5269704af912",
      "lot_id": "3cd4e25f-da10-4a4d-83a7-da4bd4cf83a7",
      "manufacturer_uuid": "026a5f1d-4fd2-4fd6-9113-b2f9926eb2f3",
      "major": 99885,
      "minor": 49989,
      "coordinates": {
        "x": 91.0,
        "y": 79.0
      },
      "last_activity": "2017-09-30 15:54:46 +1000",
      "created_at": "2017-09-30 15:54:46 +1000",
      "updated_at": "2017-09-30 15:54:46 +1000"
    },
    {
      "id": "63842110-f068-412e-b828-098dfd68077a",
      "lot_id": "3cd4e25f-da10-4a4d-83a7-da4bd4cf83a7",
      "manufacturer_uuid": "0283de7a-cdff-43c6-aa54-be3543eaf511",
      "major": 44310,
      "minor": 41427,
      "coordinates": {
        "x": 16.0,
        "y": 23.0
      },
      "last_activity": "2017-09-30 15:54:46 +1000",
      "created_at": "2017-09-30 15:54:46 +1000",
      "updated_at": "2017-09-30 15:54:46 +1000"
    },
    {
      "id": "947c8b2f-e32f-40b0-8d40-deceeca9bb66",
      "lot_id": "3cd4e25f-da10-4a4d-83a7-da4bd4cf83a7",
      "manufacturer_uuid": "ad48a090-7d3d-4158-8a31-4c4a576f9390",
      "major": 21190,
      "minor": 86707,
      "coordinates": {
        "x": 36.0,
        "y": 84.0
      },
      "last_activity": "2017-09-30 15:54:46 +1000",
      "created_at": "2017-09-30 15:54:46 +1000",
      "updated_at": "2017-09-30 15:54:46 +1000"
    },
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

# u = User.create(
#   first_name: 'Seed',
#   last_name: 'Seed',
#   username: 'seed.seed@seeds.com',
#   password: 'seedSecr3t'
# )
User.create([
    {
      "id": "dd8b30bd-5386-4542-b6a9-558a706907ca",
      "username": "seed.seed@seeds.com",
      "password_digest": "$2a$10$REIRGfjkvSKqxEPpAoBCb.s8VvAjUgnwtC1gYAHm5TUZFuMPjhD6m",
      "first_name": "Seed",
      "last_name": "Seed",
      "created_at": "2017-09-30 15:54:47 +1000",
      "updated_at": "2017-09-30 15:54:47 +1000"
    },
    {
      "id": "1dc7488f-bd72-4f95-9c23-1f383fde7faa",
      "username": "phillip",
      "password_digest": "$2a$10$wwhoumnWt1i4TRYW5lbXmuWlmPgZ2rXeX4Di3RF5SYl2X1WTLTb8W",
      "first_name": "Phillip",
      "last_name": "M",
      "created_at": "2017-09-30 15:56:18 +1000",
      "updated_at": "2017-09-30 15:56:18 +1000"
    }
  ])

# lbc = LittleBrotherChip.create(
#   user_id: u.id
# )
LittleBrotherChip.create([
    {
      "id": "dadea582-1a17-44f9-b932-6093a33098d1",
      "user_id": "dd8b30bd-5386-4542-b6a9-558a706907ca",
      "created_at": "2017-09-30 15:54:47 +1000",
      "updated_at": "2017-09-30 15:54:47 +1000"
    },
    {
      "id": "92dd88b8-6df7-48a7-91ef-33dbf5ccc5de",
      "user_id": "1dc7488f-bd72-4f95-9c23-1f383fde7faa",
      "created_at": "2017-09-30 15:58:56 +1000",
      "updated_at": "2017-09-30 15:58:56 +1000"
    }
  ])

# loc = Location.create(
#   little_brother_chip_id: lbc.id,
#   lot_id: l.id,
#   coordinates: {
#     x: 10,
#     y: 20
#   }
# )
