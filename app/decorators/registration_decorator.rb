class RegistrationDecorator < Draper::Decorator
  delegate_all
  decorates_association :guardian
  decorates_association :athlete

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def sports
    sports = ClubService.new(h.current_club).get_sports
  
    # TODO: Consider instantiating an object instead
    sports.map { |sport| s = sport["sport"]["name"]; [s, s] }
  end
end
