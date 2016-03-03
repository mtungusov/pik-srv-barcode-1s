class API::V1::Commands < Grape::API; end

Dir["#{File.dirname(File.expand_path(__FILE__))}/commands/*.rb"].each do |f|
  require f
end

class API::V1::Commands < Grape::API
  helpers CommandsHelpers
  resource :commands do
    get '/' do
      { result: commands }
    end

    mount API::V1::Commands::UpdatePodrazdeleniya
    mount API::V1::Commands::DeletePodrazdeleniya
    mount API::V1::Commands::UpdateSotrudniki
    mount API::V1::Commands::DeleteSotrudniki
    mount API::V1::Commands::UpdateBarcodesNzp
    mount API::V1::Commands::DeleteBarcodesNzp
  end
end
