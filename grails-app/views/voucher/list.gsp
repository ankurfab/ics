
<%@ page import="ics.Voucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="voucher.list" default="Voucher List" /></title>
	<r:require module="jqui" />
	<r:require module="grid" />
	<r:require module="printarea" />
        <r:require module="jqbarcode" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="voucher.new" default="New Voucher" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="createPayment">New Payment Voucher</g:link></span>
            <span class="menuButton"><g:link class="create" action="createReceipt">New Receipt Voucher</g:link></span>
            <span class="menuButton"><g:link class="create" action="createContra">New Contra Voucher</g:link></span>
            <span class="menuButton"><g:link class="create" action="createJournal">New Journal Voucher</g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="voucher_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="voucher_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

    <div id="dialogReadyForm" title="Ready">
        <g:form name="readyForm" controller="voucher" action="ready" method="POST">
            <g:render template="/voucher/ready" />
        </g:form>
    </div> 

    <div id="dialogCollectedForm" title="Collected">
        <g:form name="collectedForm" controller="voucher" action="collected" method="POST">
            <g:render template="/voucher/collected" />
        </g:form>
    </div>
    
    <div id="dialogPrintVoucher" title="Print Voucher">
	<g:form name="printVoucherForm" method="POST">
	<div id="divPrintVoucher"></div> 
	</g:form>
   </div>     


<script>
  $(document).ready(function () {
    jQuery("#voucher_list").jqGrid({
      url:'jq_voucher_list?overdue='+'${overdue}',
      datatype: "json",
      colNames:['VoucherDate','VoucherNo','DepartmentCode','Description','Deposit(Dr)','Withdrawal(Cr)','Type','From','To','Amount','Debit/Credit','Ready','InstrumentNo','InstrumentDate','BankName','BankBranch','Collected','Entered','RefNo','Id'],
      colModel:[
	{name:'voucherDate',search:true,
		searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    			    
	},
	{name:'voucherNo',search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'Voucher',action:'show')}'}
        },         
	{name:'departmentCode',search:true,
		stype:'select', searchoptions: {value:"${':ALL;'+(ics.CostCenter.findAllByStatusIsNull([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}			    
	},
	{name:'description',search:true},
	{name:'amountSettled',search:true},
	{name:'amount',search:true},
	{name:'type',search:true,stype:'select', searchoptions: {value:"${':ALL;'+['Payment','Receipt','Journal','Contra'].collect{it+':'+it}.join(';')}"}},
	{name:'ledger',search:true},
	{name:'anotherLedger',search:true},
	{name:'amount',search:true},
	{name:'debit',search:true,stype:'select', searchoptions: { value: ':ALL;Cr:Cr;Dr:Dr'}},
	{name:'instrumentReady',search:true,stype:'select', searchoptions: { value: ':ALL;NO:NO;YES:YES'}},
	{name:'instrumentNo',search:true},
	{name:'instrumentDate',search:true},
	{name:'bankName',search:true},
	{name:'bankBranch',search:true},
	{name:'instrumentCollected',search:true,stype:'select', searchoptions: { value: ':ALL;NO:NO;YES:YES'}},
	{name:'dataCaptured',search:true,stype:'select', searchoptions: { value: ':ALL;NO:NO;YES:YES'}},
	{name:'refNo',search:true,
			formatter:'showlink', 
			formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'Voucher',action:'showRef')}'}
	},	
	{name:'id',hidden:true}
     ],
     
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#voucher_list_pager',
    viewrecords: true,
    sortname: "lastUpdated",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Voucher List"
    });
  $("#voucher_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#voucher_list").jqGrid('navGrid', "#voucher_list_pager", {edit: false, add: false, del: false, search: true});
    jQuery("#voucher_list").jqGrid('navGrid',"#voucher_list_pager").jqGrid('navButtonAdd',"#voucher_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
    onClickButton : function () { 
    var query = 'jq_voucher_list?eid='+$('#event').val();            
    jQuery("#voucher_list").jqGrid('excelExport',{"url":query});
         }
      });

    $("#voucher_list").jqGrid('navGrid', "#voucher_list_pager").jqGrid('navButtonAdd', "#voucher_list_pager", {caption: "PrintVoucher", buttonicon: "ui-icon-check", onClickButton: printVoucher, position: "last", title: "PrintVoucher", cursor: "pointer"});
    $("#voucher_list").jqGrid('navGrid',"#voucher_list_pager").jqGrid('navButtonAdd',"#voucher_list_pager",{caption:"Ready", buttonicon:"ui-icon-lightbulb", onClickButton:ready, position: "last", title:"Ready", cursor: "pointer"});
    $("#voucher_list").jqGrid('navGrid',"#voucher_list_pager").jqGrid('navButtonAdd',"#voucher_list_pager",{caption:"Collected", buttonicon:"ui-icon-key", onClickButton:collected, position: "last", title:"Collected", cursor: "pointer"});
    $("#voucher_list").jqGrid('navGrid',"#voucher_list_pager").jqGrid('navButtonAdd',"#voucher_list_pager",{caption:"Entered", buttonicon:"ui-icon-extlink", onClickButton:entered, position: "last", title:"Entered", cursor: "pointer"});
    <sec:ifAnyGranted roles="ROLE_FINANCE">
	    $("#voucher_list").jqGrid('navGrid',"#voucher_list_pager").jqGrid('navButtonAdd',"#voucher_list_pager",{caption:"BounceCheque", buttonicon:"ui-icon-check", onClickButton:bounceCheque, position: "last", title:"BounceCheque", cursor: "pointer"});
    </sec:ifAnyGranted>

    function ready() {
	var id = $('#voucher_list').jqGrid('getGridParam','selrow');
	if(id) {
		$("#dialogReadyForm").dialog("open");				}
	else
		alert("Please select the voucher!!");
    }

    function collected() {
	var id = $('#voucher_list').jqGrid('getGridParam','selrow');
	if(id) {
		$("#dialogCollectedForm").dialog("open");				}
	else
		alert("Please select the voucher!!");
    }

            $("#dialogReadyForm").dialog({
                autoOpen: false,
                modal: true,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#readyForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });

            $('#readyForm').submit(function()
            {
                var url = "${createLink(controller:'Voucher',action:'ready')}";
		var id = $('#voucher_list').jqGrid('getGridParam','selrow');

                // gather the form data
                $('#voucheridForReady').val(id);
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    jQuery("#voucher_list").jqGrid().trigger("reloadGrid");
                    $("#dialogReadyForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });
      
            $("#dialogCollectedForm").dialog({
                autoOpen: false,
                modal: true,
                buttons:
                        {
                            "Submit": function()
                            {
                                $('#collectedForm').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
            });

            $('#collectedForm').submit(function()
            {
                var url = "${createLink(controller:'Voucher',action:'collected')}";
		var id = $('#voucher_list').jqGrid('getGridParam','selrow');

                // gather the form data
                $('#voucheridForCollected').val(id);
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    jQuery("#voucher_list").jqGrid().trigger("reloadGrid");
                    $("#dialogCollectedForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });

 function bounceCheque() {
	var answer = confirm("Are you sure?");
		if (!answer){
			return false;
			}
		var id = $('#voucher_list').jqGrid('getGridParam','selrow');
		if(id) {
			var url = "${createLink(controller:'Voucher',action:'bounceCheque')}"+"?id="+id;
			$.getJSON(url, {}, function(data) {
				jQuery("#voucher_list").jqGrid().trigger("reloadGrid");
			    });
		}
		else
			alert("Please select a row!!");
	}
 function printVoucher()
	  {
	 
	 var ids = $('#voucher_list').jqGrid('getGridParam','selrow');
	 
		if(ids) {
		
			var url = "${createLink(controller:'Voucher',action:'printVoucher')}"+"?id="+ids;
			
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
             

	function entered() {
		var answer = confirm("Are you sure?");
		if (!answer){
			return false;
			}
		var id = $('#voucher_list').jqGrid('getGridParam','selrow');
		if(id) {
			var url = "${createLink(controller:'Voucher',action:'dataEntered')}"+"?id="+id;
			$.getJSON(url, {}, function(data) {
				jQuery("#voucher_list").jqGrid().trigger("reloadGrid");
			    });
		}
		else
			alert("Please select a row!!");
	}
    
    });

</script>


    </body>
</html>
