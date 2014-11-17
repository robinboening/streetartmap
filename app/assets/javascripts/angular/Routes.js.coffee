Signart.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)

  $routeProvider
    .when '/',
      controller: 'locationCtrl'
      templateUrl: 'angular/templates/locations.html'
    .when '/locations/new',
      controller: 'locationCtrl'
      templateUrl: 'angular/templates/location_form.html'
    .when '/locations/:id',
      controller: 'locationCtrl'
      templateUrl: 'angular/templates/location.html'
]
