
<%@ page import="ics.EventParticipant" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventParticipant.label', default: 'EventParticipant')}" />
        <title>Invite EventParticipant</title>
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><g:link class="create" action="printaddresslabels" params="['donationIdList': donationIdList, 'InviteeList': InviteeList]">Print Address Labels</g:link></span>-->
        </div>
        <div class="body">
            <h1>Invite EventParticipant</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventParticipantInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventParticipantInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form name="inviteForm" action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="event"><g:message code="eventParticipant.event.label" default="Event" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventParticipantInstance, field: 'event', 'errors')}">
                                    <g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventParticipantInstance?.event?.id}"  />
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="Invitees">Invitees</label>
                                </td>
                                <td valign="top" class="value">
                                
									<ul>
									<g:each in="${donationList}" var="inv">
										<li><g:link controller="individual" action="show" id="${inv.donatedBy.id}">${inv?.donatedBy?.encodeAsHTML()}</g:link> <g:link controller="donation" action="show" id="${inv.id}">[${inv?.encodeAsHTML()}]</g:link></li>
										
									</g:each>
									</ul>
									
								
                                </td>
                            </tr>
                            
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="eventParticipant.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventParticipantInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${eventParticipantInstance?.comments}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                </g:form>
                <g:form name="saveForm" controller="eventParticipant" action="savefrominvite" >
                <div class="buttons">
                	<g:hiddenField name="event.id" id="event.id" value=""/>
                	<g:hiddenField name="comments" id="comments" value=""/>
                	<g:hiddenField name="donationIds" id="donationIds" value="${donationIdList}"/>
                    <span class="button"><g:actionSubmit class="save"  action="savefrominvite" onclick="return assignHidden();" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                   
                </div>
                </g:form>
            
        </div>
        <script language="javascript"> 
        	function assignHidden()
        	{
         		document.saveForm.elements[0].value = document.inviteForm.elements[0].value;
        		document.saveForm.comments.value = document.inviteForm.comments.value;
         		return true;
        	}
        </script>
    </body>
</html>
