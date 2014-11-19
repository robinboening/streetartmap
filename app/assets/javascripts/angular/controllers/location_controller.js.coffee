Signart.controller "locationCtrl", ['$scope', '$location', 'Location', '$routeParams', '$upload', ($scope, $location, Location, $routeParams, $upload) ->
  $scope.onFileSelect = ($files) ->
    angular.forEach $files, (file) ->
      if file.type in ["image/jpeg", "image/png", "image/gif"]
        $scope.file = file
        $scope.reader = new FileReader()
        $scope.reader.onload = (e) ->
          $scope.$apply () ->
            $scope.sign = e.target.result
        $scope.reader.readAsDataURL file

  $scope.createLocation = ->
    $scope.upload = $upload.upload(
      method: 'POST',
      url: '/api/locations'
      data:
        location:
          latitude: $scope.location['latitude']
          longitude: $scope.location['longitude']
        sign: $scope.file
      headers:
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        'Accept': 'application/json'
    ).success (data, status, headers, config) ->
      $location.path('/')

  if $location.path() == '/locations/new'
    $scope.firstStep = true
  else if $routeParams.id
    Location.get($routeParams.id).then (result) ->
      $scope.location = result
  else
    Location.query().then (results) ->
      $scope.locations = results
]
