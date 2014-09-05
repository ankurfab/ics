
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Dashboard For ${individualInstance} </title>
	<r:require module="jqui" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="show" id="${individualInstance?.id}" params="[profile:true]">Profile View</g:link></span>
            <span class="menuButton"><g:link class="list" action="show" id="${individualInstance?.id}">Detailed View</g:link></span>
        </div>
        <div class="body">
            <div>
            	<h1>${individualInstance}</h1>
            	<img id="photo" name="photo" class="avatar" src="${createLink(action:'avatar_image', id:individualInstance?.id)}" />
            	Profile 40% Complete!!
            </div>
 	    <div id="divStats" style="margin-top:20px; width:600px; height:200px;float:left;">	    	
	    	<g:render template="vitalstats"  model="['individualInstance':individualInstance]"/>
	    </div>
	    <div id="divStats" style="margin-top:20px; width:600px; height:200px;float:left;">	    	
	    	<g:render template="sadhna" model="['individualInstance':individualInstance]"/>
	    </div>
	    <div id="divStats" style="margin-top:20px; width:600px; height:200px;float:left;">	    	
	    	<g:render template="seva" model="['individualInstance':individualInstance]"/>
	    </div>
	    <div id="divStats" style="margin-top:20px; width:600px; height:200px;float:left;">	    	
	    	<g:render template="sadachar" model="['individualInstance':individualInstance]"/>
	    </div>
           
            
        </div>

	<script>

$(document).ready(function(){

});

	</script>



    </body>
</html>
