
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/blue', file: 'style.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
        
    </head>
    <body>
		<g:javascript src="jquery-ui-1.8.18.custom.min.js" />    
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});		
		</script>
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
		<span class="menuButton"><g:link class="create" action="dummydonation">DummyDonation</g:link></span>
		<span class="menuButton"><g:link class="create" action="bulkdonation0">Bulk Donation</g:link></span>
	    </sec:ifNotGranted>
            <span class="menuButton"><g:link class="create" controller="giftIssued" action="createfordonation" params="['donation.id': donationInstance?.id]">IssueGift</g:link></span>
            <g:if test="${(donationInstance?.donatedBy).toString() != 'Dummy Donor for daily transactions'}">
            	<span class="menuButton"><g:link class="create" controller="eventParticipant" action="invite" params="['donationIds': [donationInstance?.id]]">Invite for Event</g:link></span>
            </g:if>
            <sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
            	<span class="menuButton"><g:link class="list" controller="helper" action="mapdummydonar"  params="[fuzzy: 'true']">MapDummyDonar</g:link></span>
            </sec:ifNotGranted>	
            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
		<g:if test="${donationInstance?.taxBenefit}">
			<g:if test="${!donationInstance?.receiptPrintedOn}">
				<span class="menuButton"><g:link class="list" controller="donation" action="printEntry"  id="${donationInstance?.id}">PrintTaxReceipt</g:link></span>
			</g:if>
			<g:else>
				<span class="menuButton"><g:link class="list" controller="donation" action="printEntry"  id="${donationInstance?.id}">RePrintTaxReceipt</g:link></span>
			</g:else>
		</g:if>
		<g:else>
			<g:if test="${!donationInstance?.receiptPrintedOn}">
				<span class="menuButton"><g:link class="list" controller="donation" action="printEntry"  id="${donationInstance?.id}" params="[taxBenefit:'true']">PrintTaxReceipt</g:link></span>
			</g:if>
			<g:else>
				<span class="menuButton"><g:link class="list" controller="donation" action="printEntry"  id="${donationInstance?.id}" params="[taxBenefit:'true']">RePrintTaxReceipt</g:link></span>
			</g:else>
			<g:if test="${!donationInstance?.receiptPrintedOn}">
				<span class="menuButton"><g:link class="list" controller="donation" action="printEntry"  id="${donationInstance?.id}">PrintReceipt</g:link></span>
			</g:if>
			<g:else>
				<span class="menuButton"><g:link class="list" controller="donation" action="printEntry"  id="${donationInstance?.id}">RePrintReceipt</g:link></span>
			</g:else>
		</g:else>
            </sec:ifAnyGranted>	
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
		<g:if test="${donationInstance?.status == 'BOUNCED' }">
		    <div class="errors">
		    	<b>CHEQUE DISHONOURED!!</b>
		    </div>
		</g:if>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${donationInstance?.id}" />
                    <g:if test="${(donationInstance?.donatedBy).toString() == 'Dummy Donor for daily transactions'}">
                    	<span class="button"><g:actionSubmit class="edit" action="linkdonor" value="LinkDonor" /></span>
                    	<span class="button"><g:actionSubmit class="edit" action="matchdummydonor" value="MatchDummyDonor" /></span>
                    </g:if>
                    <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">	
                    	<span class="button"><g:actionSubmit class="edit" action="matchdummydonor" value="MatchDonor" /></span>
			<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
			<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('There could be gifts issued! Are you sure?');" /></span>
		    </sec:ifAnyGranted>
                    
                    <g:if test="${donationInstance?.bankName && donationInstance?.chequeNo && donationInstance?.status != 'BOUNCED'}">
	                    <span class="button"><g:actionSubmit class="delete" action="bounced" value="Dishonoured Cheque" onclick="return confirm('Are you sure?')" /></span>
		    </g:if>
                </g:form>
            </div>
            
            <div class="dialog">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">
                    
                        <tr>
                            <td valign="top" class="name"><b><g:message code="donation.id.label" default="Id" /></b></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${donationInstance?.id}" format="#" /></td>

                            <td valign="top" class="name"><b><g:message code="donation.donatedBy.label" default="Donated By" /></b></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${donationInstance?.donatedBy?.id}">${donationInstance?.donatedBy?.encodeAsHTML()}</g:link></td>
                            
                            <td valign="top" class="name"><b>Donation Type</b></td>
                            
                            <td valign="top" class="value"><g:link controller="scheme" action="show" id="${donationInstance?.scheme?.id}">${donationInstance?.scheme?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr>
                            <td valign="top" class="name"><b><g:message code="donation.collectedBy.label" default="Collected By" /></b></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${donationInstance?.collectedBy?.id}">${donationInstance?.collectedBy?.encodeAsHTML()}</g:link></td>
                          
                            <td valign="top" class="name"><b><g:message code="donation.mode.label" default="Mode" /></b></td>
                            
                            <td valign="top" class="value"><g:link controller="paymentMode" action="show" id="${donationInstance?.mode?.id}">${donationInstance?.mode?.encodeAsHTML()}</g:link></td>

                            <td valign="top" class="name"><b>IT PAN</b></td>
                            <g:if test="${donationInstance?.donorPAN}">
                            	<td valign="top" class="value">${donationInstance?.donorPAN}</td>
                            </g:if>
                            <g:else>
                            	<td valign="top" class="value">${donationInstance?.donatedBy?.panNo}</td>
                            </g:else>
 
                            
                        </tr>
                     
			<g:if test="${(donationInstance?.mode).toString() != 'Cash'}">
				<tr>
					<td valign="top" class="name"><b>Cheque No</b></td>

					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "chequeNo")}</td>

					<td valign="top" class="name"><b>Cheque Date</b></td>

					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDate}" /></td>

					<td valign="top" class="name"><b>Cheque Deposit Date</b></td>

					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDepositDate}" /></td>
				</tr>

				<tr>
					<td valign="top" class="name"><b><g:message code="donation.bank.label" default="Bank" /></b></td>

					<g:if test="${donationInstance?.bank}">
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bank")}</td>
					</g:if>
					<g:else>
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankName")}</td>
					</g:else>

					<td valign="top" class="name"><b>Bank Branch</b></td>

					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankBranch")}</td>

					<td>&nbsp;</td>
					<td>&nbsp;</td>

				</tr>
			</g:if>

			<g:if test="${(donationInstance?.mode).toString() == 'DemandDraft'}">
				<tr>
					<td valign="top" class="name"><b>DD No</b></td>

					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "chequeNo")}</td>

					<td valign="top" class="name"><b>DD Date</b></td>

					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDate}" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td valign="top" class="name"><b><g:message code="donation.bank.label" default="Bank" /></b></td>

					<g:if test="${donationInstance?.bank}">
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bank")}</td>
					</g:if>
					<g:else>
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankName")}</td>
					</g:else>

					<td valign="top" class="name"><b>Bank Branch</b></td>

					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankBranch")}</td>

					<td>&nbsp;</td>
					<td>&nbsp;</td>

				</tr>
			</g:if>

			<g:if test="${(donationInstance?.mode).toString() == 'NetBanking'}">
				<tr>
					<td valign="top" class="name"><b>Acct Recpt No</b></td>

					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "chequeNo")}</td>

					<td valign="top" class="name"><b>Transaction Date</b></td>

					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDate}" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td valign="top" class="name"><b><g:message code="donation.bank.label" default="Bank" /></b></td>

					<g:if test="${donationInstance?.bank}">
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bank")}</td>
					</g:if>
					<g:else>
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankName")}</td>
					</g:else>

					<td valign="top" class="name"><b>Bank Branch</b></td>

					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankBranch")}</td>

					<td>&nbsp;</td>
					<td>&nbsp;</td>

				</tr>
			</g:if>

			<g:if test="${(donationInstance?.mode).toString() == 'CreditCard' || (donationInstance?.mode).toString() == 'DebitCard' }">						
				<tr>
					<td valign="top" class="name"><b><g:message code="donation.bank.label" default="Bank" /></b></td>

					<g:if test="${donationInstance?.bank}">
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bank")}</td>
					</g:if>
					<g:else>
					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankName")}</td>
					</g:else>

					<td valign="top" class="name"><b>Card Type</b></td>

					<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "bankBranch")}</td>

					<td>&nbsp;</td>
					<td>&nbsp;</td>

				</tr>

			</g:if>

			<tr>
                            <td valign="top" class="name"><b><g:message code="donation.amount.label" default="Amount" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "amount")}
				<g:if test="${donationInstance?.taxBenefit}">
				Taxbenefit(80G)
				</g:if>
                            </td>

                            <td valign="top" class="name"><b><g:message code="donation.currency.label" default="Currency" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "currency")}</td>

                            <td valign="top" class="name"><b><g:message code="donation.paymentComments.label" default="Payment Comments" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "paymentComments")}</td>
                            
                        </tr>

                        <tr>
                            <td valign="top" class="name"><b>Receipt Date</b></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.donationDate}" /></td>

                            <td valign="top" class="name"><b>Submission Date</b></td>
                            
                            <td valign="top" class="value"><g:formatDate  format="dd-MM-yyyy" date="${donationInstance?.fundReceiptDate}" /></td>
                            
                            <td valign="top" class="name"><b>Remarks</b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr>
                            <td valign="top" class="name"><b><g:message code="donation.receivedBy.label" default="Received By" /></b></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${donationInstance?.receivedBy?.id}">${donationInstance?.receivedBy?.encodeAsHTML()}</g:link></td>

                            <td valign="top" class="name"><b><g:message code="donation.nameInPadaSevaBook.label" default="Name In Pada Seva Book" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nameInPadaSevaBook")}</td>
                            
                            <td valign="top" class="name"><b><g:message code="donation.category.label" default="Category" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "category")}</td>
                            
                        </tr>
                    
                    
                        <tr>
                            <td valign="top" class="name"><b><g:message code="donation.giftIssued.label" default="Gift Issued" /></b></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${donationInstance.giftIssued}" var="g">
                                    <li><g:link controller="giftIssued" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            

                            <td valign="top" class="name"><b><g:message code="donation.donationReceipt.label" default="Donation Receipt" /></b></td>
                            
                            <td valign="top" class="value">
				    <g:if  test="${donationInstance?.donationReceipt?.id==1}">
					    ${donationInstance.nvccReceiptBookNo}/${donationInstance.nvccReceiptNo}
				    </g:if>
				    <g:else>
					    <g:link controller="receipt" action="show" id="${donationInstance?.donationReceipt?.id}">${donationInstance?.donationReceipt?.encodeAsHTML()}</g:link>
				    </g:else>
                            </td>                            

                            <td valign="top" class="name"><b><g:message code="donation.fundReceivedAck.label" default="Fund Received Ack" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "fundReceivedAck")}</td>
                            
                        <!--</tr>

						<tr>
                            <td valign="top" class="name"><b>Donor's Mobile</b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "donorContact")}</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							
						</tr>-->
                    </tbody>
                </table>
                <!--
                <a href="javascript:toggleBulkDonationFields()"><font color="navy">BulkDonationFields</font>&nbsp;&nbsp;</a>
                <a href="javascript:toggleRecordInfo()"><font color="navy">RecordInfo</font>&nbsp;&nbsp;</a>
                -->
            </div >
			<div id="tabs">
				<ul>
					<li><a href="#BulkDonationFields">DonorInformation</a></li>
					<li><a href="#NVCCFields">NVCCFields</a></li>
					<li><a href="#RecordInfo">RecordInfo</a></li>
					<li><a href="#PaymentInfo">PaymentInfo</a></li>
				</ul>
				<div id="BulkDonationFields">
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody bgcolor="lavender">

							<tr>
								<td valign="top" class="name" width="8%"><b><g:message code="donation.donorName.label" default="Donor Name" /></b></td>

								<td valign="top" class="value" width="12%">${fieldValue(bean: donationInstance, field: "donorName")}</td>

								<td valign="top" class="name" width="8%"><b><g:message code="donation.donorAddress.label" default="Donor Address" /></b></td>

								<td valign="top" class="value" colspan="3">${fieldValue(bean: donationInstance, field: "donorAddress")}</td>
							</tr>
							<tr>

								<td valign="top" class="name" width="8%"><b><g:message code="donation.donorContact.label" default="Donor Contact" /></b></td>

								<td valign="top" class="value" width="12%">${fieldValue(bean: donationInstance, field: "donorContact")}</td>
								
								<td valign="top" class="name" width="8%"><b><g:message code="donation.donorEmail.label" default="Donor Email" /></b></td>

								<td valign="top" class="value" width="12%">${fieldValue(bean: donationInstance, field: "donorEmail")}</td>
							
								<td valign="top" class="name" width="8%"><b><g:message code="donation.donorPAN.label" default="Donor PAN" /></b></td>

								<td valign="top" class="value" width="12%">${fieldValue(bean: donationInstance, field: "donorPAN")}</td>

							</tr>

						</tbody>
					</table>
				</div>
				<div id="NVCCFields">
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody bgcolor="lavender">

							<tr>
								<td valign="top" class="name"><b><g:message code="donation.nvccDonarCode.label" default="NVCC Donor Code" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccDonarCode")}</td>

								<td valign="top" class="name"><b><g:message code="donation.nvccDonarName.label" default="NVCC Donor Name" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccDonarName")}</td>

								<td valign="top" class="name"><b><g:message code="donation.nvccReceiptBookNo.label" default="NVCC Receipt Book No" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccReceiptBookNo")}</td>

								<td valign="top" class="name"><b><g:message code="donation.nvccReceiptNo.label" default="NVCC Receipt No" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccReceiptNo")}</td>
							</tr>
							<tr>
								<td valign="top" class="name"><b><g:message code="donation.nvccCollectorName.label" default="NVCC Collector Name" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccCollectorName")}</td>

								<td valign="top" class="name"><b><g:message code="donation.nvccReceiverName.label" default="NVCC Receiver Name" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccReceiverName")}</td>

								<td valign="top" class="name"><b><g:message code="donation.nvccDonationType.label" default="NVCC Donation Type" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccDonationType")}</td>

								<td valign="top" class="name"><b><g:message code="donation.nvccDonationMode.label" default="NVCC Donation Mode" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "nvccDonationMode")}</td>
							</tr>
							
						</tbody>
					</table>
				</div>					
				<div id="RecordInfo">
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody bgcolor="lavender">

							<tr>
								<td valign="top" class="name"><b><g:message code="donation.dateCreated.label" default="Date Created" /></b></td>

								<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${donationInstance?.dateCreated}" /></td>

								<td valign="top" class="name"><b><g:message code="donation.creator.label" default="Creator" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "creator")}</td>

								<td valign="top" class="name"><b><g:message code="donation.lastUpdated.label" default="Last Updated" /></b></td>

								<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${donationInstance?.lastUpdated}" /></td>

								<td valign="top" class="name"><b><g:message code="donation.updator.label" default="Updator" /></b></td>

								<td valign="top" class="value">${fieldValue(bean: donationInstance, field: "updator")}</td>

								<td>&nbsp;</td>

								<td>&nbsp;</td>                            
							</tr>
						</tbody>
					</table>
				</div>				

				<div id="PaymentInfo">
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody bgcolor="lavender">

							<tr>
								<td valign="top" class="name"><b>Bank Name</b></td>

								<td valign="top" class="value">${donationInstance?.bankName}</td>

								<td valign="top" class="name"><b>Bank Branch</b></td>

								<td valign="top" class="value">${donationInstance?.bankBranch}</td>

								<td valign="top" class="name"><b>Cheque No</b></td>

								<td valign="top" class="value">${donationInstance?.chequeNo}</td>

								<td valign="top" class="name"><b>Cheque Date</b></td>

								<td valign="top" class="value">${donationInstance?.chequeDate}</td>

								<td>&nbsp;</td>

								<td>&nbsp;</td>                            
							</tr>
						</tbody>
					</table>
				</div>				

			</div>
			</div>
			
            <div id='bulkdonationfields' class="dialog" style="display: none">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">

                        <tr>
                            <td valign="top" class="name" width="12%"><b><g:message code="donation.donorName.label" default="Donor Name" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "donorName")}</td>
                        
                            <td valign="top" class="name" width="12%"><b><g:message code="donation.donorAddress.label" default="Donor Address" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "donorAddress")}</td>
                        
                            <td valign="top" class="name" width="12%"><b><g:message code="donation.donorContact.label" default="Donor Contact" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "donorContact")}</td>
                            
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td valign="top" class="name" width="12%"><b><g:message code="donation.donorPAN.label" default="Donor PAN" /></b></td>
                            
                            <td valign="top" class="value" colspan="6">${fieldValue(bean: donationInstance, field: "donorPAN")}</td>
                            
                        </tr>
                    

                    </tbody>
                </table>
            </div>
            <div id='recordinfo' class="dialog" style="display: none">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">

                        <tr>
                            <td valign="top" class="name"><b><g:message code="donation.dateCreated.label" default="Date Created" /></b></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${donationInstance?.dateCreated}" /></td>
                            
                            <td valign="top" class="name"><b><g:message code="donation.creator.label" default="Creator" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "creator")}</td>

                            <td valign="top" class="name"><b><g:message code="donation.lastUpdated.label" default="Last Updated" /></b></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${donationInstance?.lastUpdated}" /></td>

                            <td valign="top" class="name"><b><g:message code="donation.updator.label" default="Updator" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: donationInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>

        </div>
	<g:if test="${donationInstance.receiptImage}">
	  <img src="${createLink(controller:'donation', action:'receiptImage_image', id:donationInstance?.id)}" />
	</g:if>                        
        <script language="javascript"> 
			function toggleBulkDonationFields() {
			var ele = document.getElementById("bulkdonationfields");
			if (ele.style.display == "block") 
				{
					ele.style.display = "none";
				}
			else
				ele.style.display = "block";
			} 
			function toggleRecordInfo() {
			var ele = document.getElementById("recordinfo");
			if (ele.style.display == "block") 
				{
					ele.style.display = "none";
				}
			else
				ele.style.display = "block";
			} 
			
		</script>
    </body>
</html>
