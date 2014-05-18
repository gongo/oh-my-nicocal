angular.module('nicocal').factory 'Mood', ($http) ->
  return {
    all: (callback) ->
      $http.get('/api/moods').success (data, status) ->
        callback(data.moods)
  }
