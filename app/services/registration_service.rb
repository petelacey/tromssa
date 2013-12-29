class RegistrationService
  def register(reg, club, user)
    query = "
      MATCH
        (club:Club { short_name: {club_short_name} }), (u:User { username: {username} })
      CREATE
        (u)<-[:registered_by]-
        (g:Guardian {
          last_name: {guardian_last_name},
          first_name: {guardian_first_name}
        })
        -[:member]->(club)
      CREATE
        (a:Athlete {
          last_name: {athlete_last_name},
          first_name: {athlete_first_name}
        })
        -[:member]->(club)
      CREATE (g)-[:guardian]->(a)"

    params = {
      club_short_name: club.short_name,
      username: user.username,
      guardian_last_name: reg.guardian.last_name,
      guardian_first_name: reg.guardian.first_name,
      athlete_last_name: reg.athlete.last_name,
      athlete_first_name: reg.athlete.first_name
    }

    NEO.cypher(query, params)
  end

  def retrieve(club, user)
    query = "
      MATCH
        (user:User { username: {username} })
          <-[:registered_by]-
        (guardian:Guardian)
          -[:member]->
        (club:Club { short_name: {club_short_name} })
      MATCH
        (guardian)
          -[:guardian]->
        (athlete:Athlete)
      RETURN
        guardian,
        athlete"

    params = {
      username: user.username,
      club_short_name: club.short_name,
    }

    r = NEO.cypher(query, params)
    return nil if r.empty?
    Registration.new(r.first)
  end

  def club
    club = NEO.execute_query("MATCH (club:Club { short_name:'WVBBTS' }) RETURN club")["data"].first
  end
end
