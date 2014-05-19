angular.module('nicocal').factory 'Report', ['$http', '$filter', ($http, $filter) ->
  return {
    list: (date, callback) ->
      yearAndMonth = $filter('date')(date, 'yyyy/MM')
      $http.get("/api/reports/#{yearAndMonth}").success (response) ->
        callback(response.reports)

    put: (report, moodId) ->
      date = $filter('date')(report.start, 'yyyy/MM/dd')
      $http.put("/api/reports/#{date}", { mood_id: moodId })

    delete: (report) ->
      date = $filter('date')(report.start, 'yyyy/MM/dd')
      $http.delete("/api/reports/#{date}")
  }
  ]
