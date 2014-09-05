
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title>
        	<g:if test="${type}">
        		${type} List
        	</g:if>
        	<g:else>
        		<g:message code="default.list.label" args="[entityName]" />
        	</g:else>
        </title>
	<link rel="stylesheet" href="${resource(dir: 'css/tablesort-theme', file: 'style.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
    </head>
    <body>
	<g:javascript src="datatable/jquery.dataTables.min.js" />    
	<g:javascript src="datatable/ZeroClipboard.js" />    
	<g:javascript src="datatable/TableTools.min.js" />    
	<script type="text/javascript" charset="utf-8">
		$(document).ready( function () {
		    $('#listTable').dataTable( {
			"sDom": 'T<"clear">lfrtip',
			"oTableTools": {
			    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"
			}
		    } );
		} );

	</script>                
    <br>
    <br>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifAnyGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
	         <span class="menuButton"><g:link class="create" action="create" params="[type:type]">Add ${type}</g:link></span>
            </sec:ifAnyGranted>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
	        <span class="menuButton"><g:link class="create" controller="person" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            	<span class="menuButton"><g:link class="list" controller="helper" action="searchIndividual">SearchIndividual</g:link></span>
            </sec:ifNotGranted>
        </div>
        <div class="body">
            <h1>
        	<g:if test="${type}">
        		${type} List
        	</g:if>
        	<g:else>
        		<g:message code="default.list.label" args="[entityName]" />
        	</g:else>
            </h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

	<g:hiddenField name="type" value="${type}" />


            <div class="list">
                <table id="listTable">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Legal Name</th>
                            <th>Initiated Name</th>
                            <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                            	<g:if test="${loggedInUserRole == 'PatronCare'}">
                            		<th>Cultivator</th>
                            	</g:if>
                            </sec:ifAnyGranted>
                            <th>DoB</th>
                            <th>DoM</th>
                            <th>Family</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualInstanceList}" status="i" var="individualInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${individualInstance?.id}"><g:formatNumber number="${individualInstance?.id}" format="#" /></g:link></td>
                        
                            <td>${individualInstance?.legalName}</td>
                            <td>${individualInstance?.initiatedName}</td>
                            <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                            	<g:if test="${loggedInUserRole == 'PatronCare'}">
					<g:set var="crel" value="${ics.Relation.findByName('Cultivated by')}" />
					<g:set var="cultivator" value="${ics.Relationship.findByIndividual1AndRelation(Individual.get(individualInstance?.id),crel)?.individual2}" />
                            		<td>${cultivator}</td>
                            	</g:if>
                            </sec:ifAnyGranted>
                    
                            <td><g:formatDate format="dd-MM-yyyy" date="${individualInstance?.dob}" /></td>
                            <td><g:formatDate format="dd-MM-yyyy" date="${individualInstance?.marriageAnniversary}" /></td>
                            <td><g:each in="${individualInstance?.relative2?}" var="r">
				<g:if test="${r?.relationshipGroup?.groupName != 'dummy'}">
				    <li><g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
				</g:if>
			</g:each>
			<g:each in="${individualInstance?.relative1?}" var="r">
				<g:if test="${r?.relationshipGroup?.groupName != 'dummy'}">
				    <li><g:link controller="relationship" action="show" id="${r.id}">${(r?.relation?.toString() +" -> " + r?.individual2)?.encodeAsHTML()}</g:link></li>
				</g:if>
			</g:each>			
			</td>
                            <td>${individualInstance?.address?.toString()}</td>
                            <td>${individualInstance?.emailContact?.toString()}</td>
                            <td>${individualInstance?.voiceContact?.toString()}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${!search && flag}">
            <div class="paginateButtons">
                <g:paginate total="${individualInstanceTotal}" />
            </div>
            </g:if>
        </div>
    </body>
</html>
