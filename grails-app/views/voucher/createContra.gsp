
<%@ page import="ics.Voucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Contra Voucher Entry</title>
	<r:require module="jqui" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <span class="menuButton"><g:link class="list" action="list"><g:message code="voucher.list" default="Voucher List" /></g:link></span>
        </div>
        <div class="body">
            <h1>Contra Voucher Entry</h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${voucherInstance}">
            <div class="errors">
                <g:renderErrors bean="${voucherInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="voucher.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'type', 'errors')}">
                                    	<g:textField name="type" value="${voucherInstance?.type?:'Contra'}"  readonly="readonly"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="voucherDate"><g:message code="voucher.voucherDate" default="Voucher Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'voucherDate', 'errors')}">
                                    	<g:textField name="voucherDate" value="${voucherInstance?.voucherDate?:new Date().format('dd-MM-yyyy')}"  />
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
                                    <label for="bankCode">Bank Code:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'ledger', 'errors')}">
                                    <g:textField name="ledger" value="${fieldValue(bean: voucherInstance, field: 'ledger')}" />

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
                                    <label for="amount">Amount &#8377;:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: voucherInstance, field: 'amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="debit"><g:message code="voucher.debit" default="Debit or Credit?" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'debit', 'errors')}">
					Debit<g:radio name="debit" value="true" checked="${voucherInstance?.debit?'checked':''}"/>
					Credit<g:radio name="debit" value="false" checked="${voucherInstance?.debit?'':'checked'}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refNo"><g:message code="voucher.refNo" default="Reference" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'refNo', 'errors')}">
                                    <g:textField name="refNo" value="${fieldValue(bean: voucherInstance, field: 'refNo')}" />

                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Enter" onclick="return confirm('Are you sure?');"/></span>
                </div>
            </g:form>
        </div>

    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#voucherDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
	}
	);
    </script>

    </body>
</html>
