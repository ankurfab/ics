
<%@ page import="ics.EmailContact" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'emailContact.label', default: 'EmailContact')}" />
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
            <g:hasErrors bean="${emailContactInstance}">
            <div class="errors">
                <g:renderErrors bean="${emailContactInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual"><g:message code="emailContact.individual.label" default="Individual" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: emailContactInstance, field: 'individual', 'errors')}">
                                    <g:hiddenField name="individual.id" value="${emailContactInstance?.individual?.id}" />
                                    ${emailContactInstance?.individual}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="emailContact.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: emailContactInstance, field: 'category', 'errors')}">
                                    <!--<g:textField name="category" value="${emailContactInstance?.category}" />-->
					<g:select name="category" from="${['Personal','Official','Other']}" value="${emailContactInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="emailAddress"><g:message code="emailContact.emailAddress.label" default="Email Address" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: emailContactInstance, field: 'emailAddress', 'errors')}">
                                    <g:textField name="emailAddress" value="${emailContactInstance?.emailAddress}" size="100"/>
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
