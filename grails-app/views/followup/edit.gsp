
<%@ page import="ics.Followup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'followup.label', default: 'Followup')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list1"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="search">Search</g:link></span>-->
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${followupInstance}">
            <div class="errors">
                <g:renderErrors bean="${followupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${followupInstance?.id}" />
                <g:hiddenField name="version" value="${followupInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="followupWith"><g:message code="followup.followupWith.label" default="Followup With" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'followupWith', 'errors')}">
                                    ${followupInstance?.followupWith}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="followupBy"><g:message code="followup.followupBy.label" default="Followup By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'followupBy', 'errors')}">
                                    ${followupInstance?.followupBy}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="startDate"><g:message code="followup.startDate.label" default="Start Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'startDate', 'errors')}">
                                    <g:formatDate format="dd-MM-yyyy" date="${followupInstance?.startDate}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="endDate"><g:message code="followup.endDate.label" default="End Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'endDate', 'errors')}">
                                    <g:formatDate format="dd-MM-yyyy" date="${followupInstance?.endDate}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="followup.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'category', 'errors')}">
                                    ${followupInstance?.category}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ref"><g:message code="followup.ref.label" default="Reference" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'ref', 'errors')}">
                                    ${followupInstance?.ref}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="followup.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'description', 'errors')}">
                                    ${followupInstance?.description}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="followup.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${['OPEN','CLOSED','DELETED']}" value="${followupInstance?.status}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments">Old Comments </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'comments', 'errors')}">
                                	<!--<label>${followupInstance?.comments} </label>-->
		                <g:textArea name="oldcomments" value="${followupInstance?.comments}" rows="5" cols="40" readonly="true" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="followup.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'comments', 'errors')}">
                                    <!--<g:textField name="comments" value="" />-->
		                    <g:textArea name="comments" value="" rows="5" cols="40" />
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
