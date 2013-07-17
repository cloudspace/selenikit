module Selenikit
  module Rspec
    module Helpers
      RSpec.configure do |config|
        config.before(:each) do
          # If the test is tagged as selenium or if we're in the selenium rake task, set the driver to selenium
          if self.example.metadata[:selenium].present? || ENV["SELENIUM"] == "true"
            Capybara.current_driver = :selenium_firefox_driver
          end
        end
      end
    end
  end
end