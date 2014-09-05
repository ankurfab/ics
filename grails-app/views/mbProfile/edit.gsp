
<%@ page import="ics.MbProfile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="mbProfile.edit" default="Edit MbProfile" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="mbProfile.list" default="MbProfile List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="mbProfile.new" default="New MbProfile" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="mbProfile.edit" default="Edit MbProfile" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${mbProfileInstance}">
            <div class="errors">
                <g:renderErrors bean="${mbProfileInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${mbProfileInstance?.id}" />
                <g:hiddenField name="version" value="${mbProfileInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="candidate"><g:message code="mbProfile.candidate" default="Candidate" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'candidate', 'errors')}">
                                    <g:select name="candidate.id" from="${ics.Individual.list()}" optionKey="id" value="${mbProfileInstance?.candidate?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="referredBy"><g:message code="mbProfile.referredBy" default="Referred By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'referredBy', 'errors')}">
                                    <g:select name="referredBy.id" from="${ics.Individual.list()}" optionKey="id" value="${mbProfileInstance?.referredBy?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="assignedTo"><g:message code="mbProfile.assignedTo" default="Assigned To" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'assignedTo', 'errors')}">
                                    <g:select name="assignedTo.id" from="${ics.Individual.list()}" optionKey="id" value="${mbProfileInstance?.assignedTo?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="profileStatus"><g:message code="mbProfile.profileStatus" default="Profile Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'profileStatus', 'errors')}">
                                    <g:textField name="profileStatus" value="${fieldValue(bean: mbProfileInstance, field: 'profileStatus')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="matchMakingStatus"><g:message code="mbProfile.matchMakingStatus" default="Match Making Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'matchMakingStatus', 'errors')}">
                                    <g:textField name="matchMakingStatus" value="${fieldValue(bean: mbProfileInstance, field: 'matchMakingStatus')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="workflowStatus"><g:message code="mbProfile.workflowStatus" default="Workflow Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'workflowStatus', 'errors')}">
                                    <g:textField name="workflowStatus" value="${fieldValue(bean: mbProfileInstance, field: 'workflowStatus')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="mbProfile.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: mbProfileInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="photo"><g:message code="mbProfile.photo" default="Photo" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'photo', 'errors')}">
                                    <input type="file" id="photo" name="photo" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="photoType"><g:message code="mbProfile.photoType" default="Photo Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'photoType', 'errors')}">
                                    <g:textField name="photoType" value="${fieldValue(bean: mbProfileInstance, field: 'photoType')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
