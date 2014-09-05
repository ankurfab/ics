
<%@ page import="ics.MbProfile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="mbProfile.show" default="Show MbProfile" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="mbProfile.list" default="MbProfile List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="mbProfile.new" default="New MbProfile" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="mbProfile.show" default="Show MbProfile" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${mbProfileInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: mbProfileInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.candidate" default="Candidate" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${mbProfileInstance?.candidate?.id}">${mbProfileInstance?.candidate?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.referredBy" default="Referred By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${mbProfileInstance?.referredBy?.id}">${mbProfileInstance?.referredBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.assignedTo" default="Assigned To" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${mbProfileInstance?.assignedTo?.id}">${mbProfileInstance?.assignedTo?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.profileStatus" default="Profile Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: mbProfileInstance, field: "profileStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.matchMakingStatus" default="Match Making Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: mbProfileInstance, field: "matchMakingStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.workflowStatus" default="Workflow Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: mbProfileInstance, field: "workflowStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: mbProfileInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.photo" default="Photo" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: mbProfileInstance, field: "photo")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="mbProfile.photoType" default="Photo Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: mbProfileInstance, field: "photoType")}</td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
