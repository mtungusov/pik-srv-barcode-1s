class API::V1::Commands::DeletePodrazdeleniya < Grape::API
  resource :delete_podrazdeleniya do
    desc 'Удалить Подразделения'
    params do
      requires :id, type: String, desc: 'Unique id for request (UUID)'
      requires :params, type: Hash do
        requires :data, type: Array, desc: 'rows' do
          requires :guid, type: String, desc: 'GUID подразделения'
        end
      end
    end

    post do
      result = Workers.update_to '1s-references-podrazdeleniya', :guid, declared(params).params[:data], :delete
      { result: result, id: params[:id] }
    end
  end
end
