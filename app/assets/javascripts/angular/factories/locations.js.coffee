Signart.factory "Location", ['RailsResource', (RailsResource) ->
  class Location extends RailsResource
    @configure
      url: '/api/locations/{{id}}',
      name: 'location'
]

# Using ngResource
# Signart.factory "LocationService", ['$resource', ($resource) ->
#   return $resource('/api/locations/:id', {id: "@id"})
# ]
