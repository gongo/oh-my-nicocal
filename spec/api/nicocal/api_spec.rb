require 'spec_helper'

describe Nicocal::API do
  describe 'GET /api/reports/:year/:month' do
    before { get '/api/reports/1993/02' }

    it 'returns reports' do
      expect(response).to be_success

      body = JSON.parse(response.body)
      expect(body['reports']).to be_a Array
    end
  end

  describe "PUT /api/reports/:year/:month/:day" do
    context 'when given date and mood_id' do
      let(:mood) { Mood.create(name: 'happiness', score: 100) }

      it 'save successfully report of day, and return create report' do
        expect {
          put '/api/reports/1993/02/24', { mood_id: mood.id }
        }.to change(Report, :count).by(1)
        expect(JSON.parse(response.body)).to have_key 'report'
      end

      context 'and mood is already registered on date' do
        before do
          Report.create(date: '1993-02-24', mood: mood)
        end

        it 'update successfully report of day, and return update report' do
          expect {
            put '/api/reports/1993/02/24', { mood_id: mood.id }
          }.not_to change(Report, :count).by(1)
          expect(JSON.parse(response.body)).to have_key 'report'
        end
      end
    end

    context 'when given invalid date' do
      before { put '/api/reports/1234/foo/56' }
      it { expect(response).not_to be_success }
    end

    context 'when given invalid mood id' do
      before { put '/api/reports/1993/02/24', { mood_id: 'foo' } }
      it { expect(response).not_to be_success }
    end

    context 'when given mood id does not exist' do
      before { put '/api/reports/1993/02/24', { mood_id: 1 } }
      it 'returns code `400` and detail error message' do
        expect(response).not_to be_success
        expect(JSON.parse(response.body)).to have_key 'error'
      end
    end
  end

  describe "DELETE /api/reports/:year/:month/:day" do
    context 'when given date and mood_id' do
      before do
        mood = Mood.create(name: 'happiness', score: 100)
        Report.create(date: '1993-02-24', mood: mood)
      end

      it 'delete successfully report of day' do
        expect {
          delete '/api/reports/1993/02/24'
        }.to change(Report, :count).by(-1)
      end
    end

    context 'when given mood id does not exist' do
      before { put '/api/reports/1993/02/24', { mood_id: 1 } }
      it 'returns code `400` and detail error message' do
        expect(response).not_to be_success
        expect(JSON.parse(response.body)).to have_key 'error'
      end
    end
  end

  describe 'GET /api/moods' do
    before { get '/api/moods' }

    it 'returns moods' do
      expect(response).to be_success

      body = JSON.parse(response.body)
      expect(body['moods']).to be_a Array
    end
  end
end
