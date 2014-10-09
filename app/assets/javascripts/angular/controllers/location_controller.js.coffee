Signart.controller "locationCtrl", ['$scope', 'Location', ($scope, Location) ->
  Location.query().then (results) ->
    $scope.locations = results
]
