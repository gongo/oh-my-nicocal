'use strict'

angular.module('nicocal').controller 'ReportsCtrl', ($scope, Mood, Report) ->
  $scope.reports = []

  Mood.all (moods) ->
    $scope.moods = moods

  $scope.moodClass = (mood) ->
    status = switch
      when mood.score > 0 then 'mood-positive'
      when mood.score < 0 then 'mood-negative'
      else 'mood-straight'
    ["fa", "fa-#{mood.name}-o", "fa-2x", status]

  $scope.removeReportOfDate = (date) ->
    angular.forEach $scope.reports, (value, key) ->
      $scope.reports.splice(key, 1) if angular.equals(value.start, date)

  $scope.updateReport = (report) ->
    $scope.removeReportOfDate(report.start)
    $scope.reports.push(report)
    Report.put(report)

  $scope.removeReport = (report) ->
    angular.forEach $scope.reports, (value, key) ->
      $scope.reports.splice(key, 1) if angular.equals(value, report)

  $scope.onDrop = (date) ->
    mood = {
      name: "frown"
      score: -1
    }
    report = {
      title: ''
      start: date
      backgroundColor: "inherit"
      borderColor: "transparent"
      className: $scope.moodClass(mood)
    }
    $scope.updateReport(report)

  $scope.onClick = (report) ->
    $scope.removeReport(report)

  $scope.onChangeView = (view) ->
    Report.list view.start, (reports) ->
      $scope.reports.length = 0
      angular.forEach reports, (_report) ->
        date = new Date(_report.date)
        date.setHours(0)
        report = {
          title: ''
          start: date
          backgroundColor: "inherit"
          borderColor: "transparent"
          className: $scope.moodClass(_report)
        }
        $scope.reports.push(report)

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
      viewRender: $scope.onChangeView
    }
  }

  $scope.eventSources = [$scope.reports]
