module Selenikit
  module Rspec
    module Configure
      def self.set_driver
        Capybara.run_server = false
        Capybara.app_host = "http://0.0.0.0:80"
        Capybara.server_port = 80

        if ENV["SELENIUM"] == "true"
          puts "your javascript driver is using SELENIUM!"
          Capybara.register_driver :my_firefox_driver do |app|
            profile = Selenium::WebDriver::Firefox::Profile.new
            Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
          end
          Capybara.javascript_driver = :my_firefox_driver
        else
          puts "your javascript driver is using WEBKIT!"
          Capybara.javascript_driver = :webkit
        end
      end
    end
  end
end