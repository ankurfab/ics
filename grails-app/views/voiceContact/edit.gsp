
<%@ page import="ics.VoiceContact" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'voiceContact.label', default: 'VoiceContact')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <!--<span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>-->
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${voiceContactInstance}">
            <div class="errors">
                <g:renderErrors bean="${voiceContactInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${voiceContactInstance?.id}" />
                <g:hiddenField name="version" value="${voiceContactInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="individual"><g:message code="voiceContact.individual.label" default="Individual" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voiceContactInstance, field: 'individual', 'errors')}">
                                    <g:hiddenField name="individual.id" value="${voiceContactInstance?.individual?.id}" />
                                    ${voiceContactInstance?.individual}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="voiceContact.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voiceContactInstance, field: 'category', 'errors')}">
					<g:select name="category" from="${['CellPhone','HomePhone','CompanyPhone','Other']}" value="${voiceContactInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="number"><g:message code="voiceContact.number.label" default="Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voiceContactInstance, field: 'number', 'errors')}">
                                    <g:textField name="number" value="${voiceContactInstance?.number}" size="50"/>
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
