
# Cinema Module
#
# @abstract Main cinema module
#
cinemaApp = angular.module 'Cinema', ['ngResource']
    # configuration handler

cinemaApp.factory 'Cinema', ["$http", ($http) ->
  return {
    query: ->
      $http.get '/cinemas'
  }]
cinemaApp.factory 'Film', ['$http', ($http) ->
  return {
    query: ->
      $http.get '/films.json'
  }]

# cinemaApp.factory 'Film', ["$resource", ($resource) ->
#     $resource('/films/:id.json', { id:'@id'},
#     {
#         update:
#             method: 'PUT'
#     })
# ]


cinemaApp.controller 'CinemaController', ['$scope', 'Cinema', 'Film', '$q', '$http', ($scope, Cinema, Film, $q, $http) ->
    $scope.cinemas_loading = true
    $scope.films_loading = true
    $scope.show_watched = false

    process_results = (results) ->
      $scope.cinemasData = results[0]
      $scope.filmsData = results[1]
      $scope.build_list()

    $scope.build_list = ->
      $scope.films = {}
      for film in  $scope.filmsData.data
        $scope.films[film.id] = film

      $scope.cinemas = {}
      # build initial cinemas list
      for cinema in $scope.cinemasData.data
        $scope.cinemas[cinema.id] = 
          id: cinema.id
          name: cinema.short_name
      # populate it with performances
      for film_id, film of $scope.films
        # ignore watched films if filter enabled
        unless $scope.show_watched || ! $scope.films[film_id].watched
          continue

        for performance in film.performances
          curr_cinema_id = performance.cinema_id
          curr_cinema = $scope.cinemas[curr_cinema_id]
          curr_cinema.films = {} unless curr_cinema.films?
          curr_cinema.films[film_id] = {} unless curr_cinema.films[film_id]?
          c_film = curr_cinema.films[film.id]
          c_film.performances = [] unless c_film.performances?
          c_film.performances.push performance

      $scope.cinemas_loading = false
      $scope.films_loading = false

    log_error = (err) -> console.error err

    $scope.all_ready = $q.all [$http.get('/cinemas'), $http.get('/films.json')]
    $scope.all_ready.then(process_results, log_error)

    $scope.show_long_plot = false
    $scope.perfcount = {}
    $scope.plot_button = "more..."

    $scope.$watch 'show_watched', ->
      $scope.all_ready.then ->
        $scope.build_list()
]



cinemaApp.controller 'FilmController', ['$scope', '$http', ($scope, $http) ->

    $scope.film = $scope.films[$scope.film_id]
    $scope.init = ->
        $scope.plot_button = "more..."
        $scope.show_long_plot = false

    $scope.display_long_plot = (e)->
        if $scope.show_long_plot
            $scope.show_long_plot =  false
            $scope.plot_button = "more..."
        else
            $scope.show_long_plot =  true
            $scope.plot_button = "less..."

    $scope.save = ()->
      $http.put "/films/#{$scope.film_id}",
        watched: $scope.film.watched
]

# Registers modal callbacks once populated
#
cinemaApp.directive 'myPopulateTrailer', () ->
    directiveDefinitionObject =
        link: (scope, iElement, iAttrs) ->
            $(iElement).on('show.bs.modal', (e) ->
                trailer_url = $(@).data('trailer-url')
                frame = $(@).find(".modal-body iframe")
                video_url = trailer_url + '?autoplay=1'
                modal_dialog_width = $(@).find(".modal-dialog").width()
                modal_dialog_height = $(@).find(".modal-dialog").height()
                frame.attr('src', video_url)
                frame.attr('frameborder', 0)
                frame.attr("width", modal_dialog_width - 50)
                frame.attr("height", modal_dialog_height - 50)
                frame.attr("type", "text/html")
                frame.addClass("youtube-video")
                modal_body = $(@).find(".modal-body").append(frame)
                )
            $(iElement).on("hidden.bs.modal", (e) ->
                $(@).find(".modal-body").html('empty')
            )

    return directiveDefinitionObject
