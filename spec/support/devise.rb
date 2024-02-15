RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
end

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true
