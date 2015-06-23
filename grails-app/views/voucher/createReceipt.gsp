
<%@ page import="ics.Voucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Receipt Voucher Entry</title>
	<r:require module="jqui" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <span class="menuButton"><g:link class="list" action="list"><g:message code="voucher.list" default="Voucher List" /></g:link></span>
        </div>
        <div class="body">
            <h1>Receipt Voucher Entry</h1>
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
                                    <label for="type"><g:message code="voucher.type" default="Receipt" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'type', 'errors')}">
                                    	<g:textField name="type" value="${voucherInstance?.type?:'Receipt'}"  readonly="readonly"/>
                                </td>
                            </tr>

			    <tr class="prop">
				<td valign="top" class="name">
				    <label for="refNo">From:</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'refNo', 'errors')}">
				    <g:textField name="refNo" value="${fieldValue(bean: voucherInstance, field: 'refNo')}" />

				</td>
			    </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: voucherInstance, field: 'description')}" />

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
                                    <label for="ledger">Received In A/C:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'ledger', 'errors')}">
					<g:select id="ledger" name='ledger' value=""
					    noSelection="${['':'Select To Department...']}"
					    from='${ics.CostCenter.findAllByStatusIsNull([sort:'name'])}' optionKey="id"></g:select>	

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
                                    <label for="mode">Mode:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'mode', 'errors')}">
					<g:select name="mode.id" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" noSelection="['':'-Select Payment Mode-']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="instrumentNo"><g:message code="voucher.instrumentNo" default="InstrumentNo" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'instrumentNo', 'errors')}">
                                    <g:textField name="instrumentNo" value="${fieldValue(bean: voucherInstance, field: 'instrumentNo')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="instrumentDate">Instrument Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'instrumentDate', 'errors')}">
                                    <g:textField name="instrumentDate" value="${fieldValue(bean: voucherInstance, field: 'instrumentDate')}" />

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bankName">Bank Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'bankName', 'errors')}">
                                    <g:textField name="bankName" value="${fieldValue(bean: voucherInstance, field: 'bankName')}" />

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bankBranch">Bank Branch:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: voucherInstance, field: 'bankBranch', 'errors')}">
                                    <g:textField name="bankBranch" value="${fieldValue(bean: voucherInstance, field: 'bankBranch')}" />

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
          $("#voucherDate").datepicker({yearRange: "-1:+1",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});

          $("#instrumentDate").datepicker({yearRange: "-1:+1",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});

	}
	);
    </script>

    </body>
</html>
