module Tromssa
  module Storage
    module Neo
      class Club
        # TODO: Make this query sensitive to athlete's birthday
        def sports_available(club)
          query = "
            MATCH
              (club:Club)-[:active_during]->(season:Season)-[:offering]->(Porgram)-[:trains_for]->(sport:Sport)
            WHERE
              club.short_name = {club_short_name}
            AND
              season.start_date >= {start_date}
            RETURN
              DISTINCT sport"

          params = {club_short_name: club.short_name,
                    start_date: "2013-00-00"} # TODO: Make dynamic

          NEO.cypher(query, params)
        end
      end
    end
  end
end
