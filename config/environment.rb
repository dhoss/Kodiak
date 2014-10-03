# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Kodiak::Application.initialize!

Time::DATE_FORMATS[:posted_on] = "%B %d at %I:%M %p"
