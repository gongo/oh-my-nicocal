angular.module('nicocal').factory 'Mood', ($http) ->
  return {
    all: (callback) ->
      $http.get('/api/moods').success (response) ->
          callback(response.moods)
  }
