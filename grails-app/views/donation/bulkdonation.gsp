
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title>Create Bulk Donation</title>

	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;}
	</style>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">

    </head>

    <body >
    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#chequeDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#chequeDepositDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
		for(i=0; i<25; i++)
		{
          $("#donationDate"+i).datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#fundReceiptDate"+i).datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
		}

          rbSelected();
        })
    </script>


        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
	<span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>
            <g:if test="${donationInstance?.id}">
		<span class="menuButton"><g:link class="create" controller="giftIssued" action="createfordonation" params="['donation.id': donationInstance?.id]">IssueGift</g:link></span>
		</g:if>
	</div>
        <div class="body">
            <h1>Create Bulk Donations for Receipt Book</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>


            <g:form action="savebulkdonation" method="post">


                <div class="dialog">
                    <table border="0">
                        <tbody>
							<tr class="prop">
							<td valign="top" class="name">
								Receipt Book: 
								<g:hiddenField name="donorid" value="${donationInstance?.donatedBy?.id}" />
							</td>
							<td valign="top" class="name" colspan="5">

								<g:select name="receiptBook.id" from="${receiptBookList}" optionKey="id"  value="${receiptBookInstance?.receiptBook}"  noSelection="['':'-Select-']" 
								onChange="${remoteFunction(
								controller:'donation',
								action:'getReceiptBook',
								onSuccess:'processResponse(e)', 
								params:'\'id=\' + escape(this.value)'
								)}"

								/>
							<g:textField name="h_numPages" value="" />	
							</td>
							</tr>
							<tr>

							<td>
							<label for="collectedBy"><g:message code="donation.collectedBy.label" default="Collected By" /></label>*
							</td>
							<td colspan="5">
							   <g:hiddenField name="collectedBy.id" value="" />
							   <div style="width: 300px">
								<gui:autoComplete
									id="acCollector"
									width="300px"
									controller="individual"
									action="findCollectorsAsJSON"
									useShadow="true"
									queryDelay="0.5" minQueryLength='3'
								/>
							</div>

							</td>
							</tr>

							<g:each in="${0..<5}">

								<tr class="prop">

									<td>
										<label for="nvccReceiptBookNo">Receipt No</label> <g:textField name="nvccReceiptNo${it}" value="${donationInstance?.nvccReceiptNo}" />
									</td>
									<td>
										<label for="PaymentMode">Payment Channel</label> <g:select name="mode.id${it}" from="${ics.PaymentMode.list(sort:'name')}" optionKey="id" value="${donationInstance?.mode?.id}" noSelection="['':'-Select-']"/>
									</td>
									<td>
										<label for="amount"><g:message code="donation.amount.label" default="Amount" /></label> <g:textField name="amount${it}" value="${fieldValue(bean: donationInstance, field: 'amount')}" />                       
									</td>
									<td>
										<label for="currency"><g:message code="donation.currency.label" default="Currency" /></label> <g:select name="currency${it}" from="${['INR','USD','GBP','EUR']}" value="INR"/>
									</td>
									<td>
										<label for="donationDate">Receipt Date</label> <g:textField name="donationDate${it}" value="${donationInstance?.donationDate?.format('dd-MM-yyyy')}"/>
									</td>
									<td>
										<label for="fundReceiptDate">Submission Date</label> <g:textField name="fundReceiptDate${it}" value="${donationInstance?.fundReceiptDate?.format('dd-MM-yyyy')}"/>
									</td>
								</tr>
							</g:each>
                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
            <script language="text/javascript"> 
            	function processResponse(resp)
            	{
            		alert(resp.responseText);
            	}

      	    </script>

        </div>
    </body>
</html>
