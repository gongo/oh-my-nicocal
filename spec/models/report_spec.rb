require 'spec_helper'

describe Report do
  before do
    @report = Report.new(date: Date.today)
  end

  subject { @report }

  it { should respond_to(:mood) }

  describe '.of' do
    before do
      today = Date.today
      Report.create(date: today.prev_month.end_of_month)
      Report.create(date: today.beginning_of_month)
      Report.create(date: today.end_of_month)
      Report.create(date: today.next_month.beginning_of_month)
    end

    context 'when given date which mood data is exists' do
      subject { Report.of(Date.today.strftime('%Y/%m')) }

      it 'return matches reports.' do
        expect(subject.count).to eq 2
      end
    end

    context 'when given date which mood data is not exists' do
      subject { Report.of(Date.today.prev_year.strftime('%Y/%m')) }

      it 'not return' do
        expect(subject).to be_empty
      end
    end

    context 'when given invalid date' do
      subject { Report.of('foobar') }

      it 'raise Argument Error' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
