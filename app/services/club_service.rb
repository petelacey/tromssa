# TODO: Inject storage class

class ClubService
  def initialize(club)
    @club = club
  end

  def get_sports
    Tromssa::Storage::Neo::Club.new.sports_available(@club)
  end
end
