Signart.directive 'locations', ->
  return {
    restrict: 'A'
    scope:
      show: '='
    transclude: true
    templateUrl: 'angular/templates/locations.html'
  }
