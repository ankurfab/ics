
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
	  width: 350px !important;
	</style>


	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'tooltip1.css')}" type="text/css">
    </head>

    <body onLoad="return tabOrders();" >

	<g:javascript src="jquery-ui-1.8.18.custom.min.js" /> 
	<g:javascript src="tooltip1.js" />  
	<g:javascript src="jquery.1.3.2.min.js" /> 
	<g:javascript src="jquery.qtip-1.0.0.min.js" /> 
    <script type="text/javascript">
        $(document).ready(function()
        {
		for(var i=0; i<25; i++)
		{
          $("#chequeDate"+i).datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#donationDate"+i).datepicker({yearRange: "-5:+0",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
			
          $("#fundReceiptDate"+i).datepicker({yearRange: "-5:+0",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});

		}
          $("#fundReceiptDate").datepicker({yearRange: "-10:+0",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy', maxDate: new Date()});

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
		<span class="menuButton"><g:link class="create" action="bulkdonation0">Bulk Donation</g:link></span>
		<span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>

		<g:if test="${rbIssued?.issuedTo}">
			<span class="menuButton"><g:link class="create" controller="receiptBookIssued" action="edit" params="[id: rbIssued?.id]">Return ReceiptBook</g:link></span>
		</g:if>
		<g:else>
			<span class="menuButton"><g:link class="create" controller="receiptBookIssued" action="create" >Issue ReceiptBook</g:link></span>
		</g:else>
		</div>
        <div class="body">
            <h1>Bulk Entry of Donations for Receipt Book</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>

		    	 
            <g:form action="savebulkdonation" method="post" onsubmit="return validate();">

				
		<g:hiddenField name="rbid" value="${receiptBook.id}" />

                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
				<tr>
				<td width="6%">
					<b>Receipt Book<b>
				</td>
				<td colspan="6">
					${receiptBook}
				</td>
                                <!--<td valign="top" class="name" width="7%">
                                    <label for="scheme"><b>Submission Date</b></label>
                                </td>
				<td>
					<g:textField name="fundReceiptDate" value="${new Date().format('dd-MM-yyyy')}" size="8" />
				</td>-->
                                
                                <td>&nbsp;
                                </td>
                                <td>&nbsp;
                                </td>
                                <td>&nbsp;
                                </td>
                                <td>&nbsp;
                                </td>
                                
                            </tr>


				</tr>
				
				
				<g:if test="${rbIssued?.issuedTo}">
					<tr>
						<td>
							<b>Issued To</b>
						</td>
						<td>
							<g:link controller="individual" action="show" id="${rbIssued?.issuedTo?.id}">${rbIssued?.issuedTo}</g:link>
						</td>
						<td>
							<b>Status</b>
						</td>
						<td>
							${rbIssued?.status}
						</td>
						<td>
							<b>Cash</b>
						</td>
						<td>
							${rbIssued?.tempCash}
						</td>
						<td>
							<b>Cheque</b>
						</td>
						<td>
							${rbIssued?.tempCheque}
						</td>
					</tr>
				</g:if>
				
				<!--<tr>
				<td width="8%">
					<b>Collected By<b>
				</td>
				<td colspan="12">
				   <g:if test="${isBlank}">
				   	<g:if test="${rbIssued?.issuedTo}">
				   		${rbIssued?.issuedTo}
					   <g:checkBox name="CollectorChkBox" value="${true}" checked="${true}"/> Use This Name
					  </g:if>
				   </g:if>
				   <g:else>
					<g:hiddenField name="collectorid" value="${collector.id}" />
				   	${collector}
				   </g:else>

				</td>
				</tr>
				
				<g:if test="${isBlank}">
				<tr>

				<td width="6%">
				<b>New Collector</b>
				</td>
				<td colspan="12">
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
 
				</g:if>-->
				<!--<tr>
					<td width="5%">
					&nbsp;
					</td>
				
					<td width="5%">
						<g:select name="collectors_legalName" from="${collectors_legalName}" value="${collectors_legalName}" multiple="false" />
					</td>
					<td width="5%">
						<g:select name="collectors_initiatedName" from="${collectors_initiatedName}" value="${collectors_initiatedName}" multiple="false" />
					</td>
					
					<td>
						&nbsp;
					</td>
				</tr>						-->	

                        </tbody>
                    </table>
                </div>

                <div class="dialog">
                    <table border="0">
                        <tbody>
	
				<thead>
				<tr>
					<th>
						<b><label for="nvccReceiptBookNo">Receipt No</label><b>
					</th>
					<th>
						<b><label for="collectedById">Collector</label><b>
					</th>
					<th>
						<b><label for="donationDate">Receipt Date</label><b> 
					</th>
					<th>
						<b><label for="fundReceiptDate">Submission Date</label><b> 
					</th>								
					<th>
						<b><label for="amount"><g:message code="donation.amount.label" default="Amount" /></label><b>
					</th>
					<th>
						<b><label for="scheme">Scheme</label><b> 
					</th>
					<th>
						<b><label for="donorName">Donor Name</label><b> 
					</th>
					<th>
						<b><label for="PaymentMode">Cash?</label><b> 
					</th>
					<th valign="top" class="name">
						<b><label>Cheque No</label><b> 
					</th>
					<th valign="top" class="name">
						<b><label>Cheque Date</label><b> 
					</th>
					<th valign="top" class="name">
						<b><label for="bankName"><g:message code="donation.bankName.label" default="Bank" /></label><b>
					</th>
					<th valign="top" class="name">
						<b><label for="bankBranch">Bank Branch / Card Type</label><b>
					</th>
					<th>
						<b><label for="donorAddress">Address</label><b> 
					</th>
					<th>
						<b><label for="donorContact">Contact Number</label><b> 
					</th>
					<th>
						<b><label for="donorEmail">Email Id</label><b> 
					</th>
					<th>
						<b><label for="donorPAN">IT PAN</label><b> 
					</th>
					<th valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
						<b><label for="comments"><g:message code="donation.comments.label" default="Comment" /></label><b>
					</th>

				</tr>
				</thead>			
				<g:each in="${receiptBook.receipts.sort{ it.id }}" status="i" var="receipt">
					<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
						<td>
							<label>${receipt?.receiptNumber}</label>
							<g:hiddenField name="receipt${i}" value="${receipt}" />
						</td>
						<g:if test="${donations[i]}">

							<td>
								${collector[i]}
								<!--<g:if test="${rbIssued?.issuedTo}">
									${rbIssued?.issuedTo}
								   <g:checkBox name="CollectorChkBox${i}" value="${true}" checked="${true}"/> Use This Name<br>New Collector:
								   <g:hiddenField name="h_issuedTo${i}" value="${rbIssued?.issuedTo?.id}" />
								</g:if>
								   <g:else>
									<g:hiddenField name="collectorid${i}" value="${collector.id[i]}" />
									${collector[i]}
								   </g:else>-->
							   	<g:hiddenField name="collectedBy${i}.id" value="" />

							</td>		
							<td>
								<g:textField name="donationDate${i}" value="${donations[i].donationDate?.format('dd-MM-yyyy')}" size="8" disabled="true"/>
							</td>										
							<td>
								<g:textField name="fundReceiptDate${i}" value="${donations[i].fundReceiptDate?.format('dd-MM-yyyy')}" size="8" disabled="true"/>
							</td>

							<td>
								<g:textField name="amount${i}" value="${donations[i].amount}" size="8" disabled="true"/>                       
							</td>
							<td valign="top">
								<g:select name="scheme.id${i}" from="${ics.Scheme.list(sort:'name')}" optionKey="id" value="${donations[i].scheme?.id}" noSelection="['':'-Select-']" disabled="true"/>
							</td>

							<td>
								<g:textField name="donorName${i}" value="${donations[i].donorName}" disabled="true"/>                       
							</td>
							<td>
								<!--<g:if test="${donations[i].mode?.name=='Cash'}">
									<g:checkBox name="cash${i}" checked="true" disabled="true"/>
								</g:if>
								<g:else>
									<g:checkBox name="cash${i}"  checked="false" disabled="true"/>
								</g:else>-->
								<g:select name="mode.id${i}" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" value="${donations[i]?.mode?.id}"   noSelection="['':'-Select-']" disabled="true"/>
							</td>

							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
								<g:textField name="chequeNo${i}" value="${donations[i].chequeNo}" size="8" disabled="true"/>
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
								<g:textField name="chequeDate${i}" value="${donations[i]?.chequeDate?.format('dd-MM-yyyy')}" size="8" disabled="true"/>
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bank', 'errors')}">

								<g:textField name="bankName${i}" value="${donations[i].bankName}" disabled="true"/>
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}">
								<g:textField name="bankBranch${i}" value="${donations[i].bankBranch}" size="8" disabled="true"/>
							</td>
							<td>
								<g:textField name="donorAddress${i}" value="${donations[i].donorAddress}" disabled="true" />                       
							</td>
							<td>
								<g:textField name="donorContact${i}" value="${donations[i].donorContact}" size="10" disabled="true"/>                       
							</td>
							<td>
								<g:textField name="donorEmail${i}" value="${donations[i].donorEmail}" size="10" disabled="true"/>                       
							</td>
							<td>
								<g:textField name="donorPAN${i}" value="${donations[i].donorPAN}" size="10" disabled="true"/>                       
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
								<g:textField name="comments${i}" value="${donations[i].comments}" disabled="true"/>
							</td>

						</g:if>
						<g:else>

							<td>
								<g:if test="${rbIssued?.issuedTo}">
									${rbIssued?.issuedTo}
								   <g:checkBox name="CollectorChkBox${i}" value="${true}" checked="${true}"/> Use This Name<br>New Collector:
								   <g:hiddenField name="h_issuedTo${i}" value="${rbIssued?.issuedTo?.id}" />
								</g:if>
								<g:else>


								   <g:hiddenField name="collectedBy${i}.id" value="" />
								</g:else>
							   <div style="width: 200px">
								<gui:autoComplete
								id="acCollector${i}"
								width="200px"
								controller="individual"
								action="findCollectorsAsJSON"
								useShadow="true"
								queryDelay="0.5" minQueryLength='3'
								/>
							   </div>


							</td>	
							<td>
								<g:textField name="donationDate${i}" value="${new Date().format('dd-MM-yyyy')}" title="Receipt Date" size="8" />
								
							</td>										

							<td>
								<g:textField name="fundReceiptDate${i}" value="${new Date().format('dd-MM-yyyy')}" title="Submission Date" size="8" />
							</td>

							<td>
								<g:textField name="amount${i}" value="" title="Amount" size="8" />                       
								
							</td>
							<td valign="top">
								<g:select name="scheme.id${i}" from="${
									ics.Scheme.createCriteria().list{
										and {
											le("effectiveFrom", new Date())
											ge("effectiveTill", new Date())
										    }
										    order("name", "asc")
									}}"
								optionKey="id" value="${ ics.Scheme.findByName('General')?.id}"  title="Scheme" />
							</td>

							<td>
								<g:textField name="donorName${i}" value=""  title="Donor Name"/>                       
							</td>

							<td>
								<!--<g:checkBox name="cash${i}" checked="true" />-->
								<g:select name="mode.id${i}" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" value="${ ics.PaymentMode.findByName('Cash')?.id}"   noSelection="['':'-Select-']"/>
							</td>

							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
								<g:textField name="chequeNo${i}" value="" title="Cheque No." size="8" />
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
								<g:textField name="chequeDate${i}" value="${new Date().format('dd-MM-yyyy')}" title="Cheque Date" size="8" />
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bank', 'errors')}">
								<g:textField name="bankName${i}" title="Bank"/>
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}">
								<g:textField name="bankBranch${i}" value="" title="Bank Branch / Card Type" size="8" />
							</td>
							<td>
								<g:textField name="donorAddress${i}" title="Address" value=""  />                       
							</td>
							<td>
								<g:textField name="donorContact${i}" value="" title="Contact Number" size="10" />                       
							</td>
							<td>
								<g:textField name="donorEmail${i}" value="" title="Email Id" size="10" />                       
							</td>
							<td>
								<g:textField name="donorPAN${i}" value="" title="IT PAN" size="10" />                       
							</td>
							<td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
								<g:textField name="comments${i}" value="" title="Comment" />
							</td>

						</g:else>
					</tr>
				</g:each>


				<thead>
				<tr>

					<th>
						<b><label for="nvccReceiptBookNo">Receipt No</label><b>
					</th>
					<th>
						<b><label for="collectedById">Collector</label><b>
					</th>								
					<th>
						<b><label for="donationDate">Receipt Date</label><b> 
					</th>
					<th>
						<b><label for="fundReceiptDate">Submission Date</label><b> 
					</th>
					<th>
						<b><label for="amount"><g:message code="donation.amount.label" default="Amount" /></label><b>
					</th>
					<th>
						<b><label for="scheme">Scheme</label><b> 
					</th>
					<th>
						<b><label for="donorName">Donor Name</label><b> 
					</th>
					<th>
						<b><label for="PaymentMode">Cash?</label><b> 
					</th>
					<th valign="top" class="name">
						<b><label>Cheque No</label><b> 
					</th>
					<th valign="top" class="name">
						<b><label>Cheque Date</label><b> 
					</th>
					<th valign="top" class="name">
						<b><label for="bankName"><g:message code="donation.bankName.label" default="Bank" /></label><b>
					</th>
					<th valign="top" class="name">
						<b><label for="bankBranch">Bank Branch / Card Type</label><b>
					</th>
					<th>
						<b><label for="donorAddress">Address</label><b> 
					</th>
					<th>
						<b><label for="donorContact">Contact Number</label><b> 
					</th>
					<th>
						<b><label for="donorEmail">Email Id</label><b> 
					</th>								
					<th>
						<b><label for="donorPAN">IT PAN</label><b> 
					</th>
					<th valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
						<b><label for="comments"><g:message code="donation.comments.label" default="Comment" /></label><b>
					</th>
				</tr>
				</thead>
                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>

        </div>
        <script language="javascript"> 
        	function validate()
        	{
        		for(i=0; i<25; i++)
        		{
				if (document.getElementById("amount"+i).value != '' && document.getElementById("amount"+i).disabled == false && document.getElementById("amount"+i).value <= 0)
				{
					alert("Please enter Amount > 0!!");
					document.getElementById("amount"+i).focus();
					return false;
				}
				if(document.getElementById("amount"+i).value != '' && document.getElementById("amount"+i).disabled == false)
				{
					if(document.getElementById('scheme.id'+i).value == "")
					{
						alert("Please provide Scheme!!");
						document.getElementById('scheme.id'+i).focus();
						return false;
					}
				}
			}
			if (document.getElementById("acCollector"))
			{
				if (document.getElementById("acCollector").value == '')
				{
					alert("Please enter Collector Name!!");
					document.getElementById("acCollector").focus();
					return false;
				}
			}
        		
        		return confirm("Are you sure?");
        	}
        </script>
    </body>
</html>
