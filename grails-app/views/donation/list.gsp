
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <gui:resources components="['autoComplete']"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
    </head>
    <body>
	<g:javascript src="datatable/jquery.dataTables.min.js" />    
	<g:javascript src="datatable/ZeroClipboard.js" />    
	<g:javascript src="datatable/TableTools.min.js" />    
	<script type="text/javascript" charset="utf-8">
		$(document).ready( function () {
		    $('#example').dataTable( {
			"sDom": 'T<"clear">lfrtip',
			"oTableTools": {
			    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"	
			}
		    } );
		} );
    </script>

    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#sReceiptDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});
          $("#sSubmissionDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});
          $("#sReceiptDate1").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});
          $("#sSubmissionDate1").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});
          
        })
    </script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
		<span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>
		<span class="menuButton"><g:link class="create" action="bulkdonation0">Bulk Donation</g:link></span>
            	<span class="menuButton"><g:link class="list" controller="pdc" action="list">PDC</g:link></span>
            	<span class="menuButton"><g:link class="list" controller="helper" action="mapdummydonar"  params="[fuzzy: 'true']">MapDummyDonar</g:link></span>
            </sec:ifNotGranted>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
	    <a href="javascript:toggleSearchParams()">Search Parameters </a>
	    
	    <div id='div-search' class="dialog" style="display: none">

            <g:if test="${!cheque}">
		<g:form name="searchForm" action="search" >
               	<g:hiddenField name="ExactDLN" value="LikeDLN" />
               	<g:hiddenField name="ExactCLN" value="LikeCLN" />
               	<g:hiddenField name="ExactDIN" value="LikeDIN" />
               	<g:hiddenField name="ExactCIN" value="LikeCIN" />               	
               	<g:hiddenField name="ExactRLN" value="LikeRLN" />               	
               	<g:hiddenField name="ExactRIN" value="LikeRIN" />               	               	
               	<g:hiddenField name="ExactCHK" value="LikeCHK" />               	               	
               	<g:hiddenField name="Range" value="NoRange" />               	               	               	
               	<g:hiddenField name="Rangerd" value="NoRange" />    
               	<g:hiddenField name="Rangesd" value="NoRange" />                   	
               	<table>
                    <thead>
	                        <tr>
	                        <td>ReceiptBook</td>
	                        <td><g:textField name="sBookNumber" /></td>
				</tr>
	                        <tr>
	                        <td>ReceiptNo</td>
	                        <td><g:textField name="sReceiptNumber" /></td>
				</tr>
	                        <tr>
	                        <td>Remarks</td>
	                        <td><g:textField name="sComments" /></td>
				</tr>
	                        <tr>
	                        <td>Cheque No</td>
	                        <td><g:textField name="sChqNo" /></td>
	                        <td>Exact <g:checkBox name="ExactCHK1" onClick="checkActual() "  /></td>
				</tr>
	                        <tr>
	                        <td>Donor Legal Name</td>
	                        <td><g:textField name="sDonorLegalName" /></td>
	                        <td>Exact <g:checkBox name="ExactDLN1" onClick="checkActual() "  /></td>
	                        
				</tr>
	                        <tr>
	                        <td>Donor Initiated Name</td>
	                        <td><g:textField name="sDonorInitName" /></td>
	                        <td>Exact <g:checkBox name="ExactDIN1" onClick="checkActual() "  /></td>	                        
				</tr>
	                        <tr>
	                        <td>DonorName</td>
	                        <td><g:textField name="sDonorName" /></td>
	                        <td>Exact <g:checkBox name="ExactDIN1" onClick="checkActual() "  /></td>	                        
				</tr>
	                        <tr>
	                        <td>Collector Legal Name</td>
	                        <td><g:textField name="sCollectorLegalName" /></td>
			
				<td>Exact <g:checkBox name="ExactCLN1" onClick="checkActual() "  /></td>
	                        
				</tr>
	                        <tr>
	                        <tr>
	                        <td>Collector Initiated Name</td>
	                        <td><g:textField name="sCollectorInitName" /></td>
				<td>Exact <g:checkBox name="ExactCIN1" onClick="checkActual() "  /></td>	                        
				</tr>
	                        <tr>
	                        <td>Receiver Legal Name</td>
	                        <td><g:textField name="sReceiverLegalName" /></td>
				<td>Exact <g:checkBox name="ExactRLN1" onClick="checkActual() "  /></td>	                        
	                        
				</tr>
	                        <tr>
	                        <tr>
	                        <td>Receiver Initiated Name</td>
	                        <td><g:textField name="sReceiverInitName" /></td>
				<td>Exact <g:checkBox name="ExactRIN1" onClick="checkActual() "  /></td>	                        
	                        
				</tr>
	                        <td>Payment Comments</td>
	                        <td><g:textField name="sPaymentComments" /></td>
				</tr>
	                        <tr>
	                        <td>Receipt Date</td>
	                        <td>FROM<g:textField name="sReceiptDate" /></td></tr>
	                        <tr><td></td><td>To<g:textField name="sReceiptDate1" /></td>	        
				<td>Range <g:checkBox name="Rangerd1" onClick="checkRange() "  /></td>	                        	                        
				</tr>
	                        <tr>
	                        <td>Submission Date</td>
	                        <td>FROM<g:textField name="sSubmissionDate" /></td></tr>
	                        <tr><td></td><td>To  <g:textField name="sSubmissionDate1" /></td>
				<td>Range <g:checkBox name="Rangesd1" onClick="checkRange() "  /></td>	                        	                        
				</tr>
	                        <tr>
	                        <td>Amount</td>
	                        <td>FROM<g:textField name="sAmount" /></td></tr>
	                        <tr><td></td><td>To<g:textField name="sAmount1" /></td>	                        
				<td>Range <g:checkBox name="Range1" onClick="checkRange() "  /></td>	                        
				</tr>
	                        <tr>
	                        <td>Donation Type</td>
	                        <td><g:select name="sDonationTypeSchemeId" from="${ics.Scheme.list(sort:'name')}" optionKey="id" noSelection="['':'-Select-']"/></td>
				</tr>
			</thead>
		</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
                <br>
		</g:form>
            </g:if>
            </div>


            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                            <!--<g:sortableColumn property="id" title="${message(code: 'donation.id.label', default: 'Id')}" />
                            
                            <g:sortableColumn property="fundReceiptDate" title="SubmissionDate" />
                        
                            <g:sortableColumn property="nvccReceiptBookNo" title="BookNo" />
                        
                            <g:sortableColumn property="nvccReceiptNo" title="ReceiptNo" />-->
                            
                            <th>Id</th>
                            
                            <th>SubmissionDate</th>
                            
                            <th>BookNo</th>
                            
                            <th>ReceiptNo</th>
                        
                            <th><g:message code="donation.donatedBy.label" default="Donated By" /></th>
                        
                            <th>Remarks</th>
			
			    <th>DonorName</th>
			    
                            <th><g:message code="donation.collectedBy.label" default="Collected By" /></th>
                        
                            <!--<g:sortableColumn property="amount" title="${message(code: 'donation.amount.label', default: 'Amount')}" />-->
                            
                            <th>Amount</th>
                            
				<g:if test="${cheque}">
					<th>ChequeNo</th>
					<th>ChequeDate</th>
					<th>Bank</th>
				</g:if>

							
			    <th> <g:checkBox name="checkAll" value="SelectAll" checked="false" onclick="checkUncheckAll()"/> Invite for Event</th>
							
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${donationInstanceList}" status="i" var="donationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}"><g:link action="show" id="${donationInstance.id}"><g:formatNumber number="${donationInstance?.id}" format="#" /></g:link></td>
                            
                            <td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${donationInstance?.fundReceiptDate.format("dd-MM-yyyy")}</td>
                        
                            <g:if test="${fieldValue(bean: donationInstance, field: 'nvccReceiptBookNo')}">
                            	<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${fieldValue(bean: donationInstance, field: "nvccReceiptBookNo")}</td>
                            </g:if>
                            <g:else>
                            	<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${ics.Receipt.findById(donationInstance?.donationReceiptId)?.receiptBook}</td>
                            </g:else>
                        	
                            <g:if test="${fieldValue(bean: donationInstance, field: 'nvccReceiptNo')}">
                            	<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${fieldValue(bean: donationInstance, field: "nvccReceiptNo")}</td>
                            </g:if>
                            <g:else>
                            	<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${ics.Receipt.findById(donationInstance?.donationReceiptId)?.receiptNumber}</td>
                            </g:else>
                        
                            <td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}"><g:link controller = "individual" action="show" id="${donationInstance?.donatedBy?.id}">${fieldValue(bean: donationInstance, field: "donatedBy")}</g:link></td>
                        
                            <td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${fieldValue(bean: donationInstance, field: "comments")}</td>
                            
                            <td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${fieldValue(bean: donationInstance, field: "donorName")}</td>
                        
                            <td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${fieldValue(bean: donationInstance, field: "collectedBy")}</td>
                        
                            <td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${fieldValue(bean: donationInstance, field: "amount")}</td>
                            

				<g:if test="${cheque}">
					<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${donationInstance?.chequeNo}</td>
					<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}"><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDate}" /></td>
					<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">${donationInstance?.bank?.name}</td>
				</g:if>
							
				<td bgcolor="${donationInstance?.status == 'BOUNCED' ? 'red' : ''}">
				
					<g:if test="${(donationInstance?.donatedBy).toString() != 'Dummy Donor for daily transactions'}">
						<g:checkBox name="Invite" value="${donationInstance?.id}" checked="false" />
					</g:if>
					<g:else>
						<g:checkBox name="dontInvite" value="test" checked="false" disabled="true"/>
					</g:else>
				</td>
                        	
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${!search}">
            <div class="paginateButtons">
                <g:paginate total="${donationInstanceTotal}" />
            </div>
            </g:if>

	    <br>
	    <div class="buttons">
		<g:form name="inviteForm" controller="eventParticipant" action="invite" >
            		<g:hiddenField name="donationIds" id="donationIds" value=""/>
			<span class="button"><g:actionSubmit name="inviteForEvent" class="save" action="invite" onclick="inviteForEvent()" value="Invite for Event" /></span>
		</g:form>
	    </div>

        </div>
        
        
        <script language="javascript"> 
	    function toggleSearchParams() {
		var ele = document.getElementById("div-search");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
	    } 
	    
	    	    function checkActual() {
	    	    	var cb = document.getElementById('ExactDLN1');
	    	    	var cb1 = document.getElementById('ExactCLN1');
	    		var flag = document.getElementById('ExactDLN');
	    		var flag1 = document.getElementById('ExactCLN');

	    	    	var cb2 = document.getElementById('ExactDIN1');
	    	    	var cb3 = document.getElementById('ExactCIN1');
	    		var flag2 = document.getElementById('ExactDIN');
	    		var flag3 = document.getElementById('ExactCIN');

			var chk = document.getElementById('ExactCHK1');	    		
	    		var flagchk = document.getElementById('ExactCHK');			

			var cbrl = document.getElementById('ExactRLN1');	    		
	    		var flagrl = document.getElementById('ExactRLN');			
			var cbri = document.getElementById('ExactRIN1');	    		
	    		var flagri = document.getElementById('ExactRIN');			

	    	    	if (cb.checked)
	    	    	{flag.value = "ExactDLN";}
	    	    	else
	    	    		{flag.value = "LikeDLN";}
			if (cb1.checked)
	    	    	{flag1.value = "ExactCLN";}
	    	    	else
	    	    		{flag1.value = "LikeCLN";}	   
	    	    		
	    	    	if (cb2.checked)
	    	    	{flag2.value = "ExactDIN";}
	    	    	else
	    	    		{flag2.value = "LikeDIN";}
	    	    	if (cb3.checked)
	    	    	{flag3.value = "ExactCIN";}
	    	    	else
	    	    		{flag3.value = "LikeCIN";}
	    	    		
	    	    	if (cbrl.checked)
	    	    	{flagrl.value = "ExactRLN";}
	    	    	else
	    	    		{flagrl.value = "LikeRLN";}
	    	    	if (cbri.checked)
	    	    	{flagri.value = "ExactRIN";}
	    	    	else
	    	    		{flagri.value = "LikeRIN";}

	    	    	if (chk.checked)
	    	    	{flagchk.value = "ExactCHK";}
	    	    	else
	    	    		{flagchk.value = "LikeCHK";}

	    	    } 
	    	    function checkRange() {
	    	    	var rg = document.getElementById('Range1');
	    		var rgflag = document.getElementById('Range');

	    	    	var rgrd = document.getElementById('Rangerd1');
	    		var rgflagrd = document.getElementById('Rangerd');

	    	    	var rgsd = document.getElementById('Rangesd1');
	    		var rgflagsd = document.getElementById('Rangesd');

	    	    	if (rg.checked)
	    	    	{rgflag.value = "Range";}
	    	    	else
	    	    		{rgflag.value = "NoRange";}
	    		
	    	    	if (rgrd.checked)
	    	    	{rgflagrd.value = "Range";}
	    	    	else
	    	    		{rgflagrd.value = "NoRange";}

	    	    	if (rgsd.checked)
	    	    	{rgflagsd.value = "Range";}
	    	    	else
	    	    		{rgflagsd.value = "NoRange";}
	    		
			}

		function checkUncheckAll()
		{
			var InviteChkBoxes = document.getElementsByName("Invite");
			var checkedAll = document.getElementById("checkAll");
			
			if(checkedAll.checked == true)
			{
				for(i=0; i< InviteChkBoxes.length; i++)
					InviteChkBoxes[i].checked = true;
			}
				//document.getElementsByName("Invite").checked = true;
			else
			{
				for(i=0; i< InviteChkBoxes.length; i++)
					InviteChkBoxes[i].checked = false;
			}
				//document.getElementsByName("Invite").checked = false;
		}
	    	    
	</script>

	<g:javascript>
		function inviteForEvent()
		{
			var InviteChkBoxes = document.getElementsByName("Invite");
			var donationIds = new Array();
			
			for(i=0; i< InviteChkBoxes.length; i++)
			{
				if(InviteChkBoxes[i].checked == true)
					donationIds[i] = InviteChkBoxes[i].value;
			}
			if(donationIds.length == 0)
			{
				alert("Please select donor(s) to be invited");
				return false;
			}
			else
			{
				document.getElementById("donationIds").value = donationIds;
				return true;
			}
		}
	
	</g:javascript>
    </body>
</html>
