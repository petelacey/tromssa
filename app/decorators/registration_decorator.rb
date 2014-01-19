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
    # TODO: Move this query to a Service (and to a DB API)
    # TODO: Make this query sensitive to athlete's birthday
    query = "
      MATCH
        (club:Club)-[:active_during]->(season:Season)-[:offering]->(Porgram)-[:trains_for]->(sport:Sport)
      WHERE
        club.short_name = {club_short_name}
      AND
        season.start_date >= {start_date}
      RETURN
        DISTINCT sport"

        p h.class.methods
    params = {club_short_name: h.current_club.short_name,
              start_date: "2013-00-00"} # TODO: Make dynamic

    sports = NEO.cypher(query, params)

    # TODO: Consider instantiating an object instead
    sports.map { |sport| s = sport["sport"]["name"]; [s, s] }

  end
end
