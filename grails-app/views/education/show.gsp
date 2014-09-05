
<%@ page import="ics.Education" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="education.show" default="Show Education" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="education.list" default="Education List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="education.new" default="New Education" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="education.show" default="Show Education" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${educationInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="education.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: educationInstance, field: "id")}</td>
                                
                            </tr>
                            <tr class="prop">
			                                <td valign="top" class="name"><g:message code="education.name.label" default="Name" /></td>
			                                
			                                <td valign="top" class="value">${fieldValue(bean: educationInstance, field: "name")}</td>
			                                
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
