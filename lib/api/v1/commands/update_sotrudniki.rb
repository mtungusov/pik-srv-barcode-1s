class API::V1::Commands::UpdateSotrudniki < Grape::API
  resource :update_sotrudniki do
    desc 'Обновить Сотрудников'
    params do
      requires :id, type: String, desc: 'Unique id for request (UUID)'
      requires :params, type: Hash do
        requires :data, type: Array, desc: 'rows' do
          requires :guid, type: String, desc: 'GUID сотрудника'
          requires :fullname, type: String, desc: 'ФИО'
          requires :barcode, type: String, desc: 'Штрихкод сотрудника'
        end
      end
    end

    post do
      result = Workers.update_to '1s-references-sotrudniki', :guid, declared(params).params[:data]
      { result: result, id: params[:id] }
    end
  end
end
