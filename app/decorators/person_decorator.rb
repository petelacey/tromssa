class PersonDecorator < Draper::Decorator
  def full_name
    last_name + ", " + first_name
  end
end
