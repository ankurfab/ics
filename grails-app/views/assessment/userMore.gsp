
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="asmtUserLayout" />
    </head>
    <body>
    
	<g:each in="${ics.Content.findAllByLanguageAndCategory(ics.IndividualAssessment.findByIndividual(individual)?.language?:'ENGLISH','POST')?.htmlContent}">
	    <div>
		<p>${it}</p><br>
	    </div>
	</g:each>
	
    </body>
</html>
