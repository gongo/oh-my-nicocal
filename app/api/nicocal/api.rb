require 'active_record/validations'

module Nicocal
  class API < Grape::API
    format :json
    formatter :json, Grape::Formatter::Jbuilder
    default_format :json

    rescue_from ActiveRecord::RecordInvalid do |error|
      error_response(status: 422, message: { error: error.message })
    end

    resource :reports do
      helpers do
        def report_date
          Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        end
      end

      desc 'Get reports of year/month'
      params do
        requires :year, type: String, regexp: /^\d{4}$/
        requires :month, type: String, regexp: /^\d{2}$/
      end
      get ':year/:month', jbuilder: 'reports' do
        year_and_month = params[:year] + '/' + params[:month]
        @reports = Report.of(year_and_month)
      end

      desc 'Update mood of day'
      params do
        requires :year,    type: String, regexp: /^\d{4}$/
        requires :month,   type: String, regexp: /^\d{2}$/
        requires :day,     type: String, regexp: /^\d{2}$/
        requires :mood_id, type: Integer
      end
      put ':year/:month/:day' do
        unless Mood.exists?(params[:mood_id])
          error! 'Specified mood id that does not exist', 400
        end

        report = Report.find_or_initialize_by(date: report_date)
        report.mood_id = params[:mood_id]
        report.save!

        { report: report }
      end

      desc 'Delete mood of day'
      params do
        requires :year,  type: String, regexp: /^\d{4}$/
        requires :month, type: String, regexp: /^\d{2}$/
        requires :day,   type: String, regexp: /^\d{2}$/
      end
      delete ':year/:month/:day' do
        report = Report.find_by(date: report_date)

        unless report
          error! 'Specified report that does not exist', 400
        end

        report.destroy!
      end
    end

    resources :moods do
      get do
        { moods: Mood.all }
      end
    end
  end
end
