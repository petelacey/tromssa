class RegistrationService
  attr_accessor :storage

  def initialize(storage)
    @storage = storage.registration
  end

  def register(reg, club, user)
    if not (reg.guardian.valid? and reg.athlete.valid?)
      reg.errors[:base] = "Errors exist"
      return reg
    end
    storage.create(reg, club, user)
  end

  def retrieve(club, user)
    r = storage.retrieve(club, user)
    return nil if r.empty?
    Registration.new(r.first)
  end
end
