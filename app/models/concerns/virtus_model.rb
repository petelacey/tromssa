class VirtusModel
  include Virtus.model
  extend  ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Draper::Decoratable 

  def persisted?
    @persisted || false
  end
end
