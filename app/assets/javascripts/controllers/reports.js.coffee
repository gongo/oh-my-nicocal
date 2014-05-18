'use strict'

angular.module('nicocal').controller 'ReportsCtrl', ($scope, Mood) ->
  $scope.events = []

  Mood.all (moods) ->
    $scope.moods = moods

  $scope.moodClass = (mood) ->
    status = switch
      when mood.score > 0 then 'mood-positive'
      when mood.score < 0 then 'mood-negative'
      else 'mood-straight'
    ["fa", "fa-#{mood.name}-o", "fa-2x", status]

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
    $scope.events.push(nicomark)

  $scope.onClick = (event) ->
    angular.forEach $scope.events, (value, key) ->
      $scope.events.splice(key, 1) if $scope.events[key] == event

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

  $scope.eventSources = [$scope.events]
