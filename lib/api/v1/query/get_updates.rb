class API::V1::Query::GetUpdates < Grape::API
  resource :get_updates do
    desc 'Получить обновления из базы'
    params do
      requires :id, type: String, desc: 'Unique id for request (UUID)'
      requires :topic, type: String, desc: 'Topic name'
      optional :offset, type: Integer, desc: 'Offset from client', default: -1
    end

    get do
      result = Cache.get_updates declared(params)
      {
          result: result,
          id: params[:id]
      }
    end
  end
end
