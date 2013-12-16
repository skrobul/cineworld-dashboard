
# Cinema Module
#
# @abstract Main cinema module
#
cinemaApp = angular.module 'Cinema', ['ngResource']
    # configuration handler

cinemaApp.factory 'Cinema', ["$resource", ($resource) ->
    $resource('/cinemas', {}, {
            update: { method: 'PUT' },
        })
]

cinemaApp.factory 'Film', ["$resource", ($resource) ->
    $resource('/films/:id.json', { id:'@id'}, 
    {
        update: 
            method: 'PUT'
    })
]
# cinemaApp.factory 'Films', ["$resource", ($resource) ->
#     $resource('/films', {}, {
#         update:  
#             method: 'PATCH'
#             headers: { 'Content-Type': 'application/json' }
#     })
#]



cinemaApp.controller 'CinemaController', ($scope, Cinema, Film) ->

    $scope.init = () ->
        #@cinemaService = new Cinema()
        $scope.cinemas = Cinema.query()
        $scope.films = Film.query()
        $scope.show_long_plot = false
       # $scope.plot_button = "more..."

    $scope.film_in_cinema = (cinema_id) ->
        films = []
        angular.forEach $scope.films, (film) ->
            local_performances = []
            angular.forEach film.performances, (performance) ->
                if performance.cinema_id == cinema_id
                    local_performances.unshift(performance)
            if local_performances.length > 0
                film.performances = local_performances
                films.unshift(film)
        films



cinemaApp.controller 'FilmController', ($scope, Film) ->
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
        console.log $scope.film.$update()
        console.log("saving #{$scope.film.id}=#{$scope.film.watched}")