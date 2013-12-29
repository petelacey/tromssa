module Tromssa::Middleware
  class GetUser
    def initialize(app)
      @app = app
    end

    def call(env)
      user = NEO.cypher("
                 MATCH (user:User {username:'placey'})
                 RETURN user
             ")
      env[:current_user] = User.new(user.first[:user])
      @app.call(env) 
    end
  end
end
