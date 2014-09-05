

<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/blue', file: 'style.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css/ui-lightness', file: 'jquery-ui-1.8.17.custom.css')}" type="text/css">

	<gui:resources components="['autoComplete']" />
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">

    </head>
    <body onload="bankBranch();return tabOrders();">
		<g:javascript src="jquery-ui-1.8.17.custom.min.js" />    
    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
		<!--<script>
			$(function() {
				$( "#tabs" ).tabs();
			});		
		</script>-->
   
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#chequeDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#chequeDepositDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#demandDraftDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#transferDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});			
          $("#donationDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#fundReceiptDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          newFilterPaymentMode();
    var tabindex = 1;
    $('input,select,textarea').each(function() {
        if (this.type != "hidden") {
            var $input = $(this);
            $input.attr("tabindex", tabindex);
            tabindex++;
        }
    });          
        })
    </script>


    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>
            
			<g:if test="${donationInstance.receiptImage}">
			  <img src="${createLink(controller:'donation', action:'receiptImage_image', id:donationInstance?.id)}" />
			</g:if>                        

            <g:form method="post">
                <g:hiddenField name="id" value="${donationInstance?.id}" />
                <g:hiddenField name="version" value="${donationInstance?.version}" />
			<g:if test="${donationInstance?.status == 'BOUNCED' }">
				<div class="errors">
					<b>CHEQUE DISHONOURED!!</b>
				</div>
			</g:if>
                <div class="dialog">
                    <table cellspacing="0" cellpadding="0" border="0" width="60%">
                        <tbody bgcolor="lavender">

                            <!--<g:if test="${donationInstance?.status == 'BOUNCED' }">
                            <tr>
                                <td valign="top" class="name">
                                  Reset Dishonoured Cheque Flag?
                                </td>
                                <td valign="top">
                                    <g:checkBox name="resetStatus" />
                                </td>
                            </tr>
				</g:if>-->
                        
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="donatedBy"><b><g:message code="donation.donatedBy.label" default="Donated By" /></b></label>
                                </td>
                                
                                <td valign="top" align="left" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}" width="10%">
                                    ${donationInstance?.donatedBy}
                                </td>
                                <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
                                	<g:if test="${(donationInstance?.donatedBy) && (donationInstance?.donatedBy != 'Dummy Donor for daily transactions')}">
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}">
						       <g:hiddenField name="h_donatedBy.id" value="${donationInstance?.donatedBy?.id}" />
						       <g:checkBox name="DonorChkBox" value="${true}"/> <b>Use This Name?</b>
						</td>   
						</tr>
						<tr>
						<td width="10%">&nbsp;
						</td>						
						<td valign="top" align="left" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}" width="10%">
				
						    <div style="width: 200px">
							<gui:autoComplete
							id="acDonatedBy"
							width="200px"
							controller="individual"
							action="allIndividualsExceptDummyDonorAsJSON"
							useShadow="true"
							queryDelay="0.5" minQueryLength='3'
							/>
						    </div>
						</td>
						<td>&nbsp;
						</td>							
						</tr>

                                	</g:if>
                                	<g:else>
						<td>&nbsp;
						</td>							
						</tr>
                                	
                                	</g:else>
                                </sec:ifAnyGranted>
                                <sec:ifNotGranted roles="ROLE_NVCC_ADMIN">
					<td>&nbsp;
					</td>							
					</tr>
                                
                                </sec:ifNotGranted>
                              
                                <!--<sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
                                	<g:if test="${(donationInstance?.donatedBy) && (donationInstance?.donatedBy != 'Dummy Donor for daily transactions')}">
                                	<tr>
					<td valign="top" align="left" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}" width="20%">
					    <g:hiddenField name="donatedBy.id" value="" />
					    <g:checkBox name="DonorChkBox" value="${true}"/> <b>Use This Name?</b>
					    <div style="width: 300px">
						<gui:autoComplete
						id="acDonatedBy"
						width="300px"
						controller="individual"
						action="allIndividualsExceptDummyDonorAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'
						/>
					    </div>
					</td>
					</tr>
                                	</g:if>
                                </sec:ifAnyGranted>-->
                            
                        
                        
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="collectedBy"><b><g:message code="donation.collectedBy.label" default="Collected By" /></b></label>
                                </td>
                                <g:if test="${donationInstance?.collectedBy}">
                                
                                <td valign="top" class="name" align="left" width="10%">
                                    ${donationInstance?.collectedBy}
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'collectedBy', 'errors')}">
	                               <g:hiddenField name="h_collectedBy.id" value="${donationInstance?.collectedBy?.id}" />
	                               <g:checkBox name="CollectorChkBox" value="${true}"/> <b>Use This Name?</b>
                                </td>
                                </g:if>  
                                
                                </tr>
                                <tr>
                                <td width="10%">&nbsp;
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'collectedBy', 'errors')}" width="10%">
                                   
				   <g:hiddenField name="collectedBy.id" value="" />
				   <div style="width: 200px">
						<gui:autoComplete
							id="acCollector"
							width="200px"
							controller="individual"
							action="findCollectorsAsJSON"
							useShadow="true"
							queryDelay="0.5" minQueryLength='3'
						/>
					</div>
                                    
                                </td>
				<td>&nbsp;
				</td>                            	
                            
                            
                            

                            </tr>
                           
                            <tr>
                                <td valign="top" class="name" width="10%" align="right">
                                  <b>Donation Type</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}" width="10%">
                                    <g:select name="scheme.id" from="${ics.Scheme.list()}" optionKey="id" value="${donationInstance?.scheme?.id}"  />
                                </td>
				<td>&nbsp;
				</td>

                            </tr>
                            
                            
                            
			</tbody>
                    </table>
                    <!--
                    <a href="javascript:toggleBulkDonationFields()"><font color="navy" face="verdana" size="1">BulkDonationFields</font></a>
                    -->
                </div>
		<div id="tabs">
			<!--<ul>
				<li><a href="#BulkDonationFields">DonorInformation</a></li>
			</ul>-->
			<div id="BulkDonationFields">
				<table cellspacing="0" cellpadding="0" border="0">
					<tbody bgcolor="lavender">

						<tr>
							<td valign="top" class="name" width="10%"><b><g:message code="donation.donorName.label" default="Donor Name" /></b></td>

							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: "donorName")}" width="12%"><g:textField name="donorName" value="${donationInstance?.donorName}" size="50"/></td>

							<td valign="top" class="name" width="10%"><b><g:message code="donation.donorAddress.label" default="Donor Address" /></b></td>

							<td valign="top" class="value" ${hasErrors(bean: donationInstance, field: "donorAddress")} colspan="3"><g:textField name="donorAddress" value="${donationInstance?.donorAddress}"  size="50"/></td>

							<td>&nbsp;</td>
							<td>&nbsp;</td>                            
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td valign="top" class="name" width="10%"><b><g:message code="donation.donorContact.label" default="Donor Contact" /></b></td>

							<td valign="top" class="value" ${hasErrors(bean: donationInstance, field: "donorContact")} width="12%"><g:textField name="donorContact" value="${donationInstance?.donorContact}" /></td>

							<td valign="top" class="name" width="10%"><b><g:message code="donation.donorEmail.label" default="Donor Email" /></b></td>

							<td valign="top" class="value" ${hasErrors(bean: donationInstance, field: "donorEmail")} width="12%"><g:textField name="donorEmail" value="${donationInstance?.donorEmail}" /></td>

							<td valign="top" class="name" width="10%"><b><g:message code="donation.donorPAN.label" default="Donor PAN" /></b></td>

							<td valign="top" class="value" ${hasErrors(bean: donationInstance, field: "donorPAN")} width="12%"><g:textField name="donorPAN" value="${donationInstance?.donorPAN}" /></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

                
                <div id='receiptNoDiv' class="dialog">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tbody bgcolor="lavender">
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="nvccReceiptBookNo"><b><g:message code="donation.nvccReceiptBookNo.label" default="Book No" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptBookNo', 'errors')}" width="10%">
                                <g:if test="${fieldValue(bean: donationInstance, field: 'nvccReceiptBookNo')}">
                                    <g:textField name="nvccReceiptBookNo" value="${donationInstance?.nvccReceiptBookNo}" />
								</g:if>
								<g:else>
									<g:textField name="nvccReceiptBookNo" value="${ics.Receipt.findById(donationInstance?.donationReceiptId)?.receiptBook}" />
                                </g:else>   
                                </td>

                                <td valign="top" class="name" width="8%">
                                  <label for="nvccReceiptNo"><b><g:message code="donation.nvccReceiptNo.label" default="Receipt No" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptNo', 'errors')}" width="10%">
                                <g:if test="${fieldValue(bean: donationInstance, field: 'nvccReceiptNo')}">
                                    <g:textField name="nvccReceiptNo" value="${donationInstance?.nvccReceiptNo}" />
								</g:if>
								<g:else>
									<g:textField name="nvccReceiptNo" value="${ics.Receipt.findById(donationInstance?.donationReceiptId)?.receiptNumber}" />
                                </g:else>
                                </td>
                                <td width="10%">&nbsp;
                                </td>
                                <td width="10%">&nbsp;
                                </td>                                
				<td>&nbsp;</td>
				<td>&nbsp;</td>
                            </tr>
						<!--</tbody>
                    </table>
                </div>
                        
                <div class="dialog">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tbody bgcolor="lavender">-->
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="mode"><b><g:message code="donation.mode.label" default="Mode" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'mode', 'errors')}" width="10%">
                                    <g:select name="mode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${donationInstance?.mode?.id}"  onchange="newFilterPaymentMode();"/>
                                </td>

                                <td>&nbsp;
                                </td>
                                <td>&nbsp;
                                </td>                                
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td> 
				<td>&nbsp;</td>
				<td>&nbsp;</td>							
                            </tr>
			</tbody>
                    </table>
                </div>

	   <div id="cardType" class="dialog" style="display:block">
			<table cellspacing="0" cellpadding="0" border="0">
				<tbody bgcolor="lavender">
					<tr>
						<td valign="top" class="name" width="10%">
							<b>Card Type</b>
						</td>
						<td valign="top" class="value" width="15%">
							<g:select name="ctype" from="${['AMERICAN EXPRESS', 'MAESTRO', 'MASTER','VISA']}" value="${donationInstance?.bankBranch}" noSelection="['':'-Select-']" onchange="setCardType();"/>
						</td>
						<td valign="top" class="name" width="5%">
							<b>Bank</b>
						</td>
						<td valign="top" class="value">
						<g:if test="${donationInstance?.bankName}">
							<g:textField name="bankName" value="${donationInstance?.bankName}"/>
						</g:if>
						<g:else>
							<g:textField name="bankName" value="${donationInstance?.bank}"/>
						</g:else>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

                <div id="chequedetails" class="dialog" style="display:none">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tbody bgcolor="lavender">
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <b>Cheque No</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}" width="8%">
                                    <g:textField name="chequeNo" value="${donationInstance?.chequeNo}" />
                                </td>
                            <!--</tr>
                        
                            <tr>-->
                                <td valign="top" class="name" width="10%">
                                  <b>Cheque Date</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}" width="8%">
                                    <!--<g:datePicker name="chequeDate" precision="day" value="${donationInstance?.chequeDate}" noSelection="['': '']" />-->
                                    <g:textField name="chequeDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
                                </td>
                                <td>&nbsp;
                                </td>
                                <td>&nbsp;
                                </td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>							
                            </tr>
                        
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="bank"><b><g:message code="donation.bank.label" default="Bank" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bank', 'errors')}" width="8%">
                                    
                           			<g:if test="${donationInstance?.bank}">
                                    	<g:textField name="bankName" value="${donationInstance?.bank}" />
									</g:if>
									<g:else>
                                    	<g:textField name="bankName" value="${donationInstance?.bankName}" />
                           	 		</g:else>                                    	
                                </td>
                            <!--</tr>
                        
                            <tr>-->
                            <!--<div id="divBankBranch" class="dialog" >-->
                                <td valign="top" class="name" width="12%">
                                  <label for="bankBranch"><b><g:message code="donation.bankBranch.label" default="Bank Branch" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}" width="8%">
                                    <g:textField name="bankBranch" value="${donationInstance?.bankBranch}" />
                                </td>
                                <td>&nbsp;
                                </td>
                                <td>&nbsp;
                                </td>                                
								<!--</div>-->
								<td>&nbsp;</td>
								<td>&nbsp;</td>
                                
                            </tr>
						</tbody>
                    </table>
                </div>
                        
		<div id="chequedepositdate" class="dialog" style="display: none">
			<table cellspacing="0" cellpadding="0" border="0">
				<tbody bgcolor="lavender">
						<tr>
							<td valign="top" class="name" width="10%">
								<b>Cheque Deposit Date</b>
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDepositDate', 'errors')}" width="10%">
								<g:textField name="chequeDepositDate" value="${donationInstance?.chequeDepositDate?.format('dd-MM-yyyy')}"/>
							</td>
							<td>&nbsp;
							</td>
							<td>&nbsp;
							</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
				</tbody>
			</table>
		</div>
		<div id="demanddraftdetails" class="dialog" style="display: none">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody bgcolor="lavender">
					<tr class="prop">
						<td valign="top" width="10%">
							<b>DD No*</b>
						</td>
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
							<g:textField name="demandDraftNo" value="${donationInstance?.chequeNo}" />
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" width="10%">
							<b>DD Date*</b>
						</td>
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
							<!--<g:datePicker name="chequeDate" precision="day" value="${donationInstance?.chequeDate}"  noSelection="['':'-Select-']" default="none"/>-->
							<g:textField name="demandDraftDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
						</td>
					</tr>


					<tr class="prop">
						<td valign="top" width="10%">
							<b><label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>*</b>
						</td>
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankName', 'errors')}">
							<!--<g:select name="bank.id" from="${ics.Bank.list(sort:'name')}" optionKey="id" value="${donationInstance?.bank?.id}"  noSelection="['':'-Select-']"/>-->
							<g:textField name="demandDraftBankName" value="${donationInstance?.bankName}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" width="10%">
							<b><label for="bankBranch"><g:message code="donation.bankBranch.label" default="Bank Branch" /></label>*</b>
						</td>
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}">
							<g:textField name="demandDraftBankBranch" value="${donationInstance?.bankBranch}"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div id="netbankingdetails" class="dialog" style="display: none">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody bgcolor="lavender">
					<tr class="prop">
						<td valign="top" width="10%">
							<b>Accounts Receipt No*</b>
						</td>
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
							<g:textField name="accountsReceiptNo" value="${donationInstance?.chequeNo}" />
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" width="10%">
							<b>Transaction Date*</b>
						</td>
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
							<g:textField name="transferDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" width="10%">
							<b><label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>*</b>
						</td>
						<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankName', 'errors')}">
							<g:select name="netbankingBankName" from="${['SBI','ICICI']}" value="${donationInstance?.bankName}"  noSelection="['':'-Select-']"/>
						</td>
					</tr>

				</tbody>
			</table>
		</div>

                <div class="dialog">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tbody bgcolor="lavender">
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="amount"><b><g:message code="donation.amount.label" default="Amount" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'amount', 'errors')}" width="8%">
                                    <g:textField name="amount" value="${fieldValue(bean: donationInstance, field: 'amount')}" />
                                </td>
                            <!--</tr>
                        
                            <tr>-->
                                <td valign="top" class="name" width="5%">
                                  <label for="currency"><b><g:message code="donation.currency.label" default="Currency" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'currency', 'errors')}" width="4%">
                                    <g:select name="currency" from="${['INR','USD','GBP','EUR']}" value="${donationInstance?.currency}"/>
                                </td>
                            <!--</tr>
                        
                            <tr>-->
                                <td valign="top" class="name" width="15%">
                                  <label for="paymentComments"><b><g:message code="donation.paymentComments.label" default="Payment Comments" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'paymentComments', 'errors')}">
                                    <g:textField name="paymentComments" value="${donationInstance?.paymentComments}" />
                                </td>
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>
                                
                            </tr>
			</tbody>
                    </table>
                </div>
                        
                <div class="dialog">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tbody bgcolor="lavender">
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <b>Receipt Date</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationDate', 'errors')}">
                                    <!--<g:datePicker name="donationDate" precision="day" value="${donationInstance?.donationDate}"  />-->
                                    <g:textField name="donationDate" value="${donationInstance?.donationDate?.format('dd-MM-yyyy')}"/>
                                </td>
                            <!--</tr>
                        
                            <tr>-->
                                <td valign="top" class="name">
                                  <b>Submission Date</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'fundReceiptDate', 'errors')}">
                                    <!--<g:datePicker name="fundReceiptDate" precision="day" value="${donationInstance?.fundReceiptDate}"  />-->
                                    <!--<g:textField name="fundReceiptDate" value="${donationInstance?.fundReceiptDate?.format('dd-MM-yyyy')}"/>-->
                                    <!--<g:formatDate format="dd-MM-yyyy" date="${donationInstance?.fundReceiptDate}"/>-->
                                    <g:textField name="fundReceiptDate" value="${donationInstance?.fundReceiptDate?.format('dd-MM-yyyy')}"/>
                                </td>
                               
                            <!--</tr>
                        
                            <tr>-->
                                <td valign="top" class="name" rowspan="3">
                                  <b>Remarks</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}" rowspan="4">
                                    <g:textArea name="comments" value="${donationInstance?.comments}" rows="5" cols="40"/>
                                </td>
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>                                 
                            </tr>
                        
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="receivedBy"><b><g:message code="donation.receivedBy.label" default="Received By" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'receivedBy', 'errors')}">
                                    <g:select name="receivedBy.id" from="${receivers}" optionKey="id" value="${donationInstance?.receivedBy?.id}"  />
                                </td>
                            <!--</tr>
                        
                            <tr>-->
                                <td valign="top" class="name">
                                  <label for="nameInPadaSevaBook"><b><g:message code="donation.nameInPadaSevaBook.label" default="Name In Pada Seva Book" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nameInPadaSevaBook', 'errors')}">
                                    <g:textField name="nameInPadaSevaBook" value="${donationInstance?.nameInPadaSevaBook}"/>
                                </td>
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>                                
                            </tr>
                        
                            <tr>
                                <td valign="top" class="name" width="10%">
                                  <label for="category"><b><g:message code="donation.category.label" default="Category" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'category', 'errors')}">
                                    <g:select name="category"  optionKey="name" from="${ics.DonationCategory.list(sort:'name')}" value="${donationInstance?.category?:'Indian Donation'}"/>
                                </td>
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>       
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>								
                            </tr>
                        
                            
                        
                     
                        <g:hiddenField name="bankDetailsFlag" value="${donationInstance?.bank?.id?true:false}" />
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"   onclick="return validate();"/></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>

    <script language="javascript"> 

		function bankBranch()
		{
			var ele = document.getElementById("cardType");
			if (ele.style.display == "block") 
			{
				
				document.getElementById("BankBranch").value="";
			}			
		}
		
		function toggleBulkDonationFields() {
		var ele = document.getElementById("bulkdonationfields");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
		} 

		function setCardType() {
			document.getElementById('bankBranch').value = document.getElementById('ctype').value;
		}
            

	    function newFilterPaymentMode() {
	    	var m = document.getElementById('mode.id');
	    	var pm = m.options[m.selectedIndex];
	    	/*alert(pm.text);
	    	alert(pm.text.search(/Direct-Cash/)>-1);
	    	alert(pm.text.search(/Direct-Cheque/)>-1);*/
	    	if (pm.text.search(/Complementary/)>-1)
	    	{
	    		var ele = document.getElementById("cardType");
	    		ele.style.display = "none";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "none";
	    	    	var ele = document.getElementById("chequedetails");
	    		ele.style.display = "none";
	    	    	var ele = document.getElementById("chequedepositdate");
	    		ele.style.display = "none";
				var ele = document.getElementById("netbankingdetails");
				ele.style.display = "none";
				var ele = document.getElementById("demanddraftdetails");
				ele.style.display = "none";
	    		
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "false";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "block";
			}
			else if (pm.text.search(/Kind/)>-1)
				{
	    		var ele = document.getElementById("cardType");
	    		ele.style.display = "none";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "block";
	    	    	var ele = document.getElementById("chequedetails");
	    		ele.style.display = "none";
	    	    	var ele = document.getElementById("chequedepositdate");
	    		ele.style.display = "none";
				var ele = document.getElementById("netbankingdetails");
				ele.style.display = "none";
				var ele = document.getElementById("demanddraftdetails");
				ele.style.display = "none";
	    		
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "false";
			}
			else if (pm.text.search(/Card/)>-1)
				{
	    		var ele = document.getElementById("cardType");
	    		ele.style.display = "block";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "block";
	    	    	var ele = document.getElementById("chequedetails");
	    		ele.style.display = "none";
	    	    	var ele = document.getElementById("chequedepositdate");
	    		ele.style.display = "none";
				var ele = document.getElementById("netbankingdetails");
				ele.style.display = "none";
				var ele = document.getElementById("demanddraftdetails");
				ele.style.display = "none";
	    		
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "false";
			}
			else if (pm.text.search(/Cash/)>-1)
	    	{//alert('hi');
	    		var ele = document.getElementById("cardType");
	    		ele.style.display = "none";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "block";
	    	    	var ele = document.getElementById("chequedetails");
	    		ele.style.display = "none";
	    	    	var ele = document.getElementById("chequedepositdate");
	    		ele.style.display = "none";
				var ele = document.getElementById("netbankingdetails");
				ele.style.display = "none";
				var ele = document.getElementById("demanddraftdetails");
				ele.style.display = "none";
	    		
	    		//alert(ele.style.display);
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "false";
			}
			else if (pm.text.search(/NetBanking/)>-1) 
			{
			var ele = document.getElementById("netbankingdetails");
			ele.style.display = "block";

			var ele = document.getElementById("cardType");
			ele.style.display = "none";
			var ele = document.getElementById("receiptNoDiv");
			ele.style.display = "block";
				var ele = document.getElementById("chequedetails");
			ele.style.display = "none";
				var ele = document.getElementById("chequedepositdate");
			ele.style.display = "none";

			var ele = document.getElementById("demanddraftdetails");
			ele.style.display = "none";

			var flag = document.getElementById('bankDetailsFlag');
			flag.value = "true";
			}
			else if (pm.text.search(/DemandDraft/)>-1) 
			{
			var ele = document.getElementById("demanddraftdetails");
			ele.style.display = "block";

			var ele = document.getElementById("cardType");
			ele.style.display = "none";
			var ele = document.getElementById("receiptNoDiv");
			ele.style.display = "block";
				var ele = document.getElementById("chequedetails");
			ele.style.display = "none";
				var ele = document.getElementById("chequedepositdate");
			ele.style.display = "none";
			var ele = document.getElementById("netbankingdetails");
			ele.style.display = "none";

			var flag = document.getElementById('bankDetailsFlag');
			flag.value = "true";
			}

			else
				{
	    		if (pm.text.search(/Cheque/)>-1)
	    			{
				var ele = document.getElementById("chequedepositdate");
				ele.style.display = "block";
				var ele = document.getElementById("chequedetails");
	    		ele.style.display = "block";
				var ele = document.getElementById("netbankingdetails");
				ele.style.display = "none";
				var ele = document.getElementById("demanddraftdetails");
				ele.style.display = "none";
	    		
	    			}
	    		else
	    			{
				var ele = document.getElementById("chequedepositdate");
				ele.style.display = "none";
				var ele = document.getElementById("chequedetails");
	    		ele.style.display = "none";
	    			}
	    		var ele = document.getElementById("cardType");
	    		ele.style.display = "none";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "block";
	    	    	
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "true";
			}
	    }

	    function filterPaymentMode() {
	    	var channelSelect = document.getElementById('channel');
	    	var channel = channelSelect.options[channelSelect.selectedIndex];
	    	var ele = document.getElementById("paymentMode");
	    	if (channel.text.search(/Complementary/)>-1 || channel.text.search(/Kind/)>-1)
	    	{
	    		ele.style.display = "none";
	    		var ele = document.getElementById("cardType");
	    		ele.style.display = "none";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "none";
	    	    	var ele = document.getElementById("chequedetails");
	    		ele.style.display = "none";
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "false";
			}
	    	else
	    		{
		    		//show only the relevant modes
				var typeSelect = document.getElementById('type');
				// Clear all previous payment type
				var l = typeSelect.length

				while (l > 0) { 
					l-- 
					typeSelect.remove(l) }
	    			if (channel.text.search(/Direct/)>-1) 
	    			{ 
					// Rebuild the payment type
					//'Cash', 'Cheque', 'DemandDraft','CreditCard','DebitCard','NetBanking'

					var opt = document.createElement('option');
					opt.text = 'Cash' 
					opt.value = 'Cash' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'Cheque' 
					opt.value = 'Cheque'  

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'DemandDraft' 
					opt.value = 'DemandDraft' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'CreditCard' 
					opt.value = 'CreditCard' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'DebitCard' 
					opt.value = 'DebitCard' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 
				} 
				if (channel.text.search(/Bank/)>-1) 
				{ 
					// Rebuild the payment type
					//'Cash', 'Cheque', 'DemandDraft','CreditCard','DebitCard','NetBanking'

					var opt = document.createElement('option');
					opt.text = 'Cash' 
					opt.value = 'Cash' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'Cheque' 
					opt.value = 'Cheque' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'DemandDraft' 
					opt.value = 'DemandDraft' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'NetBanking' 
					opt.value = 'NetBanking' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 
				} 
				if (channel.text.search(/Web/)>-1) 
				{ 
					// Rebuild the payment type
					//'Cash', 'Cheque', 'DemandDraft','CreditCard','DebitCard','NetBanking'

					var opt = document.createElement('option');
					opt.text = 'CreditCard' 
					opt.value = 'CreditCard' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'DebitCard' 
					opt.value = 'DebitCard' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 

					var opt = document.createElement('option');
					opt.text = 'NetBanking' 
					opt.value = 'NetBanking' 

					try { 
					typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					typeSelect.options.add(opt) // IE only 
					} 
				} 
				ele.style.display = "block";
				showDetails();
				var ele = document.getElementById("receiptNoDiv");
				ele.style.display = "block";
			}
	    } 

	    function checkActual() {
	    	var cb = document.getElementById('actualChkBox');
	    	var ele = document.getElementById("donorTable");
			var flag = document.getElementById('dummy');
	    	if (cb.checked)
	    	{
	    		ele.style.display = "block";
	    		flag.value = "Actual";
	    	}
	    	else
	    		{
	    		ele.style.display = "none";
	    		flag.value = "Dummy";
	    		}
	    } 

	    function showDetails() {
	    	var typeSelect = document.getElementById('type');
	    	var type = typeSelect.options[typeSelect.selectedIndex];
			var ele = document.getElementById("cardType");
			if (type.text.search(/Card/)>-1) 
				{
					ele.style.display = "block";
				}
			else
				ele.style.display = "none";
			showChequeDetails()


	    } 

	    function showPaymentModeDetails() {
		    showDetails();
	    } 
	    
	    function showChequeDetails() {
	    	//var zselect = document.getElementById('mode.id');
	    	var zselect = document.getElementById('type');
	    	var flag = document.getElementById('bankDetailsFlag');
	    	var zopt = zselect.options[zselect.selectedIndex];
	    	var ele = document.getElementById("chequedetails");
	    	//if (zopt.value==2 || zopt.value==3)
	    	if (zopt.text.search(/Cheque/)>-1 || zopt.text.search(/DemandDraft/)>-1)
	    	{
	    		ele.style.display = "block";
	    		flag.value = "true";
	    	}
	    	else
	    		{
	    		ele.style.display = "none";
	    		flag.value = "false";
	    		}
	    } 
	    
	    function clearvar() {
			var flag = document.getElementById('bankDetailsFlag');
			if(flag.value.search(/false/)>-1)
	    	{
	    		document.getElementById('bank.id').value="";
	    		document.getElementById('chequeDate_day').value="";
	    		document.getElementById('chequeDate_month').value="";
	    		document.getElementById('chequeDate_year').value="";
	    	}
	    }
	    
		function validate() {   
	    	var m = document.getElementById('mode.id');
	    	var pm = m.options[m.selectedIndex];
	    	if (pm.text.search(/Direct-Cheque/)>-1)
	    		{
				if (document.getElementById("bank.id").value=='')
					{
					alert("Please select BANK for Direct-Cheque payment!!");
					//document.forms[0].'bank.id'.focus();
					document.getElementById('bank.id').focus();
					return false;
					}
				}
		if (document.getElementById("chequeDepositDate").value!='')
			{
			//first cheque whether chequedate is set or not
			if (document.getElementById("chequeDate").value=='')
				{
				alert("Cheque date not set but Cheque Deposit Date is set!!");
				document.getElementById('chequeDate').focus();
				return false;
				}
			
			var strDate = document.getElementById("chequeDepositDate").value;
			var dateParts = strDate.split("-");
			
			var chqDepDate = new Date(dateParts[2], (dateParts[1] - 1) ,dateParts[0]);
			
			strDate = document.getElementById("chequeDate").value;
			dateParts = strDate.split("-");
			
			var chqDate = new Date(dateParts[2], (dateParts[1] - 1) ,dateParts[0]);
			
			if(chqDepDate<=chqDate)
				{
				alert("Cheque deposit date has to be greater than cheque date!!");
				document.getElementById('chequeDepositDate').focus();
				return false;
				}
			}
			return true;
		}
	    
	    </script>


    </body>
</html>