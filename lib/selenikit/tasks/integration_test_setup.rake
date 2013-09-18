require 'rspec/core/rake_task'

Rake::Task['spec'].clear

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir['spec/*/**/*_spec.rb'].reject{ |f| f['/features'] }
end

namespace :spec do
  def os
    @os ||= (
      host_os = RbConfig::CONFIG['host_os']
      case host_os
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        :windows
      when /darwin|mac os/
        :macosx
      when /linux/
        :linux
      when /solaris|bsd/
        :unix
      else
        raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
      end
    )
  end
  
  RSpec::Core::RakeTask.new(:selenium) do |t|
    
    # Determine the OS
    os

    ENV["RAILS_ENV"] = "test"
    
    # This will be used in spec_helper to determine 
    # which JS driver to use in capybara
    ENV["SELENIUM"] = "true"
    
    # Kill any previously running sessions
    Rake::Task["xvfb:kill"].reenable
    Rake::Task["xvfb:kill"].invoke
    
    if @os == :linux
      # Kill any previously running sessions
      Rake::Task["vnc:kill"].reenable
      Rake::Task["vnc:kill"].invoke
    
      # Start the vnc session
      Rake::Task["vnc:start"].reenable
      Rake::Task["vnc:start"].invoke
    
      # Start firefox
      Rake::Task["vnc:firefox"].reenable
      Rake::Task["vnc:firefox"].invoke
    end
    
    # Run all features or one file
    t.pattern = ENV["FILE"].blank? ? ["spec/features/*.rb","spec/features/**/*.rb"] : ENV["FILE"]
    
    # Make rspec pretty
    t.rspec_opts = ['-f documentation', '--color']
  end
  
  RSpec::Core::RakeTask.new(:webkit) do |t|
    
    # Determine the OS
    os
    
    ENV["RAILS_ENV"] = "test"
    
    if @os == :linux
      # Kill any previously running sessions
      Rake::Task["vnc:kill"].reenable
      Rake::Task["vnc:kill"].invoke
    end
    
    Rake::Task["xvfb:kill"].reenable
    Rake::Task["xvfb:kill"].invoke

    # Start the Xvfb session
    # We could use headless for this, but I know how it works so why not
    Rake::Task["xvfb:start"].reenable
    Rake::Task["xvfb:start"].invoke
    
    
    # Run all features or one file
    t.pattern = ENV["FILE"].blank? ? ["spec/features/*.rb","spec/features/**/*.rb"] : ENV["FILE"]
    
    # Make rspec pretty
    t.rspec_opts = ['-f documentation', '--color']
  end

end

namespace :xvfb do
  
  desc "Xvfb break down"
  task :kill do
    # System call kill all Xvfb processes
    %x{killall Xvfb}
  end
  
  desc "Xvfb setup"
  task :start do
    # This is what links the server to the test
    ENV["DISPLAY"] = ":99"
    # System call to start the server on display :99
    %x{Xvfb :99 2>/dev/null >/dev/null &}
  end
  
end

namespace :vnc do
  
  desc "vnc4server break down"
  task :kill do
    # System call kill vnc4server on display :99
    %x{vnc4server -kill :99}
  end

  desc "vnc4server js setup"
  task :start do
    # This is what links the server to the test
    ENV["DISPLAY"] = ":99"
    # System call to start the server on display :99
    %x{vnc4server :99 2>/dev/null >/dev/null &}
  end
  
  desc "launch firefox"
  task :firefox do
    # System call to start firefox on display :99
    %x{DISPLAY=:99 firefox 2>/dev/null >/dev/null &}
  end
end