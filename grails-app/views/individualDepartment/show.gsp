
<%@ page import="ics.IndividualDepartment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualDepartment.show" default="Show IndividualDepartment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="individualDepartment.list" default="IndividualDepartment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="individualDepartment.new" default="New IndividualDepartment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualDepartment.show" default="Show IndividualDepartment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${individualDepartmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualDepartmentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.individual" default="Individual" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${individualDepartmentInstance?.individual?.id}">${individualDepartmentInstance?.individual?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${individualDepartmentInstance?.department?.id}">${individualDepartmentInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualDepartmentInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.salary" default="Salary" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualDepartmentInstance, field: "salary")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualDepartmentInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.since" default="Since" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${individualDepartmentInstance?.since}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.till" default="Till" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${individualDepartmentInstance?.till}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualDepartmentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${individualDepartmentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${individualDepartmentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.leaveRecords" default="Leave Records" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${individualDepartmentInstance?.leaveRecords}" var="leaveRecordInstance">
                                        <li><g:link controller="leaveRecord" action="show" id="${leaveRecordInstance.id}">${leaveRecordInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.salaryRecords" default="Salary Records" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${individualDepartmentInstance?.salaryRecords}" var="salaryRecordInstance">
                                        <li><g:link controller="salaryRecord" action="show" id="${salaryRecordInstance.id}">${salaryRecordInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualDepartment.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualDepartmentInstance, field: "updator")}</td>
                                
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
