
<%@ page import="ics.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <gui:resources components="['autoComplete']" />
		<style>
		    .yui-skin-sam .yui-ac-content {
		      width: 350px !important;
		</style>
	
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'timepicker.css')}" type="text/css">
    </head>
    <body>

	    	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
	    	<g:javascript src="jquery-ui-timepicker-addon.js" />
	    	<script type="text/javascript">
	            $(document).ready(function()
	            {
			$('#startDate').datetimepicker({
			    onClose: function(dateText, inst) {
				var endDateTextBox = $('#endDate');
				if (endDateTextBox.val() != '') {
				    var testStartDate = new Date(dateText);
				    var testEndDate = new Date(endDateTextBox.val());
				    if (testStartDate > testEndDate)
					endDateTextBox.val(dateText);
				}
				else {
				    endDateTextBox.val(dateText);
				}
			    },
			    onSelect: function (selectedDateTime){
				var start = $(this).datetimepicker('getDate');
				$('#endDate').datetimepicker('option', 'minDate', new Date(start.getTime()));
			    },
			    dateFormat: 'dd-mm-yy'
			});
			$('#endDate').datetimepicker({
			    onClose: function(dateText, inst) {
				var startDateTextBox = $('#startDate');
				if (startDateTextBox.val() != '') {
				    var testStartDate = new Date(startDateTextBox.val());
				    var testEndDate = new Date(dateText);
				    if (testStartDate > testEndDate)
					startDateTextBox.val(dateText);
				}
				else {
				    startDateTextBox.val(dateText);
				}
			    },
			    onSelect: function (selectedDateTime){
				var end = $(this).datetimepicker('getDate');
				$('#startDate').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
			    },
			    dateFormat: 'dd-mm-yy'
			});          	
	            })
    	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${eventInstance?.id}" />
                <g:hiddenField name="version" value="${eventInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="event.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${eventInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="event.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${eventInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="startDate"><g:message code="event.startDate.label" default="Start Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'startDate', 'errors')}">
                                    <!--<g:datePicker name="startDate" precision="minute" value="${eventInstance?.startDate}"  />-->
                                    <g:textField name="startDate" value="${(eventInstance?.startDate)?.format('dd-MM-yyyy  HH:mm')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="endDate"><g:message code="event.endDate.label" default="End Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'endDate', 'errors')}">
                                    <!--<g:datePicker name="endDate" precision="minute" value="${eventInstance?.endDate}"  />-->
                                    <g:textField name="endDate" value="${(eventInstance?.endDate)?.format('dd-MM-yyyy  HH:mm')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="venue"><g:message code="event.venue.label" default="Venue" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'venue', 'errors')}">
                                    <g:textField name="venue" value="${eventInstance?.venue}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contactPerson"><g:message code="event.contactPerson.label" default="Contact Person" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'contactPerson', 'errors')}">
					<g:hiddenField name="contactPerson.id" value="" />
					<div style="width: 300px">
						<gui:autoComplete
						id="acContactPerson"
						width="300px"
						controller="individual"
						action="allIndividualsExceptDummyDonorAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'
						/>
					</div>
                                </td>
                            </tr>
                            
                            <g:if test="${eventInstance?.contactPerson}">
                            <tr class="prop">
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'contactPerson', 'errors')}" width="25%">
	                               <g:hiddenField name="h_contactPerson.id" value="${eventInstance?.contactPerson?.id}" />
	                               <g:checkBox name="contactPersonChkBox" value="${true}"/> Use This Name?
                                </td>
                                <td valign="top" class="name" align="left">
                                    ${eventInstance?.contactPerson}
                                </td>
                            </tr>
                            </g:if>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="event.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${eventInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="event.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list(sort:'name')}"  optionKey="id" value="${eventInstance?.department?.id}"  noSelection="['':'-Choose Department-']"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="event.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${eventInstance?.comments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="participants"><g:message code="event.participants.label" default="Participants" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'participants', 'errors')}">
                                    
<ul>
<g:each in="${eventInstance?.participants?}" var="p">
    <li><g:link controller="eventParticipant" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="eventParticipant" action="create" params="['event.id': eventInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'eventParticipant.label', default: 'EventParticipant')])}</g:link>

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
