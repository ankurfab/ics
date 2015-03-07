<%@ page import="ics.Expense" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>List of Expenses</title>

    <r:require module="grid" />
</head>
<body> 
    
      <div class="nav" role="navigation">
      
       <ul>
       <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
       <li></li>
      </ul>
      </div>
    
    <div id="dialogNewExpensetForm" title="Add New Expense">
     
     <g:form name="expenseForm" controller="expense" action="save" method="POST"> 
     
        <g:render template="/expense/addexpense" />
       
    </g:form> 
    </div>
    <!-- table tag will hold our grid -->
    <table id="expense_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
    <!-- pager will hold our paginator -->
    <div id="expense_list_pager" class="scroll" style="text-align:center;">
    </div>
    
    <script type="text/javascript">
        $(document).ready(function() {
            jQuery("#expense_list").jqGrid({
            
                url: 'jq_expense_list',
                
                editurl:'jq_edit_expense',
                
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
                rowNum: 10,
                rowList: [5, 10, 20, 30, 40, 50, 100, 150, 200],
                pager: '#expense_list_pager',
                viewrecords: true,
                multiselect: true,
                gridview: true,
                sortorder: "desc",
                width: 958,
                height: "100%",
                viewrecords:true,
                showPager: true,
                caption: "Expense List",
                
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
		 alert("Welcome");
		 $("#dialogNewExpensetForm").dialog( "close" );
		 // $( "#dialogPrintPaymentReference" ).dialog( "open" );
		 })	
                 return false; // stops browser from doing default submit process
		});
		
		   //for date
		   $('.datepicker').each(function() {
		        $(this).datepicker({
		        dateFormat: 'dd-mm-yy',
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
        

    });
    
    </script>
</body>
</html>
