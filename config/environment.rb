# Load local libs
require File.expand_path('../../lib/middleware', __FILE__)

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Tromssa::Application.initialize!
