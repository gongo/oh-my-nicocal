'use strict'

angular.module('nicocal').controller 'ReportsCtrl', ($scope) ->
  $scope.events = []

  $scope.moods = {
    "smile": { color: "forestgreen" }
    "meh":   { color: "goldenrod" }
    "frown": { color: "crimson" }
  }

  $scope.onDrop = (date) ->
    mood = "frown"
    nicomark = {
      title: ''
      start: date
      backgroundColor: "inherit"
      borderColor: "transparent"
      textColor: $scope.moods[mood].color
      className: ["fa", "fa-" + mood + "-o", "fa-2x"]
    }
    $scope.events.push(nicomark)

  $scope.onClick = (event) ->
    angular.forEach $scope.events, (value, key) =>
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
