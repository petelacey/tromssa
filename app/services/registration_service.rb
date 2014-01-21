# TODO: Inject storage class

class RegistrationService
  def register(reg, club, user)
    if not (reg.guardian.valid? and reg.athlete.valid?)
      reg.errors[:base] = "Errors exist"
      return reg
    end
    Tromssa::Storage::Neo::Registration.new.create(reg, club, user)
  end

  def retrieve(club, user)
    r = Tromssa::Storage::Neo::Registration.new.retrieve(club, user)
    return nil if r.empty?
    Registration.new(r.first)
  end
end
