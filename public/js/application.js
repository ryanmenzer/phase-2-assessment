$(document).ready(function() {

    $('#create_event').click(function(event){
        event.preventDefault();

        $.get('/events/new', function(form){
            $('.container').append(form);
        });
    });

    $('.container').on('submit', '#new_event', function(event){
        event.preventDefault();
        var url = $(this).attr('action');
        var data = $(this).serialize();

        $.post(url, data, function(response){
            $('body').html(response);
        });

        $('h1:last').remove();
        $(this).remove();

    });

});
