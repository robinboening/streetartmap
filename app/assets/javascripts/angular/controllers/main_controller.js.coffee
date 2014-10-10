Signart.controller "MainCtrl", [ "$scope", "$location", ($scope, $location) ->
  $scope.isActive = (path) ->
    return $location.path() == path
]
