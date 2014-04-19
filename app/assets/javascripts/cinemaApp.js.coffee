
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


cinemaApp.controller 'CinemaController', ['$scope', 'Cinema', 'Film', ($scope, Cinema, Film) ->

    $scope.init = () ->
        #@cinemaService = new Cinema()
        $scope.cinemas = Cinema.query()
        $scope.films = Film.query()


        # $scope.cinemas = Cinema.query()
        # $scope.films = Film.query()
        $scope.show_long_plot = false
        $scope.perfcount = {}
        $scope.plot_button = "more..."
    $scope.init()
    $scope.film_in_cinema = (cinema_id) ->
        films = []
        $scope.films.forEach (film) ->
            local_performances = []
            film.performances.forEach (performance) ->
                if performance.cinema_id == cinema_id
                    local_performances.push(performance)
            if local_performances.length > 0
                film.performances[cinema_id] = local_performances
                films.push(film)
        films
    $scope.count_performances_in_cinema = (cinema_id) ->
        return $scope.perfcount[cinema_id] if $scope.perfcount[cinema_id]
        pcount = 0
        $scope.films.forEach (film) ->
            film.performances.forEach (perf) ->
                pcount++ if perf.cinema_id == cinema_id
        $scope.perfcount[cinema_id] = pcount
        pcount

    $scope.filter_watched = (element) ->
        if $scope.show_watched
            return true
        else
            return ! element.watched
]



cinemaApp.controller 'FilmController', ['$scope', 'Film', ($scope, Film) ->
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
        $scope.film.$update()
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
