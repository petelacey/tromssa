# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@neo = Neography::Rest.new

def club_exists?(short_name)
  bbts = @neo.execute_query("MATCH (bbts { shorter_name:'#{short_name}' }) RETURN bbts")
  !bbts["data"].empty?
end

if Rails.env == 'development'
  exit if club_exists?('BBTS')
  Neography::Node.create(
    name: 'Waterville Valley Black & Blue Trail Smashers',
    short_name: 'WVBBTS',
    shorter_name: 'BBTS'
  )
end
