class RegistrationService
  def register(reg, club, user)

    NEO.cypher("
      MATCH
        (club:Club { short_name: '#{club.short_name}' }), (u:User { username:'#{user.username}' })
      CREATE
        (u)<-[:belongs_to]-
        (g:Guardian {
          last_name:'#{reg.guardian.last_name}',
          first_name:'#{reg.guardian.first_name}'
        })
        -[:member]->(club)
      CREATE
        (a:Athlete {
          last_name:'#{reg.athlete.last_name}',
          first_name:'#{reg.athlete.first_name}'
        })
        -[:member]->(club)
      CREATE (g)-[:guardian]->(a)
    ")

    reg
  end

  def retrieve(club, user)
    r = NEO.cypher("
          MATCH
            (user:User { username:'#{user.username}' })
              <-[:belongs_to]-
            (guardian:Guardian)
              -[:member]->
            (club:Club { short_name:'#{club.short_name}' })
          MATCH
            (guardian)
              -[:guardian]->
            (athlete:Athlete)
          RETURN
            guardian,
            athlete
        ")
    return nil if r.empty?
    Registration.new(r.first)
  end

  def club
    club = NEO.execute_query("MATCH (club:Club { short_name:'WVBBTS' }) RETURN club")["data"].first
  end
end
