
<%@ page import="ics.IndividualDepartment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualDepartment.list" default="Staff List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="qtip" />
    </head>
    <body>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

	<style>
		.lex {
		    color: green;
		    text-decoration: underline;
		}	
	</style>

	<script>
	function qTip(node) {
	    var url = node.attr("href");
	    node.qtip({
		content: {
		    text: "loading...",
		    ajax: {
			url: url,
			type: 'post',
			data: { html: 'test' }
		    }
		},
		show: {
		            ready: true // Show it immediately
        }
	    });
	}
	</script>
			
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="payroll">Payroll</g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="individualDepartment_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="individualDepartment_list_pager" class="scroll" style="text-align:center;"></div>
			<!--<input class="menuButton" type="BUTTON" id="btnSMS_IndividualDepartmentList" value="SMS" gridName="#individualDepartment_list" entityName="IndividualDepartment"/>
			<input class="menuButton" type="BUTTON" id="btnEMAIL_IndividualDepartmentList" value="EMAIL" gridName="#individualDepartment_list" entityName="IndividualDepartment"/>-->
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="leave_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="leave_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="salary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="salary_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="loan_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="loan_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="loanrecord_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="loanrecord_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#individualDepartment_list").jqGrid({
      url:'jq_individualDepartment_list',
      editurl:'jq_edit_individualDepartment',
      datatype: "json",
      colNames:['Name','Since','Till','Status','Comments','Salary','AccNo','AccRef','Department','iid','Id'],
      colModel:[
	{name:'name', search:true, editable: true, editrules:{required:true},
			formatter:editLink 

	},
	{name:'since', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'till', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'status', search:true, editable: true, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Status--;ACTIVE:ACTIVE;INACTIVE:INACTIVE'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;ACTIVE:ACTIVE;INACTIVE:INACTIVE'}
	},
	{name:'comments', search:true, editable: true, editrules:{required:false}},
	{name:'salary', search:true, editable: true, editrules:{required:false,integer:true}},
	{name:'accNo', search:true, editable: true, editrules:{required:false}},
	{name:'accRef', search:true, editable: true, editrules:{required:false}},
	{name:'department.id', search:true, editable: true, editrules:{required:true},
		edittype:"select",
		editoptions:{value:"${departments?.collect{it.id+':'+it.toString()}?.join(';')}"},
		stype:'select', searchoptions: { value: "${':--Please Select Department--;'+(departments?.collect{it.id+':'+it.toString()}?.join(';'))}"}
	},	
	{name:'individual.id',hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#individualDepartment_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Staff List",
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
		var selName = jQuery('#individualDepartment_list').jqGrid('getCell', ids, 'name');
		jQuery("#leave_list").jqGrid('setGridParam',{url:"jq_leave_list?individualDepartmentid="+ids});
		jQuery("#leave_list").jqGrid('setGridParam',{editurl:"jq_edit_leave?individualDepartment.id="+ids});
		jQuery("#leave_list").jqGrid('setCaption',"Leave Record for Staff: "+selName).trigger('reloadGrid');   	
		jQuery("#salary_list").jqGrid('setGridParam',{url:"jq_salary_list?individualDepartmentid="+ids});    	
		//jQuery("#salary_list").jqGrid('setGridParam',{editurl:"jq_edit_salary?individualDepartment.id="+ids});    	
		jQuery("#salary_list").jqGrid('setCaption',"Salary Record for Staff: "+selName).trigger('reloadGrid');   	
		jQuery("#loan_list").jqGrid('setGridParam',{url:"jq_loan_list?individualDepartmentid="+ids});    	
		jQuery("#loan_list").jqGrid('setGridParam',{editurl:"jq_edit_loan?individualDepartment.id="+ids});    	
		jQuery("#loan_list").jqGrid('setCaption',"Loan(s) for Staff: "+selName).trigger('reloadGrid');   	
		jQuery("#loanrecord_list").jqGrid('setGridParam',{url:"jq_loanrecord_list?individualDepartmentid="+ids});    	
		//jQuery("#loanrecord_list").jqGrid('setGridParam',{editurl:"jq_edit_loanrecord?individualDepartment.id="+ids});    	
		jQuery("#loanrecord_list").jqGrid('setCaption',"Loan Record(s) for Staff: "+selName).trigger('reloadGrid');   	
    		}
    	}    
    });
    $("#individualDepartment_list").jqGrid('filterToolbar',{autosearch:true});
    $("#individualDepartment_list").jqGrid('navGrid',"#individualDepartment_list_pager",{edit:false,add:false,del:true,search:false});
    $("#individualDepartment_list").jqGrid('inlineNav',"#individualDepartment_list_pager");
    $("#individualDepartment_list").jqGrid('navGrid',"#individualDepartment_list_pager").jqGrid('navButtonAdd',"#individualDepartment_list_pager",{caption:"Salary EAR", buttonicon:"ui-icon-document", onClickButton:salaryEAR, position: "last", title:"Salary EAR", cursor: "pointer"});

    jQuery("#leave_list").jqGrid({
      url:'jq_leave_list',
      editurl:'jq_edit_leave',
      datatype: "json",
      colNames:['Name','Date From','Date Till','Status','Comments','Id'],
      colModel:[
	{name:'name', search:true, editable: false},
	{name:'dateFrom', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'dateTill', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'status', search:true, editable: true, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Status--;APPLIED:APPLIED;WITHDRAWN:WITHDRAWN;APPROVED:APPROVED;REJECTED:REJECTED'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;APPLIED:APPLIED;WITHDRAWN:WITHDRAWN;APPROVED:APPROVED;REJECTED:REJECTED'}
	},
	{name:'comments', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#leave_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Leave Record(s)"
    });
    $("#leave_list").jqGrid('filterToolbar',{autosearch:true});
    $("#leave_list").jqGrid('navGrid',"#leave_list_pager",{edit:false,add:false,del:false,search:false});
    $("#leave_list").jqGrid('inlineNav',"#leave_list_pager");

    jQuery("#salary_list").jqGrid({
      url:'jq_salary_list',
      editurl:'jq_edit_salary',
      datatype: "json",
      colNames:['Name','Date Paid','Amount Paid','Payment Details','Comments','Id'],
      colModel:[
	{name:'name', search:true, editable: false},
	{name:'datePaid', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'amountPaid', search:true, editable: true},
	{name:'paymentDetails', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#salary_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Salary Record(s)"
    });
    $("#salary_list").jqGrid('filterToolbar',{autosearch:true});
    $("#salary_list").jqGrid('navGrid',"#salary_list_pager",{edit:false,add:false,del:false,search:false});
    $("#salary_list").jqGrid('inlineNav',"#salary_list_pager");


    jQuery("#loan_list").jqGrid({
      url:'jq_loan_list',
      editurl:'jq_edit_loan',
      datatype: "json",
      colNames:['Name','Date','Amount','Installments','RefNo','Comments','Status','Id'],
      colModel:[
	{name:'name', search:true, editable: false},
	{name:'loanDate', search:true, editable: true,editrules:{required:true},
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'amount', search:true, editable: true,editrules:{required:true,integer:true}},
	{name:'numInstallments', search:true, editable: true,editrules:{required:true,integer:true}},
	{name:'accoutsReceiptNo', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'status', search:true, editable: true,
		edittype:"select",editoptions:{value:"${':--Please Select Status--;APPLIED:APPLIED;PROCESSED:PROCESSED;OPEN:OPEN;CLOSED:CLOSED'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;APPLIED:APPLIED;PROCESSED:PROCESSED;OPEN:OPEN;CLOSED:CLOSED'}
	},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50],
    pager: '#loan_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Loan(s)"
    });
    $("#loan_list").jqGrid('filterToolbar',{autosearch:true});
    $("#loan_list").jqGrid('navGrid',"#loan_list_pager",{edit:false,add:false,del:false,search:false});
    $("#loan_list").jqGrid('inlineNav',"#loan_list_pager",
	    { 
	       edit: true,
	       add: true,
	       save: true,
	       cancel: true,
	    });
    $("#loan_list").jqGrid('navGrid',"#loan_list_pager").jqGrid('navButtonAdd',"#loan_list_pager",{caption:"Loan EAR", buttonicon:"ui-icon-document", onClickButton:loanEAR, position: "last", title:"Loan EAR", cursor: "pointer"});
    
    jQuery("#loanrecord_list").jqGrid({
      url:'jq_loanrecord_list',
      datatype: "json",
      colNames:['Name','Date','Amount','Details','Comments','Status','Id'],
      colModel:[
	{name:'name', search:true, editable: false},
	{name:'voucherdate', search:true, editable: true},
	{name:'amount', search:true, editable: true},
	{name:'details', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'status', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#loanrecord_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Loan Payment Record(s)"
    });
    $("#loanrecord_list").jqGrid('filterToolbar',{autosearch:true});
    $("#loanrecord_list").jqGrid('navGrid',"#loanrecord_list_pager",{edit:false,add:false,del:false,search:false});

        function editLink(cellValue, options, rowdata, action)
        {
            var url = "${createLink(controller:'Individual',action:'show')}"+"?id="+rowdata[9];
            if(cellValue)
            	return "<a href='"+url+"' target='_new'>"+cellValue+"</a>";
            else
            	return ''
        }

	    $('.lex').on('mouseover', function() {
		var _self = $(this);
		qTip(_self);
	    });
	    $('a.lex').click(function(e) {
	        e.preventDefault();
	        //do other stuff when a click happens
		});

	function salaryEAR() {
		var answer = confirm("If you haven't selected any record then Salary EAR would be processed for all! Are you sure?");
		if (!answer){
			return false;
			}
		var id = $('#individualDepartment_list').jqGrid('getGridParam','selrow');
		var url = "${createLink(controller:'IndividualDepartment',action:'salaryEAR')}"+"?indDepid="+id;
		$.getJSON(url, {}, function(data) {
			alert(data.message);
		    });
	}

	function loanEAR() {
		var answer = confirm("Are you sure?");
		if (!answer){
			return false;
			}
		var id = $('#loan_list').jqGrid('getGridParam','selrow');
		if(id) {
			var url = "${createLink(controller:'IndividualDepartment',action:'loanEAR')}"+"?indDepid="+id;
			$.getJSON(url, {}, function(data) {
				alert(data.message);
			    });
		}
		else
			alert("Please select a row!!");
	}

    });
</script>


    </body>
</html>
