
<%@ page import="ics.Period" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="period.edit" default="Edit Period" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="period.list" default="Period List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="period.new" default="New Period" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="period.edit" default="Edit Period" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${periodInstance}">
            <div class="errors">
                <g:renderErrors bean="${periodInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${periodInstance?.id}" />
                <g:hiddenField name="version" value="${periodInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="period.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: periodInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: periodInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="period.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: periodInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: periodInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="period.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: periodInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: periodInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fromDate"><g:message code="period.fromDate" default="From Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: periodInstance, field: 'fromDate', 'errors')}">
                                    <g:datePicker name="fromDate" value="${periodInstance?.fromDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="toDate"><g:message code="period.toDate" default="To Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: periodInstance, field: 'toDate', 'errors')}">
                                    <g:datePicker name="toDate" value="${periodInstance?.toDate}" noSelection="['': '']" />

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
