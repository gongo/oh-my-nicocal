module Nicocal
  class API < Grape::API
    resource :reports do
      desc 'Update mood of day'
      params do
        requires :yyyymmdd, type: String, regexp: /^\d{8}$/
        requires :mood_id, type: Integer
      end
      put ':yyyymmdd' do
        unless Mood.exists?(params[:mood_id])
          error!({ error: 'Specified mood id that does not exist' }, 400)
        end

        date = params[:yyyymmdd].to_date
        report = Report.find_or_initialize_by(date: date)
        report.mood_id = params[:mood_id]
        report.save
      end
    end
  end
end
