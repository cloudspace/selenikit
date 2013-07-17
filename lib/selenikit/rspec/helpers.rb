module Selenikit
  module Rspec
    module Helpers
      RSpec.configure do |config|
        config.before(:each) do
          binding.pry
          if self.example.metadata[:selenium].present? && ENV["SELENIUM"] != "true"
            Capybara.current_driver = :my_firefox_driver
            ENV["DISPLAY"] = ":99"
            
          else
            ENV["DISPLAY"] = ":98"
          end
        end
      end
    end
  end
end