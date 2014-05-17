'use strict'

angular.module('nicocal').controller 'ReportsCtrl', ($scope) ->
  $scope.onDrop = (date, allDay) ->
    nicomark = {
      title: ''
      start: date
      backgroundColor: "inherit"
      borderColor: "transparent"
      textColor: "red"
      className: ["fa", "fa-meh-o", "fa-2x"]
    }
    $scope.NicoNicoCalendar.fullCalendar('renderEvent', nicomark, false);

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
    }
  }

  $scope.eventSources = [[]]
