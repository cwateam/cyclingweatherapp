$(function () {
    $('[data-toggle="popover"]').popover({
	html : true,
	content: function() {
	    return $('#popover_content_wrapper').html();
	}
    })
})

$( "#target" ).submit(function( event ) {
    alert( "Handler for .submit() called." );
    event.preventDefault();
});

/*
$('#weather').children().attr('disabled', 'disabled');
*/
