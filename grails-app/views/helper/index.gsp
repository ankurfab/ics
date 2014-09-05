<!doctype html>
<html>
    <head>
        <title></title>
	<meta name="layout" content="main" />
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'show_hide_div.css')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'show_hide_div.css')}" type="text/css">
    </head>
    <body>
	  	<script type="text/javascript" charset="utf-8">
	  		
	  		$(document).ready(function(){
	  
	  			$(".show_hide").show();
	  			$(".slidingDiv").hide();
	  
	  		    $('.show_hide').click(function(){
	  		    $(".slidingDiv").slideToggle();
	  		    });
	  
	  		});
	  
	  
	      </script>	
 


    <div class="banner">
    <sec:ifNotLoggedIn>
      <!--<a href='#' onclick='showLogin(); return false;'>-->
      <g:link controller="login">
      Please login!!
      <!--<img src="${resource(dir:'images',file:'SSRKB_1250.JPG')}" alt="" onload="hidequote();"/>-->
      <!--</a>-->
      </g:link>
      </sec:ifNotLoggedIn>
      <sec:ifLoggedIn>
      <b>Hare Krishna!</b>
	<br><br>
      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">


			${displayString}

	</sec:ifAnyGranted>
      
      <!--<img src="${resource(dir:'images',file:'SSRKB_1250.JPG')}" alt="" onload="hidequote();"/>-->
      </sec:ifLoggedIn>
    </div>
    	<g:javascript>

	    function hidequote() {
		var ele = document.getElementById('spquote');
		ele.style.display = "none";
	    } 
	</g:javascript>

    </body>
</html>