
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="asmtUserLayout" />
    </head>
    <body>
    
	<g:each in="${ics.Content.findAllWhere(department:(er?.event?.department?:ics.Department.findByName('GPL')),language:ics.IndividualAssessment.findByIndividual(individual)?.language?:'ENGLISH',category:'POST')?.htmlContent}">
	    <div>
		<p>${it}</p><br>
	    </div>
	</g:each>
	
    </body>
</html>
