
<%@ page import="ics.OtherContact" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'otherContact.label', default: 'OtherContact')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${otherContactInstance}">
            <div class="errors">
                <g:renderErrors bean="${otherContactInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual"><g:message code="otherContact.individual.label" default="Individual" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: otherContactInstance, field: 'individual', 'errors')}">
                                    <g:select name="individual.id" from="${ics.Individual.list()}" optionKey="id" value="${otherContactInstance?.individual?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="otherContact.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: otherContactInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${otherContactInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactType"><g:message code="otherContact.contactType.label" default="Contact Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: otherContactInstance, field: 'contactType', 'errors')}">
                                    <g:textField name="contactType" value="${otherContactInstance?.contactType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactValue"><g:message code="otherContact.contactValue.label" default="Contact Value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: otherContactInstance, field: 'contactValue', 'errors')}">
                                    <g:textField name="contactValue" value="${otherContactInstance?.contactValue}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
