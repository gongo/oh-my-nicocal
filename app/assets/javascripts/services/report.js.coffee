angular.module('nicocal').factory 'Report', ($http, $filter) ->
  return {
    list: (date, callback) ->
      year_and_month = $filter('date')(date, 'yyyy/MM')
      $http.get("/api/reports/#{year_and_month}").success (response) ->
        callback(response.reports)

    put: (report) ->
      mood_id = 1
      date = $filter('date')(report.start, 'yyyy/MM/dd')
      $http.put("/api/reports/#{date}", { mood_id: mood_id })

    delete: (report) ->
      date = $filter('date')(report.start, 'yyyy/MM/dd')
      $http.delete("/api/reports/#{date}")
  }
