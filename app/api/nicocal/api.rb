require 'active_record/validations'

module Nicocal
  class API < Grape::API
    format :json
    default_format :json

    rescue_from ActiveRecord::RecordInvalid do |error|
      error_response(status: 422, message: { error: error.message })
    end

    resource :reports do
      desc 'Get reports of year/month'
      params do
        requires :year, type: String, regexp: /^\d{4}$/
        requires :month, type: String, regexp: /^\d{2}$/
      end
      get ':year/:month' do
        year_and_month = params[:year] + '/' + params[:month]
        { reports: Report.of(year_and_month) }
      end

      desc 'Update mood of day'
      params do
        requires :yyyymmdd, type: String, regexp: /^\d{8}$/
        requires :mood_id, type: Integer
      end
      put ':yyyymmdd' do
        unless Mood.exists?(params[:mood_id])
          error! 'Specified mood id that does not exist', 400
        end

        date = params[:yyyymmdd].to_date
        report = Report.find_or_initialize_by(date: date)
        report.mood_id = params[:mood_id]
        report.save!

        { report: report }
      end
    end

    resources :moods do
      get do
        { moods: Mood.all }
      end
    end
  end
end
