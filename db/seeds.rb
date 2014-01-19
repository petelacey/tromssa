# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def club_exists?(short_name)
  bbts = NEO.cypher("MATCH (bbts { shorter_name:'#{short_name}' }) RETURN bbts")
  !bbts.empty?
end

if Rails.env == 'development'
  exit if club_exists?('BBTS')
  bbts = NEO.cypher("
    CREATE
      (user:User { username: 'placey' })
      -[:belongs_to]->
      (club:Club {
         name: 'Waterville Valley Black & Blue Trail Smashers',
         short_name: 'WVBBTS',
         shorter_name: 'BBTS',
         logo_path: 'uploads/bbts/logo.jpg'}
      )
      -[:active_during]->
      (season:Season {
        start_date: '2013-10-01',
        end_date: '2014-03-31' }
      )

    CREATE
      (alpine:Sport { name: 'Alpine' })

    CREATE
      (freestyle:Sport { name: 'Freestyle' })

    CREATE
      (snowboard:Sport { name: 'Snowboard' })

    CREATE
      (xcountry:Sport { name: 'Cross Country' })

    CREATE
      (nordic:Sport { name: 'Nordic' })

    CREATE
      (jump:Sport { name: 'Ski Jumping' })

    CREATE
      (discount:DiscountConditions {
        member_status: 'new',
        register_before: '08-15' }
      )

    CREATE
      (season)-[:offering]->
      (mites:Program {
        name: 'Mitey Mites',
        age_group: '[5, 9]',
        conditions: '',
        description: 'Introductory race training for the young ones.' }
      )

      CREATE (mites)-[:trains_for]->(alpine)
      CREATE (mites)-[:trains_for]->(freestyle)

      CREATE (mites)-[:cost]->(n1:Price { unit: 'USD', value: '1350' })
      CREATE (mites)-[:cost]->(d1:Price { unit: 'USD', value: '1620' })<-[:applies_to]-(discount)

    CREATE
      (season)-[:offering]->
      (u10:Program {
        name: 'U10 Program',
        age_group: '[5, 9]',
        conditions: 'Coach recommnendation Required',
        description: 'Competive race training.' }
      )

      CREATE (u10)-[:trains_for]->(alpine)

      CREATE (u10)-[:cost]->(n2:Price { unit: 'USD', value: '1600' })
      CREATE (u10)-[:cost]->(d2:Price { unit: 'USD', value: '1920' })<-[:applies_to]-(discount)

    CREATE
      (season)-[:offering]->
      (u12:Program {
        name: 'U12 Program',
        age_group: '[10, 11]',
        conditions: '',
        description: 'Competive race training.' }
      )

      CREATE (u12)-[:trains_for]->(alpine)

      CREATE (u12)-[:cost]->(n3:Price { unit: 'USD', value: '1650' })
      CREATE (u12)-[:cost]->(d3:Price { unit: 'USD', value: '1980' })<-[:applies_to]-(discount)

    CREATE
      (season)-[:offering]->
      (freegroms:Program {
        name: 'Freestyle Groms Program',
        age_group: '[8, 9]',
        conditions: '',
        description: 'Lorem ibsom.' }
      )

      CREATE (freegroms)-[:trains_for]->(freestyle)

      CREATE (freegroms)-[:cost]->(n4:Price { unit: 'USD', value: '1350' })
      CREATE (freegroms)-[:cost]->(d4:Price { unit: 'USD', value: '1620' })<-[:applies_to]-(discount)

    CREATE
      (season)-[:offering]->
      (groms:Program {
        name: 'Groms Program',
        age_group: '[5, 9]',
        conditions: '',
        description: 'Lorem ibsom.' }
      )

      CREATE (groms)-[:trains_for]->(snowboard)

      CREATE (groms)-[:cost]->(n5:Price { unit: 'USD', value: '1350' })
      CREATE (groms)-[:cost]->(d5:Price { unit: 'USD', value: '1620' })<-[:applies_to]-(discount)

  ")
end
