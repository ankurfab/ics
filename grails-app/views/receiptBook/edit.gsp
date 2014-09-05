
<%@ page import="ics.ReceiptBook" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBook.label', default: 'ReceiptBook')}" />
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
            <g:hasErrors bean="${receiptBookInstance}">
            <div class="errors">
                <g:renderErrors bean="${receiptBookInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${receiptBookInstance?.id}" />
                <g:hiddenField name="version" value="${receiptBookInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="receiptBook.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'category', 'errors')}">
                                    <!--<g:textField name="category" value="${receiptBookInstance?.category}" />-->
                                    ${receiptBookInstance?.category}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bookSeries"><g:message code="receiptBook.bookSeries.label" default="Book Series" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'bookSeries', 'errors')}">
                                    <!--<g:textField name="bookSeries" value="${receiptBookInstance?.bookSeries}" />-->
                                    ${receiptBookInstance?.bookSeries}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bookSerialNumber"><g:message code="receiptBook.bookSerialNumber.label" default="Book Serial Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'bookSerialNumber', 'errors')}">
                                    <!--<g:textField name="bookSerialNumber" value="${fieldValue(bean: receiptBookInstance, field: 'bookSerialNumber')}" />-->
                                    ${fieldValue(bean: receiptBookInstance, field: 'bookSerialNumber')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="receiptBook.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'status', 'errors')}">
                                    <!--<g:textField name="status" value="${receiptBookInstance?.status}" />-->
                                    <!--<g:select name="status" from="${['Blank','Hold']}" value="${receiptBookInstance?.status}"/>-->
                                    ${receiptBookInstance?.status}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="receiptBook.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${receiptBookInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="startingReceiptNumber"><g:message code="receiptBook.startingReceiptNumber.label" default="Starting Receipt Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'startingReceiptNumber', 'errors')}">
                                    <!--<g:textField name="startingReceiptNumber" value="${fieldValue(bean: receiptBookInstance, field: 'startingReceiptNumber')}" />-->
                                    ${fieldValue(bean: receiptBookInstance, field: 'startingReceiptNumber')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numPages"><g:message code="receiptBook.numPages.label" default="Num Pages" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'numPages', 'errors')}">
                                    <!--<g:textField name="numPages" value="${fieldValue(bean: receiptBookInstance, field: 'numPages')}" />-->
                                    ${fieldValue(bean: receiptBookInstance, field: 'numPages')}
                                </td>
                            </tr>
                        
                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="isBlank"><g:message code="receiptBook.isBlank.label" default="Is Blank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'isBlank', 'errors')}">
                                    <g:checkBox name="isBlank" value="${receiptBookInstance?.isBlank}" />
                                </td>
                            </tr>-->
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="receipts"><g:message code="receiptBook.receipts.label" default="Receipts" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookInstance, field: 'receipts', 'errors')}">
                                    
									<ul>
									<g:each in="${receiptBookInstance?.receipts?}" var="r">
										<!--<li><g:link controller="receipt" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>-->
										<li>${r}</li>
									</g:each>
									</ul>
									<!--<g:link controller="receipt" action="create" params="['receiptBook.id': receiptBookInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'receipt.label', default: 'Receipt')])}</g:link>-->

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test = "${receiptBookInstance?.status == 'Blank' || receiptBookInstance?.status == 'Hold'}">
                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:if>
                </div>
            </g:form>
        </div>
    </body>
</html>
