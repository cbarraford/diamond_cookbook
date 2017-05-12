require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'redhat'
  config.version = '7.3'
end

at_exit { ChefSpec::Coverage.report! }
