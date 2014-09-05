
<%@ page import="ics.EventParticipant" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventParticipant.label', default: 'EventParticipant')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
		<gui:resources components="['autoComplete']"/>
		<style>
			.yui-skin-sam .yui-ac-content {
			 width: 350px !important;}
		</style>
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventParticipantInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventParticipantInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
                                    <label for="individual"><g:message code="eventParticipant.individual.label" default="Individual" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventParticipantInstance, field: 'individual', 'errors')}">

					<g:hiddenField name="individual.id" value="" />
					<div style="width: 300px">
						<gui:autoComplete
						id="acDonatedBy"
						width="300px"
						controller="individual"
						action="allIndividualsExceptDummyDonorAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'
						/>
					</div>
                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attended"><g:message code="eventParticipant.attended.label" default="Attended" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventParticipantInstance, field: 'attended', 'errors')}">
                                    <g:checkBox name="attended" value="${eventParticipantInstance?.attended}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="invited"><g:message code="eventParticipant.invited.label" default="Invited" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventParticipantInstance, field: 'invited', 'errors')}">
                                    <g:checkBox name="invited" value="${eventParticipantInstance?.invited}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="confirmed"><g:message code="eventParticipant.confirmed.label" default="Confirmed" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventParticipantInstance, field: 'confirmed', 'errors')}">
                                    <g:checkBox name="confirmed" value="${eventParticipantInstance?.confirmed}" />
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
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
