
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title>Create Donation</title>

	<gui:resources components="['autoComplete']" />
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>

	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">

    </head>

    <body onLoad="return tabOrders();">

    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
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
	    <span class="menuButton"><g:link class="create" action="bulkdonation0">Bulk Donation</g:link></span>
            <g:if test="${donationInstance?.id}">
		<span class="menuButton"><g:link class="create" controller="giftIssued" action="createfordonation" params="['donation.id': donationInstance?.id]">IssueGift</g:link></span>
	    </g:if>
	</div>
        <div class="body">
            <h1>Create Donation</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}  <g:link class="create" action="matchdummydonor" id="${donationInstance?.id}">Match donor</g:link></div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>


            <g:form action="savedummydonation" method="post" onsubmit="return validate();">
		<g:hiddenField name="dummy" value="Dummy" />


		<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE">
			<div class="dialog">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody bgcolor="lavender">
					<tr class="prop">
					<td valign="top" class="name">
						<g:if test="${donationInstance?.donatedBy?.id>0 }">
							Donation by: ${donationInstance?.donatedBy}
							<g:hiddenField name="donorid" value="${donationInstance?.donatedBy?.id}" />
						</g:if>
						<g:else>
							<g:checkBox name="actualChkBox" onClick="checkActual()"/> Actual Donor?
						</g:else>
					</td>
					</tr>
					</tbody>
				</table>
			</div>
		</sec:ifAnyGranted>                     
	
                <div class="dialog" id="donorTable" style="display: none">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label>Donated By</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}">
				   <div style="width: 300px">
					<gui:autoComplete
						id="acIndividual"
						width="200px"
						controller="individual"
						action="allIndividualsAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'

					/>
				   </div>
                                    
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label>Address</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'collectedBy', 'errors')}">
                                 <g:hiddenField name="address.id" value="" />
				   <div style="width: 400px">
					<gui:autoComplete
						id="acAddress"
						width="300px"
						controller="address"
						action="findDepAddressAsJSON"
						dependsOn="[
						label:'individualid',
						value:'acIndividual',
						useId:true
						]"
						useShadow="true"
					/>
				   </div>
                                    
                                </td>
                            </tr>
			</tbody>
			</table>
		</div>

                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="scheme">Donation Type</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
                               <!--
                               <g:hiddenField name="scheme.id" value="" />
				   <div style="width: 200px">
					<gui:autoComplete
						id="acScheme"
						width="200px"
						controller="scheme"
						action="findSchemesAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'
					/>
				   </div>
								-->
				<g:select name="scheme.id" from="${ics.Scheme.list(sort:'name')}" optionKey="id" value="${donationInstance?.scheme?.id}" noSelection="['':'-Select-']" />

                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr >
                                <td valign="top" width="18%">
                                    <label for="collectedBy"><g:message code="donation.collectedBy.label" default="Collected By" /></label>*
                                </td>
                                <td valign="top" width="82%" align="left" class="value ${hasErrors(bean: donationInstance, field: 'collectedBy', 'errors')}">
                                    
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
                            
                            <g:if test="${donationInstance?.collectedBy}">
                            <tr>
                                <td valign="top" width="18%">
	                               <g:hiddenField name="h_collectedBy.id" value="${donationInstance?.collectedBy?.id}" />
	                               <g:checkBox name="CollectorChkBox" value="${true}" /> Use This Name?
                                </td>
                                <td valign="top" width="82%" align="left">
                                    ${donationInstance?.collectedBy}
                                </td>
                            </tr>
                            </g:if>

			<!-- no need to ask this
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="nvccCollectorName">Collector Name</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccCollectorName', 'errors')}">
                                    <g:textField name="nvccCollectorName" value="${donationInstance?.nvccCollectorName}" />
                                </td>
                            </tr>
                          -->
			</tbody>
			</table>
		</div>

                <div id='receiptNoDiv' class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="nvccReceiptBookNo">Book No</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptBookNo', 'errors')}">
                                    <g:textField name="nvccReceiptBookNo" value="${donationInstance?.nvccReceiptBookNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="nvccReceiptNo">Receipt No</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptNo', 'errors')}">
                                    <g:textField name="nvccReceiptNo" value="${donationInstance?.nvccReceiptNo}" />
                                </td>
                            </tr>
				</tbody>
			</table>
		</div>
                
                        <!--
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donationReceipt"><g:message code="donation.donationReceipt.label" default="Donation Receipt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationReceipt', 'errors')}">
                               <g:hiddenField name="donationReceipt.id" value="" />
				   <div style="width: 200px">
					<gui:autoComplete
						id="acDonationReceipt"
						width="200px"
						controller="receipt"
						action="findReceiptsAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'
					/>
				   </div>
                   
                                </td>
                            </tr>
                          -->

				<div class="dialog">
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody bgcolor="lavender">
							<tr class="prop">
								<td valign="top" width="18%">
									Payment Type*
								</td>
								<td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'city', 'errors')}">
									<g:select name="mode.id" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" value="${ ics.PaymentMode.findByName('Cash')?.id}"   noSelection="['':'-Select-']" onchange="newFilterPaymentMode();"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<!--<div class="dialog">
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody bgcolor="lavender">
						<tr class="prop">
						<td valign="top" class="name">
							Payment Channel
						</td>
						<td valign="top" class="value">
							<g:select name="channel" from="${['Direct', 'Bank', 'Web','Complementary','Kind']}"  onchange="filterPaymentMode();"/>
						</td>
						</tr>
					</tbody>
					</table>
				</div>


                       <div id="paymentMode" class="dialog" style="display:block">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody bgcolor="lavender">
					<tr class="prop">
					<td valign="top" class="name">
						Payment Mode
					</td>
					<td valign="top" class="value">
						<g:select name="type" from="${['Cash', 'Cheque', 'DemandDraft','CreditCard','DebitCard']}"  onchange="showPaymentModeDetails();"/>
					</td>
					</tr>
				</tbody>
			</table>
                        </div>-->

                       <div id="cardType" class="dialog" style="display:block">
			<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr class="prop">
				<td valign="top" width="18%">
					Card Type
				</td>
				<td valign="top" class="value">
					<g:select name="ctype" from="${['AMERICAN EXPRESS', 'MAESTRO', 'MASTER','VISA']}" value="${donationInstance?.bankBranch}" noSelection="['':'-Select-']" onchange="setCardType();" />
				</td>
				</tr>
				<tr class="prop">
					<td valign="top" width="18%">
						<label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>*
					</td>
					<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankName', 'errors')}">
						<g:textField name="c_bankName" value="${donationInstance?.bankName}" />
					</td>
				</tr>					
			</tbody>
			</table>
                        </div>

                        <div id="chequedetails" class="dialog" style="display: none">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody bgcolor="lavender">
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    Cheque No*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
		                                    <g:textField name="chequeNo" value="${donationInstance?.chequeNo}" />
		                                </td>
		                            </tr>
		                        
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    Cheque Date*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
		                                    <!--<g:datePicker name="chequeDate" precision="day" value="${donationInstance?.chequeDate}"  noSelection="['':'-Select-']" default="none"/>-->
		                                    <g:textField name="chequeDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
		                                </td>
		                            </tr>
		                        
		                        
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    <label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankName', 'errors')}">
		                                    <g:textField name="bankName" value="${donationInstance?.bankName}"/>
		                                </td>
		                            </tr>
		
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    <label for="bankBranch"><g:message code="donation.bankBranch.label" default="Bank Branch" /></label>*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}">
		                                    <g:textField name="bankBranch" value="${donationInstance?.bankBranch}"/>
		                                </td>
		                            </tr>
					</tbody>
				</table>
			</div>

                        <div id="demanddraftdetails" class="dialog" style="display: none">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody bgcolor="lavender">
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    DD No*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
		                                    <g:textField name="demandDraftNo" value="${donationInstance?.chequeNo}" />
		                                </td>
		                            </tr>
		                        
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    DD Date*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
		                                    <!--<g:datePicker name="chequeDate" precision="day" value="${donationInstance?.chequeDate}"  noSelection="['':'-Select-']" default="none"/>-->
		                                    <g:textField name="demandDraftDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
		                                </td>
		                            </tr>
		                        
		                        
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    <label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankName', 'errors')}">
		                                    <g:textField name="demandDraftBankName" value="${donationInstance?.bankName}"/>
		                                </td>
		                            </tr>
		
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    <label for="bankBranch"><g:message code="donation.bankBranch.label" default="Bank Branch" /></label>*
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
		                                <td valign="top" width="18%">
		                                    Accounts Receipt No*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
		                                    <g:textField name="accountsReceiptNo" value="${donationInstance?.chequeNo}" />
		                                </td>
		                            </tr>
		                        
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    Transaction Date*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
		                                    <!--<g:datePicker name="chequeDate" precision="day" value="${donationInstance?.chequeDate}"  noSelection="['':'-Select-']" default="none"/>-->
		                                    <g:textField name="transferDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
		                                </td>
		                            </tr>
		                        
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    <label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>*
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankName', 'errors')}">
		                                    <g:select name="netbankingBankName" from="${['SBI','ICICI']}" value="${donationInstance?.bankName}"  noSelection="['':'-Select-']"/>
		                                </td>
		                            </tr>

					</tbody>
				</table>
			    </div>

		      <div id="chequedepositdate" class="dialog" style="display: block">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody bgcolor="lavender">
				    <tr class="prop">
					<td valign="top" width="18%">
					    Cheque Deposit Date
					</td>
					<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDepositDate', 'errors')}">
					    <g:textField name="chequeDepositDate" value="${donationInstance?.chequeDepositDate?.format('dd-MM-yyyy')}"/>
					</td>
				    </tr>
				</tbody>
			</table>
		      </div>

                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="amount"><g:message code="donation.amount.label" default="Amount" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: donationInstance, field: 'amount')}"/>
                                </td>
                            </tr>
                        
                            
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="currency"><g:message code="donation.currency.label" default="Currency" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'currency', 'errors')}">
					<g:select name="currency" from="${['INR','USD','GBP','EUR']}" value="INR"/>


                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="paymentComments"><g:message code="donation.paymentComments.label" default="Payment Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'paymentComments', 'errors')}">
                                    <g:textField name="paymentComments" value="${donationInstance?.paymentComments}" size="90"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="donationDate">Receipt Date</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationDate', 'errors')}">
                                    <!--<g:datePicker name="donationDate" precision="day" value="${donationInstance?.donationDate}"  />-->
                                    <g:textField name="donationDate" value="${donationInstance?.donationDate?.format('dd-MM-yyyy')}"/>
                                </td>
                            </tr>
                        
                        


			<!--
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label>Collected By</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'collectedBy', 'errors')}">
                               <g:hiddenField name="collectedBy.id" value="" />
			       <div style="width: 200px">
				<gui:autoComplete
				    id="acCollector"
				    width="200px"
				    controller="individual"
				    action="findDepCollectorsAsJSON"
					dependsOn="[
					    label:'receiptid',
					    value:'acDonationReceipt',
					    useId:true
					]"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
			    />
			    </div>
                                    
                                </td>
                            </tr>
                            -->
                        
                        
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="fundReceiptDate">Submission Date</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'fundReceiptDate', 'errors')}">
                                    <!--<g:datePicker name="fundReceiptDate" precision="day" value="${donationInstance?.fundReceiptDate}"  />-->
                                    <g:if test="${donationInstance?.fundReceiptDate}">
	                                	<g:textField name="fundReceiptDate" value="${donationInstance?.fundReceiptDate.format('dd-MM-yyyy')}" />
					</g:if>
					<g:else>
						<g:textField name="fundReceiptDate" value="${new Date().format('dd-MM-yyyy')}"/>
					</g:else>
                                </td>
                            </tr>

                        
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="comments">Remarks</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${donationInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="receivedBy"><g:message code="donation.receivedBy.label" default="Received By" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'receivedBy', 'errors')}">
					
					<g:select name="receiverid" from="${recepients}" optionKey="id" value="${donationInstance?.receivedBy?.id}" noSelection="['':'-Select-']"/>
	                   
                                </td>
                            </tr>


                            <g:hiddenField name="bankDetailsFlag" value="false" />

                        
                        </tbody>
                    </table>
                </div>
                
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="nameInPadaSevaBook">Name on Wall / Padasevanam Book</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nameInPadaSevaBook', 'errors')}">
                                    <g:textField name="nameInPadaSevaBook" value="${donationInstance?.nameInPadaSevaBook}" size="90"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    Category
                                </td>
                                <td valign="top" class="value">
                                	<g:select name="category" optionKey="name" from="${ics.DonationCategory.list(sort:'name')}" value="${donationInstance?.category?:'Indian Donation'}" noSelection="['':'-Select Donation Category-']" />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="donorName">Donor Name</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donorName', 'errors')}">
                                    <g:textField name="donorName" value="${donationInstance?.donorName}" size="50"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    Address
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="donorAddress" value="${donationInstance?.donorAddress}" size="90"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    Contact Number
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="donorContact" value="${donationInstance?.donorContact}" size="25"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    Email Id
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="donorEmail" value="${donationInstance?.donorEmail}" size="25"/>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    IT PAN
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="donorPAN" value="${donationInstance?.donorPAN}" size="25"/>
                                </td>
                            </tr>                            
                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
            <script language="javascript"> 

		function amountBlur()
		{
			if(document.getElementById("amount").value >= 50000)
				document.getElementById("nameInPadaSevaBook").disabled=false;
			else
				document.getElementById("nameInPadaSevaBook").disabled=true;
		}
			
            function setCardType() {
            	document.getElementById('bankBranch').value = document.getElementById('ctype').value;
            }
            

	    function newFilterPaymentMode() {
	    	var m = document.getElementById('mode.id');
	    	var pm = m.options[m.selectedIndex];
	    	if (pm.text.search(/Complementary/)>-1)
	    	{
	    		var ele = document.getElementById("cardType");
	    		ele.style.display = "none";
	    		var ele = document.getElementById("receiptNoDiv");
	    		ele.style.display = "block";
	    		//ele.style.display = "none";
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
	    		document.getElementById("ctype").focus();
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
	    		flag.value = "true";
		}
		else if (pm.text.search(/Cash/)>-1)
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

				document.getElementById("chequeNo").focus();
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
	    		var ele = document.getElementById("netbankingdetails");
	    		ele.style.display = "none";
	    		var ele = document.getElementById("demanddraftdetails");
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
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "true";					

			try { 
			typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

			} catch(ex) { 
			typeSelect.options.add(opt) // IE only 
			} 

			var opt = document.createElement('option');
			opt.text = 'DebitCard' 
			opt.value = 'DebitCard' 
		    	var flag = document.getElementById('bankDetailsFlag');
	    		flag.value = "true";
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
				var flag = document.getElementById('bankDetailsFlag');
				flag.value = "true";
				try { 
				typeSelect.options.add(opt, null) // standards compliant; doesn't work in IE 

				} catch(ex) { 
				typeSelect.options.add(opt) // IE only 
				} 

				var opt = document.createElement('option');
				opt.text = 'DebitCard' 
				opt.value = 'DebitCard' 
				var flag = document.getElementById('bankDetailsFlag');
				flag.value = "true";
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

			if(document.getElementById('scheme.id').value == "")
			{
				alert("Please provide Donation Type!!");
				document.getElementById('scheme.id').focus();
				return false;
			
			}
			
			if(document.getElementById('CollectorChkBox'))
			{
				if(document.getElementById('CollectorChkBox').value=='off')
				{
					if (document.getElementById('acCollector').value=="")
					{
						alert("Please provide Collector Name!!");
						document.getElementById('acCollector').focus();
						return false;
					}
				}
			}

			if (document.getElementById("nvccReceiptBookNo").value=="")
			{
				alert("Please provide Receipt Book No!!");
				document.getElementById('nvccReceiptBookNo').focus();
				return false;
			}
			if (document.getElementById("nvccReceiptNo").value=="")
			{
				alert("Please provide Receipt No!!");
				document.getElementById('nvccReceiptNo').focus();
				return false;
			}
			if (document.getElementById('amount').value=="")
			{
				alert("Please provide Amount!!");
				document.getElementById('amount').focus();
				return false;
			}
			if (document.getElementById("amount").value<=0)
			{
				alert("Please provide valid Amount!!");
				document.getElementById('amount').focus();
				return false;
			}


			var m = document.getElementById('mode.id');
			
			var pm = m.options[m.selectedIndex];
			
			if (pm.text.search(/Cheque/)>-1)
			{
				//if (document.getElementById("bank.id").value=='')
				if (document.getElementById("bankName").value=='')
				{
					alert("Please Enter BANK for Cheque payment!!");
					//document.forms[0].'bank.id'.focus();
					document.getElementById('bankName').focus();
					return false;
				}
				if (document.getElementById("bankBranch").value=='')
				{
					alert("Please select BANK BRANCH for Cheque payment!!");
					//document.forms[0].'bank.id'.focus();
					document.getElementById('bankBranch').focus();
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

				if(chqDepDate<chqDate)
				{
					alert("Cheque deposit date has to be greater than or equal to cheque date!!");
					document.getElementById('chequeDepositDate').focus();
					return false;
				}
			}
			return confirm("Are you sure?");
		}
	    
	    </script>


        </div>
    </body>
</html>
