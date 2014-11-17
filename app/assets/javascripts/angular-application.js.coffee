@Signart = angular.module("signart", [
  "leaflet-directive", "ngRoute", "templates", "rails"
])

# Signart.config ($httpProvider) ->
#   $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')


