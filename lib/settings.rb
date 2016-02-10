require "settingslogic"

cur_dir = $ROOT_DIR.include?('uri:classloader:') ? File.split($ROOT_DIR).first : "#{$ROOT_DIR}"
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
$SETTINGS = Settings.new cf
