class CreateRegistration
  def initialize(registration)
    @registration = registration
  end

  def register
    club = NEO.execute_query("MATCH (club:Club { short_name:'WVBBTS' }) RETURN club")
    club = club["data"].first

    tx = NEO.begin_transaction

    guardian = NEO.create_node(@registration.guardian.attributes)
    NEO.add_label(guardian, "Guardian")

    athlete = NEO.create_node(@registration.athlete.attributes)
    NEO.add_label(athlete, "Athlete")

    NEO.create_relationship("member", club, guardian)
    NEO.create_relationship("member", club, athlete)
    NEO.create_relationship("guardian", guardian, athlete)
    
    NEO.commit_transaction(tx)

    @registration
  end
end
