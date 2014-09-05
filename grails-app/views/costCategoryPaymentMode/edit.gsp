
<%@ page import="ics.CostCategoryPaymentMode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCategoryPaymentMode.edit" default="Edit CostCategoryPaymentMode" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCategoryPaymentMode.list" default="CostCategoryPaymentMode List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCategoryPaymentMode.new" default="New CostCategoryPaymentMode" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCategoryPaymentMode.edit" default="Edit CostCategoryPaymentMode" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${costCategoryPaymentModeInstance}">
            <div class="errors">
                <g:renderErrors bean="${costCategoryPaymentModeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${costCategoryPaymentModeInstance?.id}" />
                <g:hiddenField name="version" value="${costCategoryPaymentModeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCategory"><g:message code="costCategoryPaymentMode.costCategory" default="Cost Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'costCategory', 'errors')}">
                                    <g:select name="costCategory.id" from="${ics.CostCategory.list()}" optionKey="id" value="${costCategoryPaymentModeInstance?.costCategory?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentMode"><g:message code="costCategoryPaymentMode.paymentMode" default="Payment Mode" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'paymentMode', 'errors')}">
                                    <g:select name="paymentMode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${costCategoryPaymentModeInstance?.paymentMode?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bankCode"><g:message code="costCategoryPaymentMode.bankCode" default="Bank Code" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'bankCode', 'errors')}">
                                    <g:textField name="bankCode" value="${fieldValue(bean: costCategoryPaymentModeInstance, field: 'bankCode')}" />

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
