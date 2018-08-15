require 'yaml'
require 'awesome_print'
CONFIG = YAML.load_file("config.yml")
WamblZendesk.configure do |config|
  config.subdomain = CONFIG['SUBDOMAIN']
  config.email = CONFIG['EMAIL']
  config.token = CONFIG['TOKEN']
end
