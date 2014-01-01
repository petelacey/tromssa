class Athlete < VirtusModel
  attribute :first_name, String
  attribute :last_name, String
  attribute :dob, DateTime

  validates_presence_of :first_name, :last_name,
                        :dob
end

