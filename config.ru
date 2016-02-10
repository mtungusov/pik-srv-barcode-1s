require "java"
require "settingslogic"

java_import java.lang.System

puts "Start App"
puts "Java:  #{System.getProperties["java.runtime.version"]}"
puts "Jruby: #{ENV['RUBY_VERSION']}"
puts "Dir: #{__dir__}"
puts "Dir.pwd: #{Dir.pwd}"

cur_dir = __dir__.include?('uri:classloader:') ? File.split(__dir__).first : "#{__dir__}"
puts "Cur dir: #{cur_dir}"
cf = "#{cur_dir}/config/config.yml"
puts "Config File: #{cf}"
unless File.exist? cf
  puts "Error: Not found config file - #{cf}!"
  exit!
end

class Settings < Settingslogic
  namespace ENV['RUN_ENV']
end
$settings = Settings.new cf

puts "Namespace: #{Settings.namespace}"
puts "App: #{$settings.app_name}"
puts "Connection: #{$settings.connection}"

%w{INT TERM USR1}.each do |signal|
  trap(signal) do
    puts "Terminate:start"
    exit!
  end
end

require "grape"

module API
  class AppV1 < Grape::API
    version "v1", using: :path
    format :json
    get '/' do
      'hello, world!!!!'
    end
  end
end

run API::AppV1

at_exit {
  puts "Terminate:end"
}
