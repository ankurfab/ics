<%@ page import="ics.Project" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>EMS</title>
	<r:require module="grid" />
	<r:require module="ajaxform"/>
	<r:require module="printarea" />
    <r:require module="jqbarcode" />
</head>

<body>

	<div id="dialogShowChildProjects" title="Part Payment(s)">
		<div id="divToShowChildProjects"></div>
	</div>

    <div id="dialogNewProjectForm" title="Add New Expense">
        <g:form name="addprojectForm" controller="project" action="save" method="POST">
            <g:render template="/project/addproject" />
        </g:form>
    </div> 

    <div id="dialogDetailsForm" title="Expense Details">
        <g:form name="detailsForm" controller="project" action="update" method="POST">
            <div id="divProjectDetails"></div>
        </g:form>
    </div> 

    <div id="dialogAdvanceForm" title="Expense Advance">
        <g:form name="advanceForm" controller="project" action="issueAdvance" method="POST">
            <div id="divProjectAdvance"></div>
        </g:form>
    </div> 

    <div id="dialogLedgerHeadForm" title="Ledger Head">
        <g:form name="ledgerHeadForm" controller="project" action="assignLedgerHead" method="POST">
	    <g:hiddenField name="expidsForLedgerHead" value="" />
            <div id="divLedgerHead"></div>
            <g:render template="/project/ledgerHead" />
        </g:form>
    </div> 

    <div id="dialogDeductionForm" title="Deduction">
        <g:form name="deductionForm" controller="project" action="calculateDeduction" method="POST">
            <g:render template="/project/deduction" />
        </g:form>
    </div> 

    <div id="dialogPayExpenseForm" title="Pay">
        <g:form name="payExpenseForm" controller="Voucher" action="payExpenseSave" method="POST">
            <div id="divPayExpense"></div>
        </g:form>
    </div> 

	<div id="dialogPrintApproval" title="Print Approval">
		<div id="divToPrintApproval"></div>
	</div>

	<div id="dialogPrintReimbursement" title="Print Reimbursement">
		<div id="divToPrintReimbursement"></div>
	</div>

	<div id="dialogRejectProject" title="Comments">
		<g:form name="formRejectProject" controller="Project" action="saveRejectProject" method="post" >
		<g:hiddenField name="projectId" value="" />
		<g:textArea name="review3Comments" value="" rows="5" cols="40" placeholder="Comments"/>
		</g:form>
	</div>            

	<div id="dialogRejectExpense" title="Comments">
		<g:form name="formRejectExpense" controller="Project" action="saveRejectExpense" method="post" >
		<g:hiddenField name="err_projectId" value="" />
		<g:textArea name="review3Comments" value="" rows="5" cols="40" placeholder="Comments"/>
		</g:form>
	</div>            

    <div id="dialogPrintVoucher" title="Print Voucher">
	<g:form name="printVoucherForm" method="POST">
	<div id="divPrintVoucher"></div> 
	</g:form>
   </div>     

    <!-- table tag will hold our grid -->
    <table id="project_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
    <!-- pager will hold our paginator -->
    <div id="project_list_pager" class="scroll" style="text-align:center;"></div>
    
  <div id="dialogNewExpensetForm" title="Add New Expense">
       <g:form name="expenseForm" controller="expense" action="save" method="POST">     
        <g:render template="/expense/addexpense" />    
        </g:form> 
    </div> 
     <div id="dialogAdvanceError" title="Advance is Already issued"></div>
     <div id="dialogLedgerHeadError" title=""></div>
    
            
           
    <g:if test="${s_status=='APPROVED_REPORT' || s_status=='SU'}">
     <table id="partproject_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="partproject_list_pager" class="scroll" style="text-align:center;"></div>


     <table id="expense_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="expense_list_pager" class="scroll" style="text-align:center;"></div>
    </g:if>
    
  
    <script type="text/javascript">
     function  confirmComplete()
     {
    
     var answer=confirm("Are you sure to submit the form???");
     if (answer==true)
       {
        
         return true;
       }
     else
       {
         return false;
      }
     }
        $(document).ready(function()
        {
           //advanceIssued checkbox 

		jQuery("#partproject_list").jqGrid({
	                
		url: "${createLink(controller:'Project',action:'jq_partproject_list')}",	                    
		datatype: "json",
		//colNames: ['CostCenter','Name', 'Description', 'Category', 'SubmitDate','Amount', 'Requested Advance Amount','Issued Advance Amount','Type','Mode','IssueTo','IssueComments','BillNo','BillDate','Voucher','MainExpense','Priority','Status','Reference', 'Id'],
		colNames: ['CostCenter','Name', 'Description',  'SubmitDate','Amount', 'Requested Advance Amount','Issued Advance Amount','Type','Voucher','MainExpense','Priority','Status','Reference', 'Id'],
		colModel: [
		{name: 'costCenter', search: true, editable: false,
		    stype:'select', searchoptions: {value:"${':ALL;'+(ics.CostCenter.findAllByStatusIsNull([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}
		    },
		{name: 'name', search: true, editable: true},
		{name: 'description', search: true, editable: true},
		//{name: 'category', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;REVENUE:REVENUE;CAPITAL:CAPITAL'}},
		{name: 'submitDate', search: true, editable: true,
			searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    
		},
		{name: 'amount', search: true, editable: true},
		{name: 'advanceAmount', search: true, editable: true},
		{name: 'advanceAmountIssued', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;NO:NO;YES:YES'}},
		{name: 'type', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;NORMAL:NORMAL;PARTPAYMENT:PARTPAYMENT;CREDIT:CREDIT'}},
		/*{name: 'mode', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;CASH:CASH;CHEQUE:CHEQUE;RTGS:RTGS;TRANSFER:TRANSFER'}},
		{name: 'issueTo', search: true, editable: true},
		{name: 'issueComments', search: true, editable: true},
		{name: 'billNo', search: true, editable: true},
		{name: 'billDate', search: true, editable: true,
			searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    
		},*/
		{name: 'advancePaymentVoucher', search: true, editable: true,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'voucher',action:'showFromProject',target:'_new')}'}
		},
		{name: 'mainProject', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;YES:YES;NO:NO'}},
		{name: 'priority', search: true, editable: true,stype:'select', searchoptions: {value:"${':ALL;'+['P1(URGENT)','P2(HIGH)','P3(MEDIUM)','P4(LOW)'].collect{it+':'+it}.join(';')}"}},
		{name: 'status', search: true, editable: true,stype:'select', searchoptions: {value:"${':ALL;'+['SETTLED_REPORT','REJECTED_REPORT','APPROVED_REPORT','SUBMITTED_REPORT','DRAFT_REPORT','DRAFT_REQUEST','APPROVED_REQUEST','REJECTED_REQUEST','SUBMITTED_REQUEST','ESCALATED_REQUEST'].collect{it+':'+it}.join(';')}"}},
		{name: 'ref', search: true, editable: true,formatter:'showlink',formatoptions:{baseLinkUrl:'${createLink(controller:'Project',action:'show')}'}},
		{name: 'id', hidden: true}
		],
		rowNum: 5,
		rowList: [5, 10, 20, 30, 40, 50],
		pager: '#partproject_list_pager',
		multiselect: true,
		gridview: true,
		sortname: "id",
		sortorder: "desc",
		width: 1250,
		height: "100%",
		viewrecords:true,
		showPager: true,
		caption: "Part Payment List",
	    loadError: function (jqXHR, textStatus, errorThrown) {
		alert('Session timed-out. Please login again!!');
		window.open("${createLinkTo(dir: '')}","_self")		
	    }	                		
		});
	                	                
		$("#partproject_list").jqGrid('filterToolbar', {autosearch: true});
		$("#partproject_list").jqGrid('navGrid',"#partproject_list_pager",{edit:false,add:false,del:false,search:false});
		$("#partproject_list").jqGrid('inlineNav',"#partproject_list_pager",{edit: false,add: false,save: false,cancel: false});
		$("#partproject_list").jqGrid('navGrid', "#partproject_list_pager").jqGrid('navButtonAdd', "#partproject_list_pager", {caption: "Remove", buttonicon: "ui-icon-cancel", onClickButton: removePP, position: "last", title: "Remove", cursor: "pointer"});
		$("#partproject_list").jqGrid('navGrid', "#partproject_list_pager").jqGrid('navButtonAdd', "#partproject_list_pager", {caption: "Link", buttonicon: "ui-icon-extlink", onClickButton: linkPP, position: "last", title: "Link", cursor: "pointer"});

		function removePP() {}
		function linkPP() {}


           
        
            jQuery("#project_list").jqGrid({
                url: 'jq_project_list?s_status='+'${s_status}'+'&onlyAdv='+'${onlyAdv}'+'&advAmtIssued='+'${advAmtIssued}',
                editurl: 'jq_edit_project',
		      /*postData:{
			status:function(){return "${status?:''}";},
			},*/
                datatype: "json",
                align: 'Center',
                //colNames: ['CostCenter','Name', 'Description', 'Category', 'SubmitDate','Amount', 'Requested Advance Amount','Issued Advance Amount','Type','Mode','IssueTo','IssueComments','BillNo','BillDate','Voucher','MainExpense','Priority','Status','Reference', 'Id'],
                colNames: ['CostCenter','Name', 'Description', 'SubmitDate','Amount', 'Requested Advance Amount','Issued Advance Amount','Type','Voucher','MainExpense','Priority','Status','Reference', 'Id'],
                colModel: [
                    {name: 'costCenter', search: true, editable: false,
	                    stype:'select', searchoptions: {value:"${':ALL;'+(ics.CostCenter.findAllByStatusIsNull([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}
	                    },
                    {name: 'name', search: true, editable: true},
                    {name: 'description', search: true, editable: true},
                    //{name: 'category', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;REVENUE:REVENUE;CAPITAL:CAPITAL'}},
                    {name: 'submitDate', search: true, editable: true,
				searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    
                    	},
                    {name: 'amount', search: true, editable: true},
                    {name: 'advanceAmount', search: true, editable: true},
                    {name: 'advanceAmountIssued', search: true, editable: true,stype:'select', searchoptions: { value: 'ALL:ALL;NO:NO;YES:YES'}},
                    {name: 'type', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;NORMAL:NORMAL;PARTPAYMENT:PARTPAYMENT;CREDIT:CREDIT'}},
                    /*{name: 'mode', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;CASH:CASH;CHEQUE:CHEQUE;RTGS:RTGS;TRANSFER:TRANSFER'}},
                    {name: 'issueTo', search: true, editable: true},
                    {name: 'issueComments', search: true, editable: true},
                    {name: 'billNo', search: true, editable: true},
                    {name: 'billDate', search: true, editable: true,
				searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    
                    },*/
                    {name: 'advancePaymentVoucher', search: true, editable: true,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'voucher',action:'showFromProject',target:'_new')}'}
			},
                    {name: 'mainProject', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;YES:YES;NO:NO'}},
                    {name: 'priority', search: true, editable: true,stype:'select', searchoptions: {value:"${':ALL;'+['P1(URGENT)','P2(HIGH)','P3(MEDIUM)','P4(LOW)'].collect{it+':'+it}.join(';')}"}},
                    //{name: 'status', search: true, editable: true,stype:'select', searchoptions: {value:"${':ALL;'+['SETTLED_REPORT','REJECTED_REPORT','APPROVED_REPORT','SUBMITTED_REPORT','DRAFT_REPORT','DRAFT_REQUEST','APPROVED_REQUEST','REJECTED_REQUEST','SUBMITTED_REQUEST','ESCALATED_REQUEST'].collect{it+':'+it}.join(';')}"}},

		    <sec:ifAnyGranted roles="ROLE_ACC_USER">
			<g:if test="${s_status=='APPROVED_REQUEST'}">
			    {name: 'status', search: true, editable: true,stype:'select', searchoptions: {value:"${['APPROVED_REQUEST'].collect{it+':'+it}.join(';')}"}},
			</g:if>
			<g:if test="${s_status=='APPROVED_REPORT'}">
			    {name: 'status', search: true, editable: true,stype:'select', searchoptions: {value:"${['APPROVED_REPORT','SETTLED_REPORT'].collect{it+':'+it}.join(';')}"}},
			</g:if>
		    </sec:ifAnyGranted>
		    <sec:ifAnyGranted roles="ROLE_FINANCE">
			    {name: 'status', search: true, editable: true,stype:'select', searchoptions: {value:"${':ALL;'+['SETTLED_REPORT','REJECTED_REPORT','APPROVED_REPORT','SUBMITTED_REPORT','DRAFT_REPORT','DRAFT_REQUEST','APPROVED_REQUEST','REJECTED_REQUEST','SUBMITTED_REQUEST','ESCALATED_REQUEST'].collect{it+':'+it}.join(';')}"}},
		    </sec:ifAnyGranted>
                    
                    {name: 'ref', search: true, editable: true,formatter:'showlink',formatoptions:{baseLinkUrl:'${createLink(controller:'Project',action:'show')}'}},
                    {name: 'id', hidden: true}
                ],
                rowNum: 10,
                rowList: [5, 10, 20, 30, 40, 50],
                pager: '#project_list_pager',
                multiselect: false,
                gridview: true,
	        sortname: "id",
                sortorder: "desc",
                width: 1250,
                height: "100%",
                viewrecords:true,
                showPager: true,
                caption: "Expense List",
 	    /*  grouping:true,
 	        groupingView : { 
 			groupField : ['submitDate'], 
 			groupSummary : [true], 
 			groupColumnShow : [true], 
 			groupText : ['<b>{0}</b>'], 
 			groupCollapse : true, 
 			groupOrder: ['asc']
 			},                */ 
 		onSelectRow: function(ids) { 
	    	   if(ids!='new_row')
	    	          { 
	        var selName = jQuery('#project_list').jqGrid('getCell', ids, 'name'); 
	        var url = "${createLink(controller:'Project',action:'jq_expense_list')}"+"?projectid="+ids;
	        jQuery("#expense_list").jqGrid('setGridParam',{url:url});
	    	var editurl = "${createLink(controller:'Project',action:'jq_edit_expense')}"+"?projectid="+ids;
	    	jQuery("#expense_list").jqGrid('setGridParam',{editurl:editurl});
	    	jQuery("#expense_list").jqGrid('setCaption',"Expense Item(s) for Expense: "+selName).trigger('reloadGrid');   	

		//part payment grid
	        var url = "${createLink(controller:'Project',action:'jq_partproject_list')}"+"?projectid="+ids;
	        jQuery("#partproject_list").jqGrid('setGridParam',{url:url});
	    	jQuery("#partproject_list").jqGrid('setCaption',"Part Payment(s) for Expense: "+selName).trigger('reloadGrid');   	
		
	             }
	                },
	    loadError: function (jqXHR, textStatus, errorThrown) {
		alert('Session timed-out. Please login again!!');
		window.open("${createLinkTo(dir: '')}","_self")		
	    }	                
	    	   
            });
            $("#project_list").jqGrid('filterToolbar', {autosearch: true});
	    $("#project_list").jqGrid('navGrid',"#project_list_pager",{edit:false,add:false,del:false,search:false});
	    $("#project_list").jqGrid('inlineNav',"#project_list_pager",
		    { 
		       edit: false,
		       add: false,
		       save: false,
		       cancel: false,
		    }
	    );
		
	    //custom buttons
            /*$("#project_list").jqGrid('navGrid', "#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager", {caption: "New", buttonicon: "ui-icon-document", onClickButton: NewProject, position: "last", title: "New", cursor: "pointer"});
    	    $("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"Details", buttonicon:"ui-icon-script", onClickButton:details, position: "last", title:"Details", cursor: "pointer"});*/

            <sec:ifAnyGranted roles="ROLE_FINANCE">
		$("#project_list").jqGrid('navGrid', "#project_list_pager").jqGrid('navButtonAdd', "#project_list_pager", {caption: "RejectEAR", buttonicon: "ui-icon-cancel", onClickButton: rejectProject, position: "last", title: "RejectEAR", cursor: "pointer"});
		$("#project_list").jqGrid('navGrid', "#project_list_pager").jqGrid('navButtonAdd', "#project_list_pager", {caption: "RejectERR", buttonicon: "ui-icon-cancel", onClickButton: rejectExpense, position: "last", title: "RejectERR", cursor: "pointer"});
		$("#project_list").jqGrid('navGrid', "#project_list_pager").jqGrid('navButtonAdd', "#project_list_pager", {caption: "RejectCompleteEAR_ERR", buttonicon: "ui-icon-cancel", onClickButton: rejectComplete, position: "last", title: "RejectERR", cursor: "pointer"});
    	    </sec:ifAnyGranted>

            <sec:ifAnyGranted roles="ROLE_ACC_USER">
    		<g:if test="${s_status=='APPROVED_REQUEST'}">
    	    $("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"Advance", buttonicon:"ui-icon-transfer-e-w", onClickButton:advance, position: "last", title:"Issue Advance", cursor: "pointer"});
    	    //$("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"PrintAdvance", buttonicon:"ui-icon-print", onClickButton:printApproval, position: "last", title:"Print Advance Requisition Slip", cursor: "pointer"});
    	    	</g:if>
    		<g:if test="${s_status=='APPROVED_REPORT'}">
	    <!--$("#project_list").jqGrid('navGrid', "#project_list_pager").jqGrid('navButtonAdd', "#project_list_pager", {caption: "Reject", buttonicon: "ui-icon-cancel", onClickButton: rejectProject, position: "last", title: "Reject", cursor: "pointer"});-->
    	    $("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"MarkSettled", buttonicon:"ui-icon-check", onClickButton:markSettled, position: "last", title:"Mark Settled", cursor: "pointer"});
			
			jQuery("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
			   onClickButton : function () {
			   var url = "exportExpenseList";
				jQuery("#project_list").jqGrid('excelExport',{"url":url});
			   }
			});
    	    <!--$("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"PrintReimbursement", buttonicon:"ui-icon-print", onClickButton:printReimbursement, position: "last", title:"Print Expense Reimbursement Form", cursor: "pointer"});-->
    	    $("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"PartPayments", buttonicon:"ui-icon-copy", onClickButton:showChildProjects, position: "last", title:"Part Payments", cursor: "pointer"});
    	    	</g:if>
	    <!--$("#project_list").jqGrid('navGrid', "#project_list_pager").jqGrid('navButtonAdd', "#project_list_pager", {caption: "PrintVoucher", buttonicon: "ui-icon-print", onClickButton: printAdvanceVoucher, position: "last", title: "PrintVoucher", cursor: "pointer"});-->    	    
    	    </sec:ifAnyGranted>

	function showChildProjects() {
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Project',action:'showChildProjects')}"+"?pid="+id;
				$( "#divToShowChildProjects" ).val("");
				$( "#divToShowChildProjects" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogShowChildProjects" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}


	 $( "#dialogShowChildProjects" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});
	
	function markSettled() {
		var answer = confirm("Are you sure?");
		if (!answer){
			return false;
			}
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Project',action:'markSettled')}"+"?projectid="+id;
				$( "#divToPrintReimbursement" ).val("");
				$( "#divToPrintReimbursement" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					jQuery("#project_list").jqGrid().trigger("reloadGrid");
					//$( "#dialogPrintReimbursement" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

           
            function NewProject()
            {
                $("#dialogNewProjectForm").dialog("open");
            }

            $("#dialogNewProjectForm").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#addprojectForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });
            $('#addprojectForm').submit(function()
            {
                var url = "${createLink(controller:'Project',action:'save')}";

                // gather the form data
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    $('#centre').val('');
                    $('#department').val('');
                    $('#category').val('');
                    $('#type').val('');
                    $('#name').val('');
                    $('#description').val('');
                    $('#comments').val('');
                    $('#status').val('');
                    $('#amount').val('');
                    $('#ref').val('');
                    $('#submitter').val('');
                    $('#submitDate').val('');
                    $('#submitComments').val('');
                    $('#creator').val('');
                    $('#updator').val('');
                    $('#submitStatus').val('');
                    jQuery("#project_list").jqGrid().trigger("reloadGrid");
                    $("#dialogNewProjectForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });



		jQuery("#expense_list").jqGrid({
	                
	                    url: "${createLink(controller:'Project',action:'jq_expense_list')}",
	                    
	                    editurl:"${createLink(controller:'Project',action:'jq_edit_expense')}",
	                    
	                    datatype: "json",
	                    colNames: ['CostCenter','Particulars', 'LedgerHead','Amount', 'Deduction','Vendor','BillAvailability','BillNo','BillDate','PaymentMode','Voucher','Status','Ref','Id'], 
			    colModel: [
			    {name: 'costCenter',search:true, editable: false,
				stype:'select', searchoptions: {value:"${':ALL;'+(ics.CostCenter.findAllByStatusIsNull([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}			    
			    },			    
			    {name: 'description',search:true, editable: true},
			    {name: 'ledgerHead', search:true, editable: false,
				stype:'select', searchoptions: {value:"${':ALL;'+(ics.LedgerHead.list([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}			    
			    },
			    {name: 'amount', search:true, editable: true},
			    {name: 'deduction', search:true, editable: false,stype:'select', searchoptions: { value: ':ALL;NO:NO;YES:YES'}},
			    {name: 'invoiceRaisedBy', search:true, editable: true},
			    {name: 'invoiceAvailable', search:true, editable: true,stype:'select', searchoptions: {value:"${':ALL;'+['Available','Not Available','Adjustment against previous bill','Advance against future bill'].collect{it+':'+it}.join(';')}"}},
			    {name: 'invoiceNo', search:true, editable: true},
			    {name: 'invoiceDate', search:true, editable: true,
				searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    			    
			    },
			    {name: 'invoicePaymentMode', search:true, editable: true,stype:'select', searchoptions: { value: ':ALL;CASH:CASH;CHEQUE:CHEQUE;RTGS:RTGS;TRANSFER:TRANSFER'}},
			    {name: 'paymentVoucher', search:true, editable: false,
					formatter:'showlink', 
					formatoptions:{baseLinkUrl:'${createLink(controller:'voucher',action:'showFromExpense',target:'_new')}'}
				},
			    {name: 'status', search:true, editable: false},
			    {name: 'ref', search:true, editable: false},
			    {name:'id',hidden:true}
                            ],
	                    rowNum: 50,
	                    rowList: [5, 10, 20, 30, 40, 50],
	                    pager: '#expense_list_pager',
	                    viewrecords: true,
	                    multiselect: true,
	                    gridview: true,
	                    sortorder: "desc",
	                    width: 1250,
	                    height: "100%",
	                    viewrecords:true,
	                    showPager: true,
	                    caption: "Expense Items List",	                    
				footerrow : true,
				userDataOnFooter : true,							    
	                    loadComplete: function() {
	                        $("#expense_list").jqGrid().setGridParam({datatype: 'json'});
	                    },
			    loadError: function (jqXHR, textStatus, errorThrown) {
				alert('Session timed-out. Please login again!!');
				window.open("${createLinkTo(dir: '')}","_self")		
			    }	                
	                });
	                
	                
	                $("#expense_list").jqGrid('filterToolbar', {autosearch: true});
			     $("#expense_list").jqGrid('navGrid',"#expense_list_pager",{edit:false,add:false,del:true,search:false});
			    $("#expense_list").jqGrid('inlineNav',"#expense_list_pager",
			    { 
			       edit: true,
			       add: false,
			       save: true,
			       cancel: false,
			    }
		    		);
               //$("#expense_list").jqGrid('navGrid', "#expense_list_pager").jqGrid('navButtonAdd', "#expense_list_pager", {caption: "NewExpense", buttonicon: "ui-icon-document", onClickButton: NewExpense, position: "last", title: "NewExpense", cursor: "pointer"});
	                <!--$("#expense_list").jqGrid('navGrid', "#expense_list_pager").jqGrid('navButtonAdd', "#expense_list_pager", {caption: "Reject", buttonicon: "ui-icon-cancel", onClickButton: rejectExpense, position: "last", title: "Reject", cursor: "pointer"});-->
	                $("#expense_list").jqGrid('navGrid', "#expense_list_pager").jqGrid('navButtonAdd', "#expense_list_pager", {caption: "LedgerHead", buttonicon: "ui-icon-note", onClickButton: ledgerHead, position: "last", title: "LedgerHead", cursor: "pointer"});
	                $("#expense_list").jqGrid('navGrid', "#expense_list_pager").jqGrid('navButtonAdd', "#expense_list_pager", {caption: "Deduction", buttonicon: "ui-icon-calculator", onClickButton: deduction, position: "last", title: "Deduction", cursor: "pointer"});
	                $("#expense_list").jqGrid('navGrid', "#expense_list_pager").jqGrid('navButtonAdd', "#expense_list_pager", {caption: "CreateVoucher", buttonicon: "ui-icon-check", onClickButton: payExpense, position: "last", title: "CreateVoucher", cursor: "pointer"});
	                $("#expense_list").jqGrid('navGrid', "#expense_list_pager").jqGrid('navButtonAdd', "#expense_list_pager", {caption: "PrintVoucher", buttonicon: "ui-icon-print", onClickButton: printExpenseVoucher, position: "last", title: "PrintVoucher", cursor: "pointer"});
	               
	function printAdvanceVoucher() {
	 var ids = $('#project_list').jqGrid('getGridParam','selrow');	 
		if(ids) {
		
			var url = "${createLink(controller:'Voucher',action:'printVoucher')}"+"?projectid="+ids;
			
			$( "#divPrintVoucher" ).val("");
			$( "#divPrintVoucher" ).load( url, function(responseTxt,statusTxt,xhr){
			   if(statusTxt=="success")
			    {    
			        
				  $("#dialogPrintVoucher").dialog("open");
			     }
			    if(statusTxt=="error")
			      alert("Error: "+xhr.status+": "+xhr.statusText);
			       
			  });
		}
		else
			alert("Please select the expense item(s)!!");
	}


	function printExpenseVoucher() {
	 var ids = $('#expense_list').jqGrid('getGridParam','selrow');
	 
		if(ids) {
		
			var url = "${createLink(controller:'Voucher',action:'printVoucher')}"+"?expenseid="+ids+"&settlement=true";
			
			$( "#divPrintVoucher" ).val("");
			$( "#divPrintVoucher" ).load( url, function(responseTxt,statusTxt,xhr){
			   if(statusTxt=="success")
			    {    
			        
				  $("#dialogPrintVoucher").dialog("open");
			     }
			    if(statusTxt=="error")
			      alert("Error: "+xhr.status+": "+xhr.statusText);
			       
			  });
		}
		else
			alert("Please select the expense item(s)!!");
	}
	
	function payExpense() {
		var ids = $('#expense_list').jqGrid('getGridParam','selarrrow');
		if(ids != '') {
			var url = "${createLink(controller:'Voucher',action:'payExpense')}"+"?expids="+ids;
			
			$( "#divPayExpense" ).val("");
			$( "#divPayExpense" ).load( url, function(responseTxt,statusTxt,xhr){
			   if(statusTxt=="success")
			    {    
			        
				  $("#dialogPayExpenseForm").dialog("open");
			     }
			    if(statusTxt=="error")
			      alert("Error: "+xhr.status+": "+xhr.statusText);
			       
			  });
		}
		else
			alert("Please select the expense item(s)!!");
	}

            $("#dialogPayExpenseForm").dialog({
                autoOpen: false,
                width:400,
                height:500,
                modal: true,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#payExpenseForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });
            $('#payExpenseForm').submit(function()
            {
                var url = "${createLink(controller:'Voucher',action:'payExpenseSave')}";

                // gather the form data
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    jQuery("#expense_list").jqGrid().trigger("reloadGrid");
                    $("#dialogPayExpenseForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });

	function deduction() {
		var id = $('#expense_list').jqGrid('getGridParam','selrow');
		if(id) {
			$("#dialogDeductionForm").dialog("open");				}
		else
			alert("Please select the expense!!");
	}


	function ledgerHead() {
		var ids = $('#expense_list').jqGrid('getGridParam','selarrrow');
		if(ids!='') {
			$("#dialogLedgerHeadForm").dialog("open");
		}
		else
			alert("Please select the expense!!");
	}

	            $("#dialogLedgerHeadError").dialog({
		                    autoOpen: false,
		                    modal: true,
		                    buttons:
		                            {
		                                "OK": function()
		                                {
		                                    $(this).dialog("close");
		                                },
		                                "Cancel": function() {
		                                    $(this).dialog("close");
		                                }
		                            }
	            });
            

            $("#dialogLedgerHeadForm").dialog({
                autoOpen: false,
                modal: true,
                width:400,
                height:200,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#ledgerHeadForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });
            $('#ledgerHeadForm').submit(function()
            {
                var url = "${createLink(controller:'Project',action:'assignLedgerHead')}";
		var ids = $('#expense_list').jqGrid('getGridParam','selarrrow');
		$('#expidsForLedgerHead').val(ids);
                // gather the form data
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    jQuery("#expense_list").jqGrid().trigger("reloadGrid");
                    $("#dialogLedgerHeadForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });
	

            $("#dialogDeductionForm").dialog({
                autoOpen: false,
                modal: true,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#deductionForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });

            $('#deductionForm').submit(function()
            {
                var url = "${createLink(controller:'Project',action:'calculateDeduction')}";
		//var id = $('#expense_list').jqGrid('getGridParam','selrow');
		var ids = $('#expense_list').jqGrid('getGridParam','selarrrow');

                // gather the form data
                //$('#expidForDeduction').val(id);
                $('#expidsForDeduction').val(ids);
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    jQuery("#expense_list").jqGrid().trigger("reloadGrid");
                    $("#dialogDeductionForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });

	function rejectExpense() {
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#expense_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'project',action:'rejectExpense')}"+"?expenseid="+id
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#expense_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the expense!!");
		} else {
		    return false;
		}
	}
	   
	   
	   
	   
	   function NewExpense()
	            {
	    	 $( "#dialogNewExpensetForm" ).dialog( "open" );
	    		}
	    		
	    		$( "#dialogNewExpensetForm" ).dialog({
	    					autoOpen: false,
	    					height: 500,
	    					width: 600,
	    					modal: true,
	    					
	    					
	    					buttons:
	    					{
	    					"Submit": function() 
	    					{
	    					   $('#expenseForm').submit();
	    					   $( this ).dialog( "close" );
	    					  },
	    					
	    					
	    					"Cancel": function() {
	    					$( this ).dialog( "close" );
	    						}
	    					}
	    					
	    			
	    			});
	    			
	    			
	    			
	    		$('#expenseForm').submit(function()
	    		{									
	    		var url = "${createLink(controller:'Expense',action:'save')}";
	    		var data=$(this).serialize();
	    		$.post(url, data , function(returnData)
	    		{
	                 $('#department').val('');												
	    		 $('#raisedBy').val('');
	    		 $('#type').val('');
	    		 $('#category').val('');
	    		 $('#description').val('');
	    		 $('#amount').val('');
	    		 $('#expenseDate').val('');
	    		 $('#raisedOn').val('');
	    		 $('#status').val('');
	    		 $('#creator').val('');
	    		 $('#updator').val(''); 
	    		 
	             jQuery("#expense_list").jqGrid().trigger("reloadGrid");											  
	    		 
	    		 $("#dialogNewExpensetForm").dialog( "close" );
	    		 // $( "#dialogPrintPaymentReference" ).dialog( "open" );
	    		 })	
	                     return false; // stops browser from doing default submit process
	    		});
            //for date
            $('.datepicker').each(function() {
                $(this).datepicker({
                    dateFormat: 'yy-mm-dd',
                    yearRange: '2015:2050',
                    todayBtn: true,
                    calendarWeeks: true,
                    todayHighlight: true,
                    changeDate: true,
                    changeMonth: true,
                    changeYear: true,
                    onSelect: function(dateText, inst)
                    {

                    }

                });
            });

            function details()
            {
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		if(id) {
			var url = "${createLink(controller:'Project',action:'show')}"+"?id="+id;
			$( "#divProjectDetails" ).val("");
			$( "#divProjectDetails" ).load( url, function(responseTxt,statusTxt,xhr){
			    if(statusTxt=="success")
			    {
				$("#dialogDetailsForm").dialog("open");	
			    }
			    if(statusTxt=="error")
			      alert("Error: "+xhr.status+": "+xhr.statusText);
			  });
		  }
		else
			alert("Please select a row!!");
            }

            $("#dialogDetailsForm").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#detailsForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });
            $('#detailsForm').submit(function()
            {
                var url = "${createLink(controller:'Project',action:'update')}";

                // gather the form data
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    $("#detailsForm")[0].reset();
                    jQuery("#project_list").jqGrid().trigger("reloadGrid");
                    $("#dialogDetailsForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });
            var pid=0;
            function advance()
            {
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		pid=id;
		if(id) {
			var url = "${createLink(controller:'Project',action:'advance')}"+"?id="+id;
			
			$( "#divProjectAdvance" ).val("");
			$( "#divProjectAdvance" ).load( url, function(responseTxt,statusTxt,xhr){
			    if(responseTxt=="error")
			    {
			    $("#dialogAdvanceError").dialog("open");
			    }
			   else if(statusTxt=="success")
			    {    
			        
				  $("#dialogAdvanceForm").dialog("open");
			     }
			    if(statusTxt=="error")
			      alert("Error: "+xhr.status+": "+xhr.statusText);
			       
			  });
			  
			  
		  }
		else
			alert("Please select a row!!");
            }
            
          
	            $("#dialogAdvanceError").dialog({
		                    autoOpen: false,
		                    modal: true,
		                    buttons:
		                            {
		                                "OK": function()
		                                {
		                                    $(this).dialog("close");
		                                },
		                                "Cancel": function() {
		                                    $(this).dialog("close");
		                                }
		                            }
	            });
            

            $("#dialogAdvanceForm").dialog({
                autoOpen: false,
                modal: true,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#advanceForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });
           
            function printApprovalAfterAdvance()
            
            {
             $( "#dialogPrintApproval" ).dialog( "open" );
          
	     		
	     				var url = "${createLink(controller:'Project',action:'printApproval')}"+"?projectid="+pid;
	     				$( "#divToPrintApproval" ).val("");
	     				$( "#divToPrintApproval" ).load( url, function(responseTxt,statusTxt,xhr){
	     				    if(statusTxt=="success")
	     				    {
	     				       pid=0;
	     					$( "#dialogPrintApproval" ).dialog( "open" );	
	     				    }
	     				    if(statusTxt=="error")
	     				      alert("Error: "+xhr.status+": "+xhr.statusText);
	     				  });
	     	
            
            }

	function printApproval() {
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Project',action:'printApproval')}"+"?projectid="+id;
				$( "#divToPrintApproval" ).val("");
				$( "#divToPrintApproval" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintApproval" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

	function printReimbursement() {
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Project',action:'printReimbursement')}"+"?projectid="+id;
				$( "#divToPrintReimbursement" ).val("");
				$( "#divToPrintReimbursement" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintReimbursement" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

	 $( "#dialogPrintApproval" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintApproval').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});

	 $( "#dialogPrintReimbursement" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintReimbursement').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});
	
	$( "#advanceAmountIssued" ).change(function() 
	{
	  //alert( "Handler for .change() called." );
	   $( "#advanceIssued" ).show();
	  
         });
		
	 
       $("#advanceForm").submit(function(e){
	     var advAmountReq=0;
	     if($('#advanceAmountReq').val())
	     var temp = $('#advanceAmountReq').val().replace(/,/g, "");
	    
	     advAmountReq= parseFloat(temp);
	     var advanceAmountIssued=0;
	     
	     if($('#advanceAmountIssued').val()==''){
	     alert("Please enter  the valid Advance Amount !!! ");
	     return false }
	     
	     else {
	     	advanceAmountIssued=parseFloat($('#advanceAmountIssued').val());}
	
	     if(advanceAmountIssued > advAmountReq)
	     {
	     alert("Advance amount issued should be smaller than or equal to requested amount !!")
	      return false;
	    
	     }
	     else if(!confirmComplete())
	     {
	      return false 
	      }
	      else
	      {
	      var url = "${createLink(controller:'Project',action:'issueAdvance')}";
  
             // gather the form data
             var data = $(this).serialize();
             // post data
             $.post(url, data, function(returnData) {
             // $("#advanceForm")[0].reset();
             jQuery("#project_list").jqGrid().trigger("reloadGrid");
             $("#dialogAdvanceForm").dialog("close");
             printApprovalAfterAdvance();
               })
             return false; // stops browser from doing default submit process
	      }
	         
        });      
		
	function rejectProject() {
		var ids = $('#project_list').jqGrid('getGridParam','selarrrow');
		if(ids) {
				$( "#dialogRejectProject" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}

	$('#formRejectProject').submit(function(){

	      var url = "${createLink(controller:'Project',action:'saveRejectProject')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  $('#projectId').val('');
			  $('#review3Comments').val('');
			  
			  jQuery("#project_list").jqGrid().trigger("reloadGrid");			  
	      })

	      return false; // stops browser from doing default submit process
	});


		$( "#dialogRejectProject" ).dialog({
			autoOpen: false,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#projectId").val($('#project_list').jqGrid('getGridParam','selrow'));
					    $("#formRejectProject").submit();					    
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	function rejectComplete() {
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		if(id) {
			var answer = confirm("Are you sure?");
			if (!answer){
				return false;
				}

		      var url = "${createLink(controller:'Project',action:'saveCompleteReject')}"+"?projectid="+id;

		      // post data
		      $.post(url , function(returnData){
				  alert(returnData.message);
				  jQuery("#project_list").jqGrid().trigger("reloadGrid");			  
				  jQuery("#expense_list").jqGrid().trigger("reloadGrid");			  
		      })

		      return false; // stops browser from doing default submit process
		}
		else
			alert("Please select a row!!");

	}

	function rejectExpense() {
		var ids = $('#project_list').jqGrid('getGridParam','selarrrow');
		if(ids) {
				$( "#dialogRejectExpense" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}

	$('#formRejectExpense').submit(function(){

	      var url = "${createLink(controller:'Project',action:'saveRejectExpense')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  $('#projectId').val('');
			  $('#review3Comments').val('');
			  
			  jQuery("#project_list").jqGrid().trigger("reloadGrid");			  
	      })

	      return false; // stops browser from doing default submit process
	});


		$( "#dialogRejectExpense" ).dialog({
			autoOpen: false,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#err_projectId").val($('#project_list').jqGrid('getGridParam','selrow'));
					    $("#formRejectExpense").submit();					    
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	$("#dialogPrintVoucher").dialog({
	                autoOpen: false,
	                modal: true,
	                width:800,
		        height:500,
	    		buttons: {
				   "Print": function() {
				   $('#dialogPrintVoucher').printArea();
			           $( this ).dialog( "close" );
		                   },
	                            "Cancel": function() {
	                                $(this).dialog("close");
	                            }
	                        }
            });

        });
    </script>
</body>
</html>

