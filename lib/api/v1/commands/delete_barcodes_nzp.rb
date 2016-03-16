class API::V1::Commands::DeleteBarcodesNzp < Grape::API
  resource :delete_barcodes_nzp do
    desc 'Удалить штрихкоды'
    params do
      requires :id, type: String, desc: 'Unique id for request (UUID)'
      requires :params, type: Hash do
        requires :data, type: Array, desc: 'rows' do
          requires :guid, type: String, desc: 'Штрихкод на этикетке'
        end
      end
    end

    post do
      result = Workers.update_to 'barcode-production-in', :guid, declared(params).params[:data], :delete
      { result: result, id: params[:id] }
    end
  end
end
