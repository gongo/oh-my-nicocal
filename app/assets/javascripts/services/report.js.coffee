angular.module('nicocal').factory 'Report', ($http, $filter) ->
  return {
    put: (report) ->
      mood_id = 1
      date = $filter('date')(report.start, 'yyyyMMdd')
      $http.put("/api/reports/#{date}", { mood_id: mood_id })
  }
