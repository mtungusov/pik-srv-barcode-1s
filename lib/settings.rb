class Settings < Settingslogic
  source 'config/config.yml'
  namespace ENV['BARCODE_1S_ENV']
end
