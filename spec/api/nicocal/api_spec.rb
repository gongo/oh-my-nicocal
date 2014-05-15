require 'spec_helper'

describe Nicocal::API do
  describe "PUT /api/reports/:yyyymmdd" do
    context 'when given date and mood_id' do
      let(:mood) { Mood.create(name: 'happiness', score: 100) }

      it 'save successfully report of day' do
        expect {
          put '/api/reports/19930224', { mood_id: mood.id }
        }.to change(Report, :count).by(1)
      end

      context 'and mood is already registered on date' do
        before do
          Report.create(date: '1993-02-24', mood: mood)
        end

        it 'update successfully report of day' do
          expect {
            put '/api/reports/19930224', { mood_id: mood.id }
          }.not_to change(Report, :count).by(1)
        end
      end
    end

    context 'when given invalid date' do
      before { put '/api/reports/123456' }
      it { expect(response).not_to be_success }
    end

    context 'when given invalid mood id' do
      before { put '/api/reports/19930224', { mood_id: 'foo' } }
      it { expect(response).not_to be_success }
    end

    context 'when given mood id does not exist' do
      before { put '/api/reports/19930224', { mood_id: 1 } }
      it 'returns code `400` and detail error message' do
        expect(response).not_to be_success
        expect(JSON.parse(response.body)).to have_key 'error'
      end
    end
  end
end
