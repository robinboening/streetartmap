Signart.controller "locationCtrl", ['$scope', 'Location', '$routeParams', ($scope, Location, $routeParams) ->
  if $routeParams.id
    Location.get($routeParams.id).then (result) ->
      $scope.location = result
  else
    Location.query().then (results) ->
      $scope.locations = results
]
