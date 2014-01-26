class ClubService
  attr_accessor :storage

  def initialize(storage, club)
    @storage = storage.club
    @club = club
  end

  def get_sports
    storage.sports_available(@club)
  end
end
