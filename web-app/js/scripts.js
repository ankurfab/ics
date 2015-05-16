
jQuery(document).ready(function() {
	
    /*
        Fullscreen background
    */
    $.backstretch($('#bg').attr('src'));
    
    $('#top-navbar-1').on('shown.bs.collapse', function(){
    	$.backstretch("resize");
    });
    $('#top-navbar-1').on('hidden.bs.collapse', function(){
    	$.backstretch("resize");
    });
});
