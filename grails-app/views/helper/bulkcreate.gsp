
<%@ page import="ics.ReceiptBook" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBook.label', default: 'ReceiptBook')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" controller="receiptBook" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${receiptBookInstance}">
            <div class="errors">
                <g:renderErrors bean="${receiptBookInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="receiptBook" action="bulksave" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="receiptBook.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${receiptBookInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bookSeries"><g:message code="receiptBook.bookSeries.label" default="Book Series" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'bookSeries', 'errors')}">
                                    <g:textField name="bookSeries" value="${receiptBookInstance?.bookSeries}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bookSerialNumber"><g:message code="receiptBook.bookSerialNumber.label" default="Book Serial Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'bookSerialNumber', 'errors')}">
                                    <g:textField name="bookSerialNumber" value="${fieldValue(bean: receiptBookInstance, field: 'bookSerialNumber')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startingReceiptNumber"><g:message code="receiptBook.startingReceiptNumber.label" default="Starting Receipt Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'startingReceiptNumber', 'errors')}">
                                    <g:textField name="startingReceiptNumber" value="${fieldValue(bean: receiptBookInstance, field: 'startingReceiptNumber')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numPages"><g:message code="receiptBook.numPages.label" default="Num Pages" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'numPages', 'errors')}">
                                    <g:textField name="numPages" value="${fieldValue(bean: receiptBookInstance, field: 'numPages')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bookSerialNumber">Last Book Serial Number</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'bookSerialNumber', 'errors')}">
                                    <g:textField name="bookLastSerialNumber" value="${fieldValue(bean: receiptBookInstance, field: 'bookSerialNumber')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="receiptBook.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'status', 'errors')}">
                                    <!--<g:textField name="status" value="${receiptBookInstance?.status}" />-->
                                    <g:select name="status" from="${['Blank','Hold']}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="receiptBook.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${receiptBookInstance?.comments}"  rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Bulk Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
