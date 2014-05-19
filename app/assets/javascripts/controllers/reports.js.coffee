'use strict'

angular.module('nicocal').controller 'ReportsCtrl', ['$scope', 'Mood', 'Report', ($scope, Mood, Report) ->
  $scope.reports = []
  $scope.reportSources = [$scope.reports]

  Mood.all (moods) ->
    $scope.moods = moods

  $scope.moodClass = (mood) ->
    status = switch
      when mood.score > 0 then 'mood-positive'
      when mood.score < 0 then 'mood-negative'
      else 'mood-straight'
    ["fa", "fa-#{mood.name}-o", "fa-2x", status]

  $scope.newReport = (mood, date) ->
    {
      title: ''
      start: date
      moodId: mood.id
      backgroundColor: "inherit"
      borderColor: "transparent"
      className: $scope.moodClass(mood)
    }

  #
  # Report update/delete functions
  #

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
    Report.delete(report)

  #
  # Event functions
  #

  $scope.onDrop = (date, allDay, jsEvent) ->
    mood = angular.element(jsEvent.target).data('mood')
    report = $scope.newReport(mood, date)
    $scope.updateReport(report)

  $scope.onClick = (report) ->
    $scope.removeReport(report)

  $scope.onChangeView = (view) ->
    Report.list view.start, (reports) ->
      $scope.reports.length = 0
      angular.forEach reports, (_report) ->
        # Align to UTC of report date that obtained from API
        date = new Date(_report.date)
        date.setHours(0)
        $scope.reports.push($scope.newReport(_report, date))

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
  ]
