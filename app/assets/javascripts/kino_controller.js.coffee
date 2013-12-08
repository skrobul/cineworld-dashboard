# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
show_full_plot = (src) ->
    review = src.closest(".review")
    review.find(".hide_full_plot").show()
    review.find(".short_plot").hide()
    src.hide()
    show_still(review)
    review.find(".full_plot").fadeIn()

show_still = (src) ->
    stdiv = src.parent().find(".still")
    stdiv.find("img").attr('src', stdiv.data('still-url'))
    stdiv.show()

hide_full_plot = (src) ->
    review = src.closest(".review")
    review.find(".full_plot").hide()
    review.find(".short_plot").fadeIn()
    review.find(".show_full_plot").show()
    review.find(".still").hide()
    src.hide()

jQuery -> 
    $(".show_full_plot").click(->
        show_full_plot($(this))
    )
    $(".hide_full_plot").click(->
        hide_full_plot($(this))
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