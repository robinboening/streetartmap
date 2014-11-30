StreetartMap.factory "markerLocation", ['RailsResource', 'railsSerializer', (RailsResource, railsSerializer) ->
  class markerLocation extends RailsResource
    @configure
      url: '/api/locations',
      name: 'location',
      serializer: railsSerializer ->
        this.only('latitude', 'longitude', 'full_address')
]
