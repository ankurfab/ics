
<%@ page import="ics.LeaveRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="leaveRecord.show" default="Show LeaveRecord" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="leaveRecord.list" default="LeaveRecord List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="leaveRecord.new" default="New LeaveRecord" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="leaveRecord.show" default="Show LeaveRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${leaveRecordInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: leaveRecordInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.dateFrom" default="Date From" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${leaveRecordInstance?.dateFrom}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.dateTill" default="Date Till" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${leaveRecordInstance?.dateTill}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: leaveRecordInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: leaveRecordInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${leaveRecordInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: leaveRecordInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${leaveRecordInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: leaveRecordInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="leaveRecord.indDep" default="Ind Dep" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individualDepartment" action="show" id="${leaveRecordInstance?.indDep?.id}">${leaveRecordInstance?.indDep?.encodeAsHTML()}</g:link></td>
                                
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
