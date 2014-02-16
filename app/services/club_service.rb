class ClubService
  attr_accessor :storage

  def initialize(storage, club)
    @storage = storage.club
    @club = club
  end

  def get_programs(birth_date)
    dob = Date.parse(birth_date)
    storage.programs_available(@club, age(dob))
  end

  private

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
