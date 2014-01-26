module Tromssa
  module Storage
    module Neo
      class Club
        def sports_available(club, age)
          query = "
            MATCH
              (club:Club)-[:active_during]->(season:Season)-[:offering]->(program:Program)-[:trains_for]->(sport:Sport)
            WHERE
              club.short_name = {club_short_name}
            AND
              season.start_date >= {start_date}
            AND
              {athlete_age} >= program.age_group[0]
            AND
              {athlete_age} <= program.age_group[1]
            RETURN
              DISTINCT sport"

          params = {club_short_name: club.short_name,
                    athlete_age: age,
                    start_date: "2013-00-00"} # TODO: Make dynamic

          NEO.cypher(query, params)
        end
      end
    end
  end
end
