Signart.controller "locationCtrl", ['$scope', '$location', 'Location', '$routeParams', ($scope, $location, Location, $routeParams) ->
  $scope.postLocation = (event, location) ->
    debugger
  if $location.path() == '/locations/new'
    $scope.firstStep = true
  else if $routeParams.id
    Location.get($routeParams.id).then (result) ->
      $scope.location = result
  else
    Location.query().then (results) ->
      $scope.locations = results
]
