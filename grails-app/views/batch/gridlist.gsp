
<%@ page import="ics.Batch" %>
<!doctype html>
<html>
	<head>
        	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		</div>
		<div class="body">
		<!-- table tag will hold our grid -->
		<table id="batch_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="batch_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="batchItem_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#batch_list").jqGrid({
		      url:'jq_batch_list',
		      datatype: "json",
		      colNames:['Ref','Name','Description','Category','Type','FromDate','ToDate','Status','id'],
		      colModel:[
			{name:'ref',search:true},
			{name:'name',search:true},
			{name:'description',search:true},
			{name:'category',search:true},
			{name:'type',search:true},
			{name:'fromDate',search:true},
			{name:'toDate',search:true},
			{name:'status',search:true},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[5,10,20,30,50,100],
		    pager: '#batch_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'id',
		    sortorder: "desc",
		    width: 1200,
		    height: "100%",
		    multiselect: false,
		    caption:"Batch List",
			onSelectRow: function(ids) {
						var selBatchName = jQuery('#batch_list').jqGrid('getCell', ids, 'name');
						jQuery("#batchItem_list").jqGrid('setGridParam',{url:"${createLink(controller:'batch',action:'jq_batchitem_list',params:['batch.id':''])}"+ids,page:1});
						jQuery("#batchItem_list").jqGrid('setCaption',"BatchItem List for Batch: "+selBatchName) .trigger('reloadGrid');
					}
		    });
		   $("#batch_list").jqGrid('navGrid',"#batch_list_pager",
			{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
		    );
		   $("#batch_list").jqGrid('filterToolbar',{autosearch:true});


		jQuery("#batchItem_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'${createLink(controller:'batchItem',action:'jq_batchitem_list',params:['batch.id':0])}', 
			datatype: "json", 
			colNames:['postingDate','effectiveDate','description','ref','debit','grossAmount','netAmount','Status','linkedEntityName','linkedEntityRef','linkedEntityId','linkedBatchRef','id'], 
			colModel:[
				{name:'postingDate', editable:false,search:true},
				{name:'effectiveDate', editable:false,search:true},
				{name:'description', editable:false,search:true},
				{name:'ref', editable:false,search:true},
				{name:'debit', editable:false,search:true},
				{name:'grossAmount', editable:false,search:true},
				{name:'netAmount', editable:false,search:true},
				{name:'Status', editable:false,search:true},
				{name:'linkedEntityName', editable:false,search:true},
				{name:'linkedEntityRef', editable:false,search:true},
				{name:'linkedEntityId', editable:false,search:true},
				{name:'linkedBatchRef', editable:false,search:true},
				{name:'id',hidden:true}
				], 
			rowNum:10, 
			rowList:[5,10,20,30,50,100],
			pager: '#batchItem_list_pager', 
			multiselect: false,
			sortname: 'id', 
			viewrecords: true, 
			sortorder: "asc", 
			caption:"BatchItem List" }).navGrid('#batchItem_list_pager',{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
			); 
		  	$("#batchItem_list").jqGrid('filterToolbar',{autosearch:true});
	// add custom button to export the detail data to excel	
	jQuery("#batchItem_list").jqGrid('navGrid',"#batchItem_list_pager").jqGrid('navButtonAdd',"#batchItem_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var url = formUrl();			
			jQuery("#batchItem_list").jqGrid('excelExport',{"url":url});
	       }
	       });


		  });


		function formUrl() {
			var idlist = jQuery("#batch_list").jqGrid('getGridParam','selarrrow');
			if(idlist=='')	//try for multipleselect=false case
				idlist = jQuery("#batch_list").jqGrid('getGridParam','selrow');
			if(idlist==null)
				idlist=''
			var url = "${createLink(controller:'batchItem',action:'jq_indbatch_list_export')}"+"?batchids="+idlist

			return url;
		}

		</script>
	</body>
</html>
