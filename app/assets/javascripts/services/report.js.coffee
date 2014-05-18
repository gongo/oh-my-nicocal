angular.module('nicocal').factory 'Report', ($http, $filter) ->
  return {
    list: (year_and_month, callback) ->

    put: (report) ->
      mood_id = 1
      date = $filter('date')(report.start, 'yyyy/MM/dd')
      $http.put("/api/reports/#{date}", { mood_id: mood_id })
  }
