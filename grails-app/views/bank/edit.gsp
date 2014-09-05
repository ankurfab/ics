
<%@ page import="ics.Bank" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${bankInstance}">
            <div class="errors">
                <g:renderErrors bean="${bankInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${bankInstance?.id}" />
                <g:hiddenField name="version" value="${bankInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="bank.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bankInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${bankInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="donations"><g:message code="bank.donations.label" default="Donations" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bankInstance, field: 'donations', 'errors')}">
                                    
<ul>
<g:each in="${bankInstance?.donations?}" var="d">
    <li><g:link controller="donation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="donation" action="create" params="['bank.id': bankInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'donation.label', default: 'Donation')])}</g:link>

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
