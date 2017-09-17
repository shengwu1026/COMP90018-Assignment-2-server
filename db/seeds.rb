# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

b = Building.create(
  name: 'Seed Building',
  address: {
    unit_number: '1A',
    street_number: '239',
    street_name: 'Parville Road',
    suburb: 'Parville',
    city: 'Melbourne',
    state: 'Victoria',
    post_code: '3052'
  },
  floor_levels: [
    {
      text: 'Ground Floor',
      int: 0,
      length: 100,
      width: 100,
      height: 3,
      units: 'Metres',
    },
    {
      text: 'First Floor',
      int: 1,
      length: 100,
      width: 100,
      height: 3,
      units: 'Metres',
    }
  ]
)

l = Lot.create(
  building_id: b.id,
  lot_type: 'Toilet',
  name: 'Ground Floor Section A Male Toilet',
  floor_level: 'Ground Floor',
  dimensions: {
      units: 'Metres',
      length: 50,
      width: 25,
      height: 3
  },
  rssi_1m_away_from_beacon: 10.0,
  average_phone_height: 1.5,
  path_loss: 2.0
)

b = 3.times.map{ Beacon.create(
  lot_id: l.id,
  manufacturer_uuid: SecureRandom.uuid,

  coordinates: {
    x: (10..100).to_a.sample,
    y: (10..100).to_a.sample
  },
  last_activity: Time.now,
  major: (10000..99999).to_a.sample,
  minor: (10000..99999).to_a.sample
)}

u = User.create(
  first_name: 'Seed',
  last_name: 'Seed',
  username: 'seed.seed@seeds.com',
  password: 'seedSecr3t'
)

lbc = LittleBrotherChip.create(
  user_id: u.id
)

loc = Location.create(
  little_brother_chip_id: lbc.id,
  lot_id: l.id,
  coordinates: {
    x: 10,
    y: 20
  }
)
