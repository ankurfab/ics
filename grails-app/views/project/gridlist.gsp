<%@ page import="ics.Project" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>EMS</title>
	<r:require module="grid" />
	<r:require module="ajaxform"/>
	<r:require module="printarea" />
</head>

<body>
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
        <g:form name="advanceForm" controller="project" action="update" method="POST">
            <div id="divProjectAdvance"></div>
        </g:form>
    </div> 

	<div id="dialogPrintApproval" title="Print Approval">
		<div id="divToPrintApproval"></div>
	</div>

	<div id="dialogPrintReimbursement" title="Print Reimbursement">
		<div id="divToPrintReimbursement"></div>
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
            
           
      
     <table id="expense_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="expense_list_pager" class="scroll" style="text-align:center;">
    </div>
    
    <script type="text/javascript">
        $(document).ready(function() {
            jQuery("#project_list").jqGrid({
                url: 'jq_project_list',
                editurl: 'jq_edit_project',
		      postData:{
			status:function(){return "${status?:''}";},
			},
                datatype: "json",
                align: 'Center',
                colNames: ['CostCenter','Name', 'Description', 'Category', 'Type', 'Amount', 'Expected Start Date', 'Priority','Status','Reference', 'Id'],
                colModel: [
                    {name: 'costCenter', search: true, editable: false},
                    {name: 'name', search: true, editable: true},
                    {name: 'description', search: true, editable: true},
                    {name: 'category', search: true, editable: true},
                    {name: 'type', search: true, editable: true},
                    {name: 'amount', search: true, editable: true},
                    {name: 'expectedStartDate', search: true, editable: true},
                    {name: 'priority', search: true, editable: true},
                    {name: 'status', search: true, editable: true},
                    {name: 'ref', search: true, editable: true},
                    {name: 'id', hidden: true}
                ],
                rowNum: 10,
                rowList: [5, 10, 20, 30, 40, 50],
                pager: '#project_list_pager',
                viewrecords: true,
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
	        var url = "${createLink(controller:'Expense',action:'jq_expense_list')}"+"?projectid="+ids;
	        jQuery("#expense_list").jqGrid('setGridParam',{url:url});
	    	var editurl = "${createLink(controller:'Expense',action:'jq_edit_expense')}"+"?projectid="+ids;
	    	jQuery("#expense_list").jqGrid('setGridParam',{editurl:url});
	    	jQuery("#expense_list").jqGrid('setCaption',"Expense(s) for Project: "+selName).trigger('reloadGrid');   	
	             }
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
            <sec:ifAnyGranted roles="ROLE_ACC_USER">
    	    $("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"Advance", buttonicon:"ui-icon-transfer-e-w", onClickButton:advance, position: "last", title:"Issue Advance", cursor: "pointer"});
    	    $("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"PrintApproval", buttonicon:"ui-icon-print", onClickButton:printApproval, position: "last", title:"Print Expense Approval Form", cursor: "pointer"});
    	    $("#project_list").jqGrid('navGrid',"#project_list_pager").jqGrid('navButtonAdd',"#project_list_pager",{caption:"PrintReimbursement", buttonicon:"ui-icon-print", onClickButton:printReimbursement, position: "last", title:"Print Expense Reimbursement Form", cursor: "pointer"});
    	    </sec:ifAnyGranted>


           
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
	                
	                    url: "${createLink(controller:'Expense',action:'jq_expense_list')}",
	                    
	                    editurl:"${createLink(controller:'Expense',action:'jq_edit_expense')}",
	                    
	                    datatype: "json",
	                    colNames: ['Department', 'RaisedBy', 'Type', 'Category', 'Description', 'Amount', 'Status','Id'], 
			    colModel: [
			    {name: 'department',search:true, editable: true},
			    {name: 'raisedBy', formatter: 'showlink', formatoptions: {baseLinkUrl: 'show'}, search:true, editable: true},
			    {name: 'type', search:true, editable: true},
			    {name: 'category', search:true, editable: true},
			    {name: 'description',search:true, editable: true},
			    {name: 'amount', search:true, editable: true},
			    {name: 'status', search:true, editable: true},
			    {name:'id',hidden:true}
                            ],
	                    rowNum: 5,
	                    rowList: [5, 10, 20, 30, 40, 50, 100, 150, 200],
	                    pager: '#expense_list_pager',
	                    viewrecords: true,
	                    multiselect: true,
	                    gridview: true,
	                    sortorder: "desc",
	                    width: 1250,
	                    height: "100%",
	                    viewrecords:true,
	                    showPager: true,
	                    caption: "Expense Reimbursement Details List",
	                    
	                    loadComplete: function() {
	                        $("#expense_list").jqGrid().setGridParam({datatype: 'json'});
	                    }
	                });
	                
	                
	                $("#expense_list").jqGrid('filterToolbar', {autosearch: true});
	                $("#expense_list").jqGrid('navGrid', "#expense_list_pager").jqGrid('navButtonAdd', "#expense_list_pager", {caption: "NewExpense", buttonicon: "ui-icon-document", onClickButton: NewExpense, position: "last", title: "NewExpense", cursor: "pointer"});
	    	              $("#expense_list").jqGrid('navGrid', "#expense_list_pager", {edit: true, add: true, del: true, search: true}).navButtonAdd('#pager',
	    	              {
	    	 	       caption:"Add", 
	    	 	       buttonicon:"ui-icon-add", 
	    	 	       onClickButton: function()
	    	 	       { 
	    	 	         alert("Adding Row");
	    	 	       }
	    	 	       }, 
	    	 	       {
	    	 	       caption:"Del", 
	    	 	       buttonicon:"ui-icon-del", 
	    	 	       onClickButton: function(){ 
	    	 	       alert("Deleting Row");
	    	 	       
	    	 	       }, 
	    	 	       position:"last"
	               });
	               
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

            function advance()
            {
		var id = $('#project_list').jqGrid('getGridParam','selrow');
		if(id) {
			var url = "${createLink(controller:'Project',action:'advance')}"+"?id="+id;
			$( "#divProjectAdvance" ).val("");
			$( "#divProjectAdvance" ).load( url, function(responseTxt,statusTxt,xhr){
			    if(statusTxt=="success")
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
            $('#advanceForm').submit(function()
            {
                var url = "${createLink(controller:'Project',action:'update')}";

                // gather the form data
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData) {
                    $("#advanceForm")[0].reset();
                    jQuery("#project_list").jqGrid().trigger("reloadGrid");
                    $("#dialogAdvanceForm").dialog("close");
                })
                return false; // stops browser from doing default submit process
            
            });

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

        });
    </script>
</body>
</html>

