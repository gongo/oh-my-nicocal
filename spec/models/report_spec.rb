require 'spec_helper'

describe Report do
  before do
    @report = Report.new(date: Date.today)
  end

  subject { @report }

  it { should respond_to(:mood) }
end
