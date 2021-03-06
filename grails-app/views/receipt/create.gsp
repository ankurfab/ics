
<%@ page import="ics.Receipt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receipt.label', default: 'Receipt')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${receiptInstance}">
            <div class="errors">
                <g:renderErrors bean="${receiptInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBook"><g:message code="receipt.receiptBook.label" default="Receipt Book" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptInstance, field: 'receiptBook', 'errors')}">
                                    <g:select name="receiptBook.id" from="${ics.ReceiptBook.list()}" optionKey="id" value="${receiptInstance?.receiptBook?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptNumber"><g:message code="receipt.receiptNumber.label" default="Receipt Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptInstance, field: 'receiptNumber', 'errors')}">
                                    <g:textField name="receiptNumber" value="${receiptInstance?.receiptNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isBlank"><g:message code="receipt.isBlank.label" default="Is Blank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptInstance, field: 'isBlank', 'errors')}">
                                    <g:checkBox name="isBlank" value="${receiptInstance?.isBlank}" />
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
