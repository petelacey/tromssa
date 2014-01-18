# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# Added by Pete Lacey to process asset pipeline *before* rails
# May break something later, but feh.
map "/assets" do
  run Rails.application.assets
end

run Rails.application
