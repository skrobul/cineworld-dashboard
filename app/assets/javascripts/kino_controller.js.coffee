# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
    $(".show_full_plot").click(->
        $(@).parent().hide()
        $(@).parent().next().fadeIn()
    )

# workaround for collapsed navbar
$(document).on('click','.navbar-collapse.in', (e) -> 
    if $(e.target).is('a')  
        $(this).removeClass('in').addClass('collapse')
)