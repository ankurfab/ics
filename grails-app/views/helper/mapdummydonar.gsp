<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Map Dummy Donar</title>
    </head>
    <body>
        <div class="body">
            <h1>Map Donation</h1>
            <g:if test="${donation}">
            <g:link controller="donation" action="show" id="${donation?.id}">${donation.comments}<p>${donation}</g:link>
            <g:form action="linkdonar" method="post" >
            <g:hiddenField name="donationid" value="${donation.id}" />
	<div class="buttons">
	    <g:checkBox name="fuzzy" value="${true}" />FuzzySearch?
	    <span class="button"><g:submitButton name="map" class="save" value="MapAndShow" /></span>
	    <span class="button"><g:submitButton name="map" class="save" value="MapAndContinue" /></span>
	    <span class="button"><g:submitButton name="map" class="save" value="Skip" /></span>
	</div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th> Select </th>
                            <th> Suggested Donar </th>
                            <th> Compare </th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individuals}" status="i" var="donar">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td> <g:radio name="individualRadio" value="${donar?.id}" checked="false"/> </td>
                        
                            <td> <g:link controller="individual" action="show" id="${donar?.id}">${donar}</g:link></td>

                            <td> <g:if test="${i != 0}">
                            	<g:link controller="individual" action="doubleshow" id="${donar?.id}" params="[id2: previd]">Compare With Previous</g:link>
                            	</g:if>
                            </td>
                            
                            <g:set var="previd" value="${donar?.id}" />
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                <div class="buttons">
                    <g:checkBox name="fuzzy" value="${true}" />FuzzySearch?
                    <span class="button"><g:submitButton name="map" class="save" value="MapAndShow" /></span>
                    <span class="button"><g:submitButton name="map" class="save" value="MapAndContinue" /></span>
                    <span class="button"><g:submitButton name="map" class="save" value="Skip" /></span>
                </div>
            </g:form>
            </g:if>
       </div>
    </body>
</html>