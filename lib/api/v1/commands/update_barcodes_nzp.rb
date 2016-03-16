class API::V1::Commands::UpdateBarcodesNzp < Grape::API
  resource :update_barcodes_nzp do
    desc 'Обновить штрихкоды из документа ОПзС (НЗП)'
    params do
      requires :id, type: String, desc: 'Unique id for request (UUID)'
      requires :params, type: Hash do
        requires :data, type: Array, desc: 'rows' do
          requires :guid, type: String, desc: 'Штрихкод на этикетке'
          requires :nomenclature, type: String, desc: 'Номенклатура изделия'
          requires :division_guid, type: String, desc: 'Подразделение'
          requires :line_guid, type: String, desc: 'Производственная линия'
        end
      end
    end

    post do
      result = Workers.update_to 'barcode-production-in', :guid, declared(params).params[:data]
      { result: result, id: params[:id] }
    end
  end
end
