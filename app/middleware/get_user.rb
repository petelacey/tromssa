class GetUser
  def initialize(app)
    @app = app
  end

  def call(env)
    user = NEO.tromssa_query("
               MATCH (user:User {username:'placey'})
               RETURN user.username
           ")
    u = User.new(user.first[:user])
    env[:current_user] = u
    @app.call(env) 
  end
end
