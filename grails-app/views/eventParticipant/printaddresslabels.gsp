
<%@ page import="ics.EventParticipant" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="printaddress" />
        <g:set var="entityName" value="${message(code: 'eventParticipant.label', default: 'EventParticipant')}" />
        <title>Print Address Labels</title>
        
    </head>
    <body>
        <div class="body">
            <!--<h1>Invite EventParticipant</h1>-->
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventParticipantInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventParticipantInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div>
                <g:each in="${InviteeList}" status="i" var="inv">
                    <table border="0">
                        <tbody border="0">
                          <tr border="0">
							<td border="0">
								<b>${inv}</b>
							</td>
                          </tr>
                          	<g:if test="${InviteeAddressList.addressLine1[i]}">
							  <tr border="0">
							   <td border="0">
									${InviteeAddressList.addressLine1[i]},
								</td>
							  </tr>
						 	</g:if>
						 	<g:if test="${InviteeAddressList.addressLine2[i]}">
							  <tr border="0">
								<td border="0">
									${InviteeAddressList.addressLine2[i]},
								</td>
							  </tr>
							 </g:if>
                          	<g:if test="${InviteeAddressList.addressLine3[i]}">
							  <tr border="0">
								<td border="0">
									${InviteeAddressList.addressLine3[i]},
								</td>
							  </tr>
                         	</g:if>
                          <tr border="0">
							<td border="0">
								PIN-${InviteeAddressList.pincode[i]}, ${InviteeAddressList.city[i]},
							</td>
                           </tr>
                          <tr border="0">
							<td border="0">
								${InviteeAddressList.state[i]}, ${InviteeAddressList.country[i]}.
							</td>
                           </tr>
                          
                        </tbody>
                    </table>
                    </g:each>
                </div>
            </g:form>
        </div>
    </body>
</html>
