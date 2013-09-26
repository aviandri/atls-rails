# Load the rails application
require File.expand_path('../application', __FILE__)


Date::DATE_FORMATS.merge!(:default => "%d/%m/%Y")

# Initialize the rails application
AtlsRails::Application.initialize!
