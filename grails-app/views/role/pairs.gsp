
<%@ page import="ics.Role" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="plain" />
        <g:set var="roleInstance" value="${Role.get(id)}" />
        <title>${roleInstance}</title>
    </head>
    <body>
        <div class="nav">
        </div>
        <div class="body">
            <!--<h1>${roleInstance}</h1>-->
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table border='1'>
                    <tbody>
                <g:each in="${result}" var="pair"> 
                    	<tr>
                    	<td>
				<table border="1">
				<g:each in="${pair}" var="ind"> 				
					<tr>
						<td><g:link target="_new" controller="individual" action="show" id="${ind.icsid}">${ind.icsid}</g:link></td>
						<td>${ind.toString()}</td>
						<td>${ics.VoiceContact.findByIndividualAndCategory(ind,'CellPhone')?.number?:''}</td>
						<td>${ics.EmailContact.findByIndividualAndCategory(ind,'Personal')?.emailAddress?:''}</td>
						<td/>
					</tr>
				 </g:each>
				 </table>
		         </td>
		         </tr>
                        
               </g:each>
                    
                    </tbody>
                </table>
            </div>
    </body>
</html>
