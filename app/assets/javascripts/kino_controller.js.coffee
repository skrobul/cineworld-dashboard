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
        frame = $(@).find(".modal-body iframe")
        video_url = trailer_url + '?autoplay=1'
        modal_dialog_width = $(@).find(".modal-dialog").width()
        modal_dialog_height = $(@).find(".modal-dialog").height()
        console.log("Modal width: " + modal_dialog_width)
        frame.attr('src', video_url)
        frame.attr('frameborder', 0)
        frame.attr("width", modal_dialog_width - 50)
        frame.attr("height", modal_dialog_height - 50)
        frame.attr("type", "text/html")
        frame.addClass("youtube-video")
        modal_body = $(@).find(".modal-body").append(frame)
    )
    $(".trailer_modal").on("hidden.bs.modal", (e) ->
        $(@).find(".modal-body").html('empty')
    )

# workaround for collapsed navbar
$(document).on('click','.navbar-collapse.in', (e) -> 
    if $(e.target).is('a')  
        $(this).removeClass('in').addClass('collapse')
)