'use strict'

angular.module('nicocal').controller 'ReportsCtrl', ($scope, Mood) ->
  $scope.nicomarks = []

  Mood.all (moods) ->
    $scope.moods = moods

  $scope.moodClass = (mood) ->
    status = switch
      when mood.score > 0 then 'mood-positive'
      when mood.score < 0 then 'mood-negative'
      else 'mood-straight'
    ["fa", "fa-#{mood.name}-o", "fa-2x", status]

  $scope.removeMoodOfDate = (date) ->
    angular.forEach $scope.nicomarks, (value, key) ->
      $scope.nicomarks.splice(key, 1) if angular.equals(value.start, date)

  $scope.updateMood = (nicomark) ->
    $scope.removeMoodOfDate(nicomark.start)
    $scope.nicomarks.push(nicomark)

  $scope.removeMood = (nicomark) ->
    angular.forEach $scope.nicomarks, (value, key) ->
      $scope.nicomarks.splice(key, 1) if angular.equals(value, nicomark)

  $scope.onDrop = (date) ->
    mood = {
      name: "frown"
      score: -1
    }
    nicomark = {
      title: ''
      start: date
      backgroundColor: "inherit"
      borderColor: "transparent"
      className: $scope.moodClass(mood)
    }
    $scope.updateMood(nicomark)

  $scope.onClick = (nicomark) ->
    $scope.removeMood(nicomark)

  $scope.uiConfig = {
    calendar: {
      height: 500
      editable: false
      header:{
        left: 'title'
        center: ''
        right: 'today prev,next'
      },
      droppable: true
      drop: $scope.onDrop
      eventClick: $scope.onClick
    }
  }

  $scope.eventSources = [$scope.nicomarks]
