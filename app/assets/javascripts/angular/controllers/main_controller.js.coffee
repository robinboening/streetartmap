Signart.controller "mainCtrl", [ "$scope", "$location", ($scope, $location) ->

  $scope.isActive = (path) ->
    return $location.path() == path

  $scope.markerPopup = (id='') ->
    # debugger
]
