<html>

    <head>
        <title>Pending Items</title>
		<meta name="layout" content="main" />
		
	
    </head>
    <body>
    

			<div id="body">
	        <h1>Pending Items</h1>
	           
	           <div id="pendingItemsList" class="dialog">
	       <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
		    				
		      <table>
		      
			<tbody bgcolor="lavender">
			<g:if test="${pendingItemsList.size()>0}">

			<g:each in="${pendingItemsList}" status="i" var="pendingItem">
			  <tr>
			    <td width="1%">
				<b>${i+1}</b>
			    </td>
			  
			    <td width="99%">
				${pendingItemsList[i]}
			    </td>
			  </tr>
			</g:each>
			</g:if>
			<g:else>
			  <tr>
			    <td>
			    	<b>There are no pending items.</b>
			    </td>
			  </tr>
			</g:else>
		       </tbody>
		   </table>
		   
	    	</sec:ifAnyGranted>        
	</div>
	</div>
	
    </body>
</html>