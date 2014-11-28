
<%@ page import="ics.Village" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="village.edit" default="Edit Village" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="village.list" default="Village List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="village.new" default="New Village" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="village.edit" default="Edit Village" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${villageInstance}">
            <div class="errors">
                <g:renderErrors bean="${villageInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${villageInstance?.id}" />
                <g:hiddenField name="version" value="${villageInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="village.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: villageInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: villageInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="taluka"><g:message code="village.taluka" default="Taluka" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: villageInstance, field: 'taluka', 'errors')}">
                                    <g:select name="taluka.id" from="${ics.Taluka.list()}" optionKey="id" value="${villageInstance?.taluka?.id}"  />

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
