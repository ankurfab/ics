<html>
    <head>
        <title></title>
		<meta name="layout" content="main" />
    </head>
    <body>
			<div id="pageBody">
	        <h1>Welcome to ICS</h1>
	        <p>Hare Krishna! All Glories to Srila Prabhupada! All Glories to Shri Guru and Shri Gauranga!! Below is a list of controllers that are currently deployed in this application,
	        click on each to execute its default action:</p>

	        <div id="controllerList" class="dialog">
				<h2>Available Controllers:</h2>
	            <ul>
	              <g:each var="c" in="${grailsApplication.controllerClasses}">
	                    <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
	              </g:each>
	            </ul>
	        </div>
		</div>
	
    </body>
</html>