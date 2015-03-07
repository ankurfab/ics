
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title>Donation Entry</title>
	<r:require module="jqui" />
	<gui:resources components="['autoComplete']" />
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>

    </head>

    <body>

    <script type="text/javascript">

	    function filterPaymentMode() {
	    	var m = document.getElementById('mode.id');
	    	var pm = m.options[m.selectedIndex];
	    	if (pm.text.search(/Cash/)>-1 || pm.text.search(/Kind/)>-1)
	    	{
	    	    	var ele = document.getElementById("chequedetails");
	    		ele.style.display = "none";
			$('#chequeNo').val("")
			$('#chequeDate').val("")
			$('#bankName').val("")
			$('#bankBranch').val("")
		}
		else
	    	{
	    	    	var ele = document.getElementById("chequedetails");
	    		ele.style.display = "block";
	    	}
		
	}
	
	function replaceSpecialCharAndTrim(str) {
		if(str)
			{
			var retStr = str.replace(/[&\/\\#,+\-()$~%.'":*?<>{}]/g,' ');
			return retStr.trim();
			}
		else
			return "";
	}

		function validate() {  
			var m = document.getElementById('mode.id');
			var pm = m.options[m.selectedIndex];

			$('#chequeNo').val(replaceSpecialCharAndTrim($('#chequeNo').val()));
			$('#bankName').val(replaceSpecialCharAndTrim($('#bankName').val()));
			$('#bankBranch').val(replaceSpecialCharAndTrim($('#bankBranch').val()));

			if(document.getElementById('amount').value == "" || document.getElementById('amount').value<=0)
			{
				alert("Please enter amount >0!!");
				document.getElementById('amount').focus();
				return false;
			
			}
			if (pm.text.search(/Cheque/)>-1 || pm.text.search(/Card/)>-1)
			{
				
				if(document.getElementById('chequeNo').value == "" || document.getElementById('chequeDate').value == "" || document.getElementById('bankName').value == "" || document.getElementById('bankBranch').value == "")
				{
					alert("Please provide complete payment details (no,date,bank,branch) !!");
					document.getElementById('chequeNo').focus();
					return false;

				}
			}
			return true;
		}
        
        $(document).ready(function()
        {
          $("#chequeDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#demandDraftDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $('#icsid').focusout(getDetails);

		$( "#donorCity" ).autocomplete({
			source: "${createLink(controller:'city',action:'list')}",
			minLength: 2,
			  select: function(event, ui) {
			   $("#cityid").val(ui.item.id); // update the hidden field.
			  }
		});

		$( "#donorState" ).autocomplete({
			source: "${createLink(controller:'state',action:'list')}",
			minLength: 2,
			  select: function(event, ui) {
			   $("#stateid").val(ui.item.id); // update the hidden field.
			  }
		});

		$( "#donorCountry" ).autocomplete({
			source: "${createLink(controller:'country',action:'list')}",
			minLength: 2,
			  select: function(event, ui) {
			   $("#countryid").val(ui.item.id); // update the hidden field.
			  }
		});
		
		$( "#donorName" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#icsid").val(100000+ui.item.id); // update the hidden field.
			   getDetails();
			  }
		});
		

          $('#cc').focusout(function(){
          		var cc = $('#cc').val();
          		if(cc=='')
          			{
          			alert("Please enter cost center code!!");
          			return;
          			}
			var url = "${createLink(controller:'costCenter',action:'show')}"+"?cc="+cc;
			$.getJSON(url, {}, function(data) {
				//$('#cctext').text(data.cctext);
				if(data.cctext!=null)
					{
					    var options = '';
					    for (var x = 0; x < data.schemes.length; x++) {
						options += '<option value="' + data.schemes[x]['id'] + '">' + data.schemes[x]['name'] + '</option>';
						}
					$("select[name='scheme.id']").html(options);
					$("#scheme").show();

					}
				else
					alert("Please enter a valid cost center code!!");
          		});

		
   		 });          
    
   	});  
   	
   	function getDetails(){
	          		var icsid = $('#icsid').val();
	          		if(icsid=='')
	          			return;
	          		//clear open jgrowls
	          		$("div.jGrowl").jGrowl("close");
	          		//$('.jGrowl-notification').trigger('jGrowl.close');
	          		
	          		//alert(icsid);
				var url = "${createLink(controller:'individual',action:'info')}"+"?icsid="+icsid;
				//alert(url);
				$.getJSON(url, {}, function(data) {
					$('#donorName').val(data.name);
					$('#donorAddress').val(data.address);
					$('#donorContact').val(data.contact);
					$('#donorEmail').val(data.email);
					$('#donorPAN').val(data.pan);
					$('#donorCity').val(data.city);
					$('#donorState').val(data.state);
					$('#donorCountry').val(data.country);
					$('#donorPin').val(data.pin);
					$('#addrid').val(data.addrid);
					$('#contactid').val(data.contactid);
					$('#emailid').val(data.emailid);
					$('#donorid').val(data.id);
					
					//now make these fields readonly (if id was valid)
					if(data.valid=="yes")
						{
						//$('#donorName').attr("readonly", true);
						$('#donorAddress').attr("readonly", true);
						$('#donorContact').attr("readonly", true);
						$('#donorEmail').attr("readonly", true);
						$('#donorPAN').attr("readonly", true);
						$('#donorCity').attr("readonly", true);
						$('#donorState').attr("readonly", true);
						$('#donorCountry').attr("readonly", true);
						$('#donorPin').attr("readonly", true);
						
						//fire request for profile summary
						var csurl = "${g.createLink(controller:'individual',action:'profileSummary')}"+ "?id="+$('#donorid').val();
						$.getJSON(csurl, function(data) {
							var hdr = 'Profile Summary for '+data.name;
							var profileSummary ="Counsellor : "+data.profileSummary.counsellor
							profileSummary += "<br>Cultivator : "+data.profileSummary.cultivator
							profileSummary += "<br>Collectors : "+data.profileSummary.collectors
							profileSummary += "<br>RecentCollector : "+data.profileSummary.recentCollector
							$.jGrowl(profileSummary ,{ header: hdr ,sticky: true});
						    });


						//fire request for donation summary
						var dsurl = "${g.createLink(controller:'individual',action:'donationSummary')}"+ "?id="+$('#donorid').val();
						$.getJSON(dsurl, function(data) {
							var hdr = 'DonationSummary for '+data.name;
							var summary = "Total Individual Donation = "+data.summaryDonation.amtInd +"<br>"
							summary += "Total Family Donation = "+data.summaryDonation.amtFam +"<br>"
							summary += "Total Individual Gift Received = "+data.summaryDonation.amtGiftInd +"<br>"
							summary += "Total Family Gift Received = "+data.summaryDonation.amtGiftFam +"<br>"
							summary += "Total Individual Donation (Scheme Wise)= "+data.schemewise +"<br>";
							$.jGrowl(summary ,{ header: hdr ,sticky: true});
						    });
						
						//fire request for commitment summary
						var csurl = "${g.createLink(controller:'commitment',action:'commitmentSummary')}"+ "?committedBy.id="+$('#donorid').val();
						$.getJSON(csurl, function(data) {
							var hdr = 'CommitmentSummary for '+data.name;
							$.jGrowl(data.summaryCommitment ,{ header: hdr ,sticky: true});
						    });
						}
					else
						{
						$('#icsid').val("")
						$('#donorName').attr("readonly", false)
						$('#donorAddress').attr("readonly", false)
						$('#donorContact').attr("readonly", false)
						$('#donorEmail').attr("readonly", false)
						$('#donorPAN').attr("readonly", false)
						$('#donorCity').attr("readonly", false)
						$('#donorState').attr("readonly", false)
						$('#donorCountry').attr("readonly", false)
						$('#donorPin').attr("readonly", false)
						$('#donorName').val("")
						$('#donorAddress').val("")
						$('#donorContact').val("")
						$('#donorEmail').val("")
						$('#donorPAN').val("")
						$('#donorCity').val("")
						$('#donorState').val("")
						$('#donorCountry').val("")
						$('#donorPin').val("")
						}
				    });	
	          		
          		}
   		 
		function toggleModify() {
			if($("#modifyContact").is(':checked'))
				{
					$('#donorAddress').attr("readonly", false)
					$('#donorContact').attr("readonly", false)
					$('#donorEmail').attr("readonly", false)
					$('#donorPAN').attr("readonly", false)
					$('#donorCity').attr("readonly", false)
					$('#donorState').attr("readonly", false)
					$('#donorCountry').attr("readonly", false)
					$('#donorPin').attr("readonly", false)
				}
			else
				{
					$('#donorAddress').attr("readonly", true)
					$('#donorContact').attr("readonly", true)
					$('#donorEmail').attr("readonly", true)
					$('#donorPAN').attr("readonly", true)
					$('#donorCity').attr("readonly", true)
					$('#donorState').attr("readonly", true)
					$('#donorCountry').attr("readonly", true)
					$('#donorPin').attr("readonly", true)
				}
		}
    
    </script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
	    <span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>
	    <span class="menuButton"><g:link class="create" action="bulkdonation0">Bulk Donation</g:link></span>
            <g:if test="${donationInstance?.id}">
		<span class="menuButton"><g:link class="create" controller="giftIssued" action="createfordonation" params="['donation.id': donationInstance?.id]">IssueGift</g:link></span>
	    </g:if>
            <sec:ifAnyGranted roles="ROLE_BACKOFFICE,ROLE_DUMMY">
		<span class="menuButton"><g:link class="list" controller="costCenter" action="list">CostCenters</g:link></span>
            </sec:ifAnyGranted>		    
            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
		<span class="menuButton"><g:link class="list" controller="donation" action="bulkPrint">BulkPrint</g:link></span>
            </sec:ifAnyGranted>		    
	</div>
        <div class="body">
            <h1>Donation Entry</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}<g:link class="create" action="printEntry" id="${id}">Print Receipt</g:link></div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>


            <g:form action="saveEntry" method="post" onsubmit="return validate();">
               
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="icsid">Donor's IcsId:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donorName', 'errors')}">
                                    <g:textField id="icsid" name="icsid" value="${id?(100000+new Long(id)):donationInstance?.donatedBy?.icsid}" size="8" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="donorName">Donor Name</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donorName', 'errors')}">
                                    <g:textField name="donorName" value="${donationInstance?.donorName}" size="50"/>
                                    Modify Contact?<g:checkBox name="modifyContact" value="${false}" onClick="toggleModify()"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    Address
                                </td>
                                <td valign="top" class="value">
					<g:textArea name="donorAddress" value="${donationInstance?.donorAddress}" style="width: 550px; height: 50px;" maxlength="255"/>                                						
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                </td>
                                <td valign="top" class="value">
                                	City: <g:textField name="donorCity" value="Pune" size="10"/>
                                	State: <g:textField name="donorState" value="Maharashtra" size="10"/>
                                	Country: <g:textField name="donorCountry" value="India" size="10"/>
                                	Pin: <g:textField name="donorPin" value="" size="10"/>
                                </td>
                                <g:hiddenField name="cityid" value=""/>
                                <g:hiddenField name="stateid" value=""/>
                                <g:hiddenField name="countryid" value=""/>
                                <g:hiddenField name="addrid" value="${addrid}"/>
                                <g:hiddenField name="contactid" value="${contactid}"/>
                                <g:hiddenField name="emailid" value="${emailid}"/>
                                <g:hiddenField name="donorid" value="${donorid}"/>
                            </tr>

                            <tr class="prop">
                                <td valign="top" width="18%">
                                    Contact Number
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="donorContact" value="${donationInstance?.donorContact}" size="10"/>
                                	Email: <g:textField name="donorEmail" value="${donationInstance?.donorEmail}" size="30"/>
                                	IT PAN: <g:textField name="donorPAN" value="${donationInstance?.donorPAN}" size="10"/>
                                	
                                </td>
                            </tr>

                            <!--<tr class="prop">
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
                            </tr>-->
                            
                        </tbody>
                    </table>
                </div>

                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="dt">Collection Type</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'collectionType', 'errors')}">
					<g:select name="collectionType" from="${['Donation','Donation in Kind','Sale of Scrap','Sukriti Deposit','Safe Custody Deposit','Settlement of loan / advances','Hundi Collections']}" value="${'Donation'}"/> 
					80G?<g:checkBox name="taxBenefit" value="${donationInstance?.taxBenefit?:false}" />
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
                                    <label for="cc">CostCenter</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
					<g:textField name="cc" /> 
		                    <div id="cctext"></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="dialog" id="scheme" style="display:block">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="scheme">Scheme</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
				<g:select name="scheme.id" from="" 
				optionKey="id" value="${donationInstance?.scheme?.id}" noSelection="['':'-Select-']" />
                                    
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
									Payment Mode
								</td>
								<td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'city', 'errors')}">
									<g:select name="mode.id" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" value="${ ics.PaymentMode.findByName('Cash')?.id}"   noSelection="['':'-Select Payment Mode-']" onchange="filterPaymentMode();"/>
									Amount:<g:textField name="amount" value="${fieldValue(bean: donationInstance, field: 'amount')}"/>
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
		                                    No
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
		                                    <g:textField name="chequeNo" value="${donationInstance?.chequeNo}" />
		                                    Date: <g:textField name="chequeDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
		                                    Bank: <g:textField name="bankName" value="${donationInstance?.bankName}"/>
		                                    Branch: <g:textField name="bankBranch" value="${donationInstance?.bankBranch}"/>
		                                    
		                                </td>
		                            </tr>
		                        
		                            <!--<tr class="prop">
		                                <td valign="top" width="18%">
		                                    Date
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
		                                    <g:textField name="chequeDate" value="${donationInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
		                                </td>
		                            </tr>
		                        
		                        
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    <label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankName', 'errors')}">
		                                    <g:textField name="bankName" value="${donationInstance?.bankName}"/>
		                                </td>
		                            </tr>
		
		                            <tr class="prop">
		                                <td valign="top" width="18%">
		                                    <label for="bankBranch"><g:message code="donation.bankBranch.label" default="Bank Branch" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}">
		                                    <g:textField name="bankBranch" value="${donationInstance?.bankBranch}"/>
		                                </td>
		                            </tr>-->
					</tbody>
				</table>
			</div>

                <!--<div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="amount"><g:message code="donation.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: donationInstance, field: 'amount')}"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>-->
                                
                <div class="dialog" id="collectorDiv">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr >
                                <td valign="top" width="18%">
                                    <label for="collectedBy"><g:message code="donation.collectedBy.label" default="Collected By" /></label>
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

			</tbody>
			</table>
		</div>

                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                        
                            <tr class="prop">
                                <td valign="top" width="18%">
                                    <label for="comments">Remarks</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${donationInstance?.comments}" maxlength="100" style="width: 550px; height: 50px;"/>
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/></span>
                </div>
            </g:form>


	    <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
		<div>
		Upload donations in bulk: <br />
		    <g:uploadForm action="uploadbulkdonation">
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>
	    </sec:ifAnyGranted>


        </div>


    </body>
</html>
