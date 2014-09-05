
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="asmtUserLayout" />
    </head>
    <body>
    
    <div>
    	Welcome ${individual?.toString()} !
    	You have registered for ${ics.IndividualAssessment.findAllByIndividual(individual).collect{it.assessment.name+" on "+it.eventRegistration.dateCreated.format('dd-MM-yyyy HH:mm:ss')+" with registration code "+it.eventRegistration.regCode}}
    	Please study the material, practise with mock test , take the formal test and explore further. All the best!! 
    </div>
	
    </body>
</html>
