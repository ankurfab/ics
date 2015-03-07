
<%@ page import="ics.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <gui:resources components="['autoComplete']"/>
		<style>
			.yui-skin-sam .yui-ac-content {
			  width: 350px !important;
		</style>

	<r:require module="dateTimePicker" />
        
    </head>
    <body>
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
		$('#regstartDate').datetimepicker({
		    onClose: function(dateText, inst) {
			var regendDateTextBox = $('#regendDate');
			if (regendDateTextBox.val() != '') {
			    var testStartDate = new Date(dateText);
			    var testEndDate = new Date(regendDateTextBox.val());
			    if (testStartDate > testEndDate)
				regendDateTextBox.val(dateText);
			}
			else {
			    regendDateTextBox.val(dateText);
			}
		    },
		    onSelect: function (selectedDateTime){
			var start = $(this).datetimepicker('getDate');
			$('#regendDate').datetimepicker('option', 'minDate', new Date(start.getTime()));
		    },
		    dateFormat: 'dd-mm-yy'
		});
		$('#regendDate').datetimepicker({
		    onClose: function(dateText, inst) {
			var regstartDateTextBox = $('#regstartDate');
			if (regstartDateTextBox.val() != '') {
			    var testStartDate = new Date(regstartDateTextBox.val());
			    var testEndDate = new Date(dateText);
			    if (testStartDate > testEndDate)
				regstartDateTextBox.val(dateText);
			}
			else {
			    regstartDateTextBox.val(dateText);
			}
		    },
		    onSelect: function (selectedDateTime){
			var end = $(this).datetimepicker('getDate');
			$('#regstartDate').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
		    },
		    dateFormat: 'dd-mm-yy'
		});          	
            })
    	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="event.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'category', 'errors')}">
                                    <g:select name="category"
				              from="${ics.Event.createCriteria().list{projections{distinct('category')}}}"
				              value="${eventInstance?.category}"/>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="event.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'type', 'errors')}">
                                    <g:select name="type"
				              from="${ics.Event.createCriteria().list{projections{distinct('type')}}}"
				              value="${eventInstance?.type}"/>                                    
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
                                    <!--<g:datePicker name="startDate" precision="minute" value="${eventInstance?.startDate}" />-->
                                    <!--<g:textField name="startDate" precision="day" value="${(eventInstance?.startDate?:new Date())?.format('dd-MM-yyyy')}"  />-->
                                    <g:textField name="startDate" precision="minute" value="${(eventInstance?.startDate)}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="endDate"><g:message code="event.endDate.label" default="End Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'endDate', 'errors')}">
                                    <!--<g:datePicker name="endDate" precision="minute" value="${eventInstance?.endDate}"  />-->
                                    <!--<g:textField name="endDate" precision="day" value="${(eventInstance?.endDate?:new Date())?.format('dd-MM-yyyy')}"  />-->
                                    <g:textField name="endDate" precision="minute" value="${(eventInstance?.endDate)}"  />
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
                                    <label for="regstartDate"><g:message code="event.regstartDate.label" default="Registration Start Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'regstartDate', 'errors')}">
                                    <!--<g:datePicker name="regstartDate" precision="minute" value="${eventInstance?.regstartDate}" />-->
                                    <!--<g:textField name="regstartDate" precision="day" value="${(eventInstance?.regstartDate?:new Date())?.format('dd-MM-yyyy')}"  />-->
                                    <g:textField name="regstartDate" precision="minute" value="${(eventInstance?.regstartDate)}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="regendDate"><g:message code="event.regendDate.label" default="Registration End Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'regendDate', 'errors')}">
                                    <!--<g:datePicker name="regendDate" precision="minute" value="${eventInstance?.regendDate}"  />-->
                                    <!--<g:textField name="regendDate" precision="day" value="${(eventInstance?.regendDate?:new Date())?.format('dd-MM-yyyy')}"  />-->
                                    <g:textField name="regendDate" precision="minute" value="${(eventInstance?.regendDate)}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="registrationMode"><g:message code="event.registrationMode.label" default="Registration Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'registrationMode', 'errors')}">
					<g:select name="registrationMode" from="${['ByInvitation','Counsellor','Counsellee','Devotee','WellWisher','Public']}" value="${eventInstance?.registrationMode}"
						  noSelection="['':'-Choose Registration Mode-']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="event.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'status', 'errors')}">
					<g:select name="status" from="${['PARKED','OPEN','CLOSE','OVER','DELETED']}" value="${eventInstance?.status}"
						  noSelection="['':'-Choose status-']"/>
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
