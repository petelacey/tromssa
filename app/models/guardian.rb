class Guardian < VirtusModel
  attribute :first_name, String
  attribute :last_name, String

  validates_presence_of :first_name, :last_name
end
