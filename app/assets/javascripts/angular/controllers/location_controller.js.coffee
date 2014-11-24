Signart.controller "locationCtrl", ['$scope', '$location', 'Location', '$routeParams', '$upload', 'leafletData', ($scope, $location, Location, $routeParams, $upload, leafletData) ->

  $scope.$watch "showMap", (value) ->
    if value == true
      $scope.center = {
        zoom: 14
        autoDiscover: true
      }
      leafletData.getMap().then (map) ->
        map.invalidateSize()

  convert_to_degrees = (value) ->
    d0 = value[0]['numerator']
    d1 = value[0]['denominator']
    d = d0 / d1

    m0 = value[1]['numerator']
    m1 = value[1]['denominator']
    m = m0 / m1

    s0 = value[2]['numerator']
    s1 = value[2]['denominator']
    s = s0 / s1

    return d + (m / 60.0) + (s / 3600.0)

  calculate_gps_data = (file) ->
    gps_latitude = EXIF.getTag(file, "GPSLatitude")
    gps_latitude_ref = EXIF.getTag(file, 'GPSLatitudeRef')
    gps_longitude = EXIF.getTag(file, 'GPSLongitude')
    gps_longitude_ref = EXIF.getTag(file, 'GPSLongitudeRef')

    if gps_latitude && gps_latitude_ref && gps_longitude && gps_longitude_ref
      lat = convert_to_degrees(gps_latitude)
      if gps_latitude_ref != "N"
        lat = 0 - lat

      lng = convert_to_degrees(gps_longitude)
      if gps_longitude_ref != "E"
        lng = 0 - lng

      return [lat, lng]

  $scope.onFileSelect = ($files) ->
    angular.forEach $files, (file) ->
      if file.type in ["image/jpeg"]
        $scope.file = file

        EXIF.getData file, ->
          if gps_coords = calculate_gps_data(file)
            $scope.location = {
              latitude: gps_coords[0]
              longitude: gps_coords[1]
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
