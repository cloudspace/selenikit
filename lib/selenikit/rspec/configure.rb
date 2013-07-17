module Selenikit
  module Rspec
    module Configure
      def self.set_driver
        # Tell capybara we'll run our own server
        Capybara.run_server = false
        Capybara.app_host = "http://0.0.0.0:80"
        Capybara.server_port = 80
        
        # Register the selenium firefox driver
        Capybara.register_driver :selenium_firefox_driver do |app|
          profile = Selenium::WebDriver::Firefox::Profile.new
          Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
        end
        
        # If we came from the selenium rake tast, set the driver to be selenium, otherwise use webkit
        Capybara.javascript_driver = ENV["SELENIUM"] == "true" ? :selenium_firefox_driver : :webkit
      end
    end
  end
end