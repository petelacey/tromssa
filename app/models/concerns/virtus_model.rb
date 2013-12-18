class VirtusModel
  include Virtus.model
  extend  ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    @persisted || false
  end
end
