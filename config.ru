require "java"

java_import java.lang.System

puts "Start App"
puts "Java:  #{System.getProperties["java.runtime.version"]}"
puts "Jruby: #{ENV['RUBY_VERSION']}"

$ROOT_DIR = "#{__dir__}"
puts "Dir: #{$ROOT_DIR}"

require_relative "lib/settings"

puts "Namespace: #{Settings.namespace}"
puts "App: #{$SETTINGS.app_name}"
puts "Connection: #{$SETTINGS.connection}"

require_relative "lib/trap_signals"

require_relative "lib/api"
run API::AppV1

require_relative "lib/at_exit_actions"
