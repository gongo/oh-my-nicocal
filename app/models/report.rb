class Report < ActiveRecord::Base
  belongs_to :mood

  default_scope { order(:date) }

  class << self
    #
    # Returns reports of +year_and_month+
    #
    # @param  [String]  year_and_month  %Y/%m
    # @return [ActiveRecord::Relation]
    #
    # @example
    #   Report.of('2014/06') # => #<ActiveRecord::Relation [#<Report ..>]>
    #
    def of(year_and_month)
      date = year_and_month.to_date
      where(date: date.beginning_of_month..date.end_of_month).includes(:mood)
    end
  end
end
