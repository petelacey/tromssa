module Tromssa::Middleware
  class GetClub
    def initialize(app)
      @app = app
    end

    def call(env)
      subdomain = env['HTTP_HOST'][/^(.+?)\./, 1].downcase
      club = NEO.cypher("
                 MATCH (club:Club)
                 WHERE club.shorter_name =~ '(?i)#{subdomain}'
                 RETURN club
             ")
      env[:current_club] = Club.new(club.first[:club])
      @app.call(env) 
    end
  end
end

