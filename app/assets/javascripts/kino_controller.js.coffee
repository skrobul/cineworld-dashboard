# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
    $(".show_full_plot").click(->
        $(@).parent().hide()
        $(@).parent().next().fadeIn()
    )
    $(".trailer_modal").on('show.bs.modal', (e) ->
        trailer_url = $(@).data('trailer-url')
        modal_body = $(@).find(".modal-body").html(trailer_url)
    )
    $(".trailer_modal").on("hidden.bs.modal", (e) ->
        $(@).find(".modal-body").html('empty')
    )

# workaround for collapsed navbar
$(document).on('click','.navbar-collapse.in', (e) -> 
    if $(e.target).is('a')  
        $(this).removeClass('in').addClass('collapse')
)