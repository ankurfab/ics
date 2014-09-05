
<%@ page import="ics.Followup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'followup.label', default: 'Followup')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <gui:resources components="['autoComplete']" />
	<style>
	    .yui-skin-sam .yui-ac-content {
	      width: 350px !important;
	</style>

	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
        
    </head>
    <body>

    	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    	<script type="text/javascript">
            $(document).ready(function()
            {
        	$("#startDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
        	$("#endDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          	
            })
    	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="search">Search</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${followupInstance}">
            <div class="errors">
                <g:renderErrors bean="${followupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="followupWith"><g:message code="followup.followupWith.label" default="Followup With" /></label>
                                </td>

                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'followupWith', 'errors')}">
                                	${followupInstance.followupWith}
                                	<g:hiddenField name="followupWith.id" value="${followupInstance.followupWith.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="followupBy"><g:message code="followup.followupBy.label" default="Followup By" /></label>*
                                </td>
                                
                                
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'followupBy', 'errors')}">
                                <g:hiddenField name="followupBy.id" value="" />
							   <div style="width: 300px">
								<gui:autoComplete
									id="acfollowupBy"
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
                                    <label for="startDate"><g:message code="followup.startDate.label" default="Start Date" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'startDate', 'errors')}">
                                    <!--<g:datePicker name="startDate" precision="minute" value="${followupInstance?.startDate}"  />-->
                                    <g:textField name="startDate" precision="day" value="${(followupInstance?.startDate?:new Date())?.format('dd-MM-yyyy')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="endDate"><g:message code="followup.endDate.label" default="End Date" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'endDate', 'errors')}">
                                    <!--<g:datePicker name="endDate" precision="minute" value="${followupInstance?.endDate}" noSelection="['': '']" />-->
                                    <g:textField name="endDate" precision="minute" value="${(followupInstance?.endDate?:new Date())?.format('dd-MM-yyyy')}" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="followup.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'category', 'errors')}">
                                    ${followupInstance?.category}
                                    <g:hiddenField name="category" value="${followupInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ref"><g:message code="followup.ref.label" default="Reference" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'ref', 'errors')}">
                                    <g:hiddenField name="ref" value="${followupInstance.ref}" />
                                    ${followupInstance?.ref}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="followup.description.label" default="Description" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${followupInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="followup.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'status', 'errors')}">
                                    ${followupInstance?.status}
                                    <g:hiddenField name="status" value="${followupInstance.status}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="followup.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${followupInstance?.comments}" rows="4" cols="50"/>
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
