<html>
    <head>
        <title></title>
		<meta name="layout" content="main" />
		
	
    </head>
    <body>
    

			<div id="body">
	        <h1>Events</h1>
	           <!--<br> -->
	           <div id="controllerList" class="dialog">
		    				<!--<h2>Available Reports:</h2>-->

	            <!--<ul>-->
	      <table>
	      <!--<thead>
	      <tr>
		      <th>
		      		<b>Events</b>
		      </th>
	      </tr>
	      </thead>-->
		<tbody bgcolor="lavender">
	      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
		  <tr>
		    <td>
          		<g:link controller="event" action="list">Event Master</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="eventParticipant" action="list">Event Management</g:link>
                    </td>
                  </tr>

	      		
	      </sec:ifAnyGranted>
	      
	       </tbody>
	   </table>
	            <!--</ul>-->
	</div>
	</div>
	
    </body>
</html>