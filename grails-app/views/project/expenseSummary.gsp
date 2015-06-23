
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Expense Summary</title>
	<r:require module="grid" />

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">

            <div>
		<!-- table tag will hold our grid -->
		<table id="project_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="project_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="expense_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="expense_list_pager" class="scroll" style="text-align:center;"></div>

	    </div>
        </div>


<script>
  $(document).ready(function () {
            jQuery("#project_list").jqGrid({
                url: 'jq_project_list',
                datatype: "json",
                align: 'Center',
                colNames: ['CostCenter','Name', 'Description', 'SubmitDate','Amount', 'Requested Advance Amount','Issued Advance Amount','Type','Voucher','SettleDate','SettleAmount','Status','Reference', 'Id'],
                colModel: [
                    {name: 'costCenter', search: false, editable: false
	                    //,stype:'select', searchoptions: {value:"${':ALL;'+(ics.CostCenter.findAllByStatusIsNull([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}
	                    },
                    {name: 'name', search: true, editable: true},
                    {name: 'description', search: true, editable: true},
                    {name: 'submitDate', search: true, editable: true,
				searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    
                    	},
                    {name: 'amount', search: true, editable: true},
                    {name: 'advanceAmount', search: true, editable: true},
                    {name: 'advanceAmountIssued', search: true, editable: true,stype:'select', searchoptions: { value: 'ALL:ALL;NO:NO;YES:YES'}},
                    {name: 'type', search: true, editable: true,stype:'select', searchoptions: { value: ':ALL;NORMAL:NORMAL;PARTPAYMENT:PARTPAYMENT;CREDIT:CREDIT'}},
                    {name: 'advancePaymentVoucher', search: true, editable: true},
                    {name: 'settleDate', search: true, editable: false,stype:'select', searchoptions: { value: ':ALL;YES:YES;NO:NO'}},
                    {name: 'settleAmount', search: true, editable: false},
		    {name: 'status', search: true, editable: true,stype:'select', searchoptions: {value:"${':ALL;'+['SETTLED_REPORT','REJECTED_REPORT','APPROVED_REPORT','SUBMITTED_REPORT','DRAFT_REPORT','DRAFT_REQUEST','APPROVED_REQUEST','REJECTED_REQUEST','SUBMITTED_REQUEST','ESCALATED_REQUEST'].collect{it+':'+it}.join(';')}"}},                    
                    {name: 'ref', search: true, editable: true},
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
 		onSelectRow: function(ids) { 
	    	   if(ids!='new_row')
	    	          { 
	        var selName = jQuery('#project_list').jqGrid('getCell', ids, 'name'); 
	        var url = "${createLink(controller:'Project',action:'jq_expense_list')}"+"?projectid="+ids;
	        jQuery("#expense_list").jqGrid('setGridParam',{url:url});
	    	jQuery("#expense_list").jqGrid('setCaption',"Expense Item(s) for Expense: "+selName).trigger('reloadGrid');   	

		
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

		jQuery("#expense_list").jqGrid({
	                
	                    url: "${createLink(controller:'Project',action:'jq_expense_list')}",
	                    	                    
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
			    {name: 'invoiceAvailable', search:true, editable: true,
			    	edittype:"select",editoptions: {value:"${['Available','Not Available','Adjustment against previous bill','Advance against future bill'].collect{it+':'+it}.join(';')}"},
			    	stype:'select', searchoptions: {value:"${':ALL;'+['Available','Not Available','Adjustment against previous bill','Advance against future bill'].collect{it+':'+it}.join(';')}"}},
			    {name: 'invoiceNo', search:true, editable: true},
			    {name: 'invoiceDate', search:true, editable: true,
				searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    			    
			    },
			    {name: 'invoicePaymentMode', search:true, editable: true,
			    	edittype:"select",editoptions: { value: 'CASH:CASH;CHEQUE:CHEQUE;RTGS:RTGS;TRANSFER:TRANSFER'},
			    	stype:'select', searchoptions: { value: ':ALL;CASH:CASH;CHEQUE:CHEQUE;RTGS:RTGS;TRANSFER:TRANSFER'}},
			    {name: 'paymentVoucher', search:true, editable: false},
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
			     $("#expense_list").jqGrid('navGrid',"#expense_list_pager",{edit:false,add:false,del:false,search:false});
			    $("#expense_list").jqGrid('inlineNav',"#expense_list_pager",
			    { 
			       edit: false,
			       add: false,
			       save: false,
			       cancel: false,
			    }
		    		);

    
    });

</script>


    </body>
</html>
