class API::AppV1::Commands < Grape::API; end

Dir["#{File.dirname(File.expand_path(__FILE__))}/commands/*.rb"].each do |f|
  require f
end

class API::AppV1::Commands < Grape::API
  resource :commands do
    get '/' do
      { result: commands }
    end

    mount API::AppV1::Commands::UpdatePodrazdeleniya
  end
end

def commands
  ['update_podrazdeleniya']
end
