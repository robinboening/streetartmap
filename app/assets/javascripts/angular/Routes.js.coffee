Signart.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)

  $routeProvider
    .when '/',
      controller: 'locationCtrl'
      templateUrl: 'angular/templates/locations.html'
]
