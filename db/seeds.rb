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
         shorter_name: 'BBTS' }
      )
  ")
end
