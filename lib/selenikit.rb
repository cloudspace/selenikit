require "selenikit/version"

module Selenikit
  class Railtie < Rails::Railtie
    railtie_name :selenikit

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'selenikit/tasks/*.rake')].each { |f| load f }
    end
  end
  
  require 'capybara-webkit'
  require 'selenium-webdriver'
  require 'capybara'
  require 'capybara/rspec'
  
end
