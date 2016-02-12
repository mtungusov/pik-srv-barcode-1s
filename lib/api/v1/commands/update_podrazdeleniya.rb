class API::V1::Commands::UpdatePodrazdeleniya < Grape::API
  resource :update_podrazdeleniya do
    desc 'Обновить Подразделения'
    params do
      requires :id, type: String, desc: 'Unique id for request (UUID)'
      requires :params, type: Hash do
        requires :data, type: Array, desc: 'rows' do
          requires :guid, type: String, desc: 'GUID подразделения'
          requires :parent_guid, type: String, desc: 'GUID родителя'
          requires :name, type: String, desc: 'Наименование'
        end
      end
    end
    post do
      { result: { message: :ok, data: params[:params][:data] }, id: params[:id] }
    end
  end

end
