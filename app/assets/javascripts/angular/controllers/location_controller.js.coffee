Signart.controller "locationCtrl", ['$scope', '$location', 'Location', '$routeParams', '$upload', 'leafletData', ($scope, $location, Location, $routeParams, $upload, leafletData) ->

  $scope.$watch "showMap", (value) ->
    if value == true
      $scope.center = {
        zoom: 14
        autoDiscover: true
      }
      leafletData.getMap().then (map) ->
        map.invalidateSize()

  $scope.onFileSelect = ($files) ->
    angular.forEach $files, (file) ->
      if file.type in ["image/jpeg"]
        $scope.file = file

        EXIF.getData file, ->
          latitude = EXIF.getTag(@, 'GPSLatitude')
          longitude = EXIF.getTag(@, 'GPSLongitude')

          if latitude && longitude
            $scope.location = {
              latitude: latitude
              longitude: longitude
            }
            $scope.createLocation()
          else
            $scope.$apply ->
              $scope.showMap = true
            return

  $scope.createLocation = ->
    if $scope.location
      longitude = $scope.location.longitude
      latitude = $scope.location.latitude
    else
      latitude = ''
      longitude = ''

    $scope.upload = $upload.upload
      method: 'POST',
      url: '/api/locations'
      data:
        location:
          latitude: latitude
          longitude: longitude
        sign: $scope.file
      headers:
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        'Accept': 'application/json'
    .error (data, status, headers, config) ->
      $scope.errors = headers('errors')
      $scope.showMap = true
    .success (data, status, headers, config) ->
      location_path = headers('location').substring($location.absUrl().length - $location.url().length) # fml
      $location.path(location_path)

  if $location.path() == '/locations/new'
    $scope.showMap = false
  else if $routeParams.id
    Location.get($routeParams.id).then (result) ->
      $scope.location = result
  else
    Location.query().then (results) ->
      $scope.locations = results
]
