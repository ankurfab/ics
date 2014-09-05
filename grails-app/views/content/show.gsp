
<%@ page import="ics.Content" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="content.show" default="Show Content" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="content.list" default="Content List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="content.new" default="New Content" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="content.show" default="Show Content" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${contentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.htmlContent" default="Html Content" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "htmlContent")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.language" default="Language" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "language")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${contentInstance?.department?.id}">${contentInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.course" default="Course" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="course" action="show" id="${contentInstance?.course?.id}">${contentInstance?.course?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.assessment" default="Assessment" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="assessment" action="show" id="${contentInstance?.assessment?.id}">${contentInstance?.assessment?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${contentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${contentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="content.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "updator")}</td>
                                
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
