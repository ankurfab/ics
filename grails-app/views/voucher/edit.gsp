
<%@ page import="ics.Voucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="voucher.edit" default="Edit Voucher" /></title>
	<r:require module="jqui" />
    </head>
    <body>
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#voucherDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
	}
	);
    </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="voucher.list" default="Voucher List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="voucher.new" default="New Voucher" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="voucher.edit" default="Edit Voucher" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${voucherInstance}">
            <div class="errors">
                <g:renderErrors bean="${voucherInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${voucherInstance?.id}" />
                <g:hiddenField name="version" value="${voucherInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="voucherDate"><g:message code="voucher.voucherDate" default="Voucher Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'voucherDate', 'errors')}">
                                    <g:textField name="voucherDate" value="${voucherInstance?.voucherDate?.format('dd-MM-yyyy')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="departmentCode"><g:message code="voucher.departmentCode" default="Department Code" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'departmentCode', 'errors')}">
                                    <g:select name="departmentCode.id" from="${ics.CostCenter.findAllByStatusIsNull(sort:'name')}" optionKey="id" value="${voucherInstance?.departmentCode?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="voucherNo"><g:message code="voucher.voucherNo" default="Voucher No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'voucherNo', 'errors')}">
                                    <g:textField name="voucherNo" value="${fieldValue(bean: voucherInstance, field: 'voucherNo')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="voucher.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: voucherInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount">Withdrawal Amount &#8377;:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: voucherInstance, field: 'amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amountSettled">Deposit Amount &#8377;:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'amountSettled', 'errors')}">
                                    <g:textField name="amountSettled" value="${fieldValue(bean: voucherInstance, field: 'amountSettled')}" />

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
