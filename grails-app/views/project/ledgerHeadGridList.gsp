
  
  <%@ page import="ics.LedgerHead" %>
  <!doctype html>
  <html>
  	<head>
  		<meta name="layout" content="main">
  		<title>List of LedgerHead</title>
   
  		<r:require module="grid" />
  	</head>
  	<body>
  		<div class="nav">
  		<span class="menuButton"><a class="ist"
  			href="${createLink(uri: '/')}"><g:message
  					code="default.home.label" /></a></span>
  		</div>
  		<!-- table tag will hold our grid -->
  		<table id="ledger_head_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="ledger_head_list_pager" class="scroll" style="text-align:center;"></div>
  
            <script type="text/javascript">		
  		  $(document).ready(function () {
  		    jQuery("#ledger_head_list").jqGrid({
  		      //url:'jq_ ledger_head_list'
  		      
  		      url:"${createLink(controller:'Project',action:'jq_ledger_head_list')}",
		      editurl:"${createLink(controller:'Project',action:'jq_edit_ledgerhead')}",	                    
	               datatype:"json",
  		    
  		    
  		    //@TODO: in cotroller use-> params.creator=params.updator=springSecurityService.principal.username?:'system'
  		      colNames:['Name','Type','Category','Description','Id'],
  		      colModel:[
  			{name:'name',search: true, editable: true},
  			{name:'type',search: true, editable: true},
  			{name:'category',search: true, editable: true},
  			{name:'description',search: true, editable: true},
  			{name:'id',hidden:true}
  				
  		     ],
  		    rowNum:10,
  		    rowList:[5,10,20,30,40,50,100,150,200],
  		    pager:'#ledger_head_list_pager',
  		    viewrecords: true,
  		    gridview: true,
  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
  		    caption:" Ledger Head List",
  		    loadComplete: function () { $("#ledger_head_list").jqGrid().setGridParam({datatype:'json'});}
  		    });
  		   
  		   $('#ledger_head_list').jqGrid('setGridParam', {sortorder: 'desc'});
                     $('#ledger_head_list').jqGrid('sortGrid', 'name');
  	
  		    $("#ledger_head_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#ledger_head_list").jqGrid('navGrid', "#ledger_head_list_pager", {edit: true, add: true, del: true, search: true});
  		   // $("#ledger_head_list").jqGrid('navGrid',"#ledger_head_list_pager").jqGrid('navButtonAdd',"#ledger_head_list_pager",{caption:"NewItem", buttonicon:"ui-icon-document", onClickButton:newItem, position: "last", title:"NewItem", cursor: "pointer"}); 
  		   
                     
  		    
  		    });
  		    
  		</script>
  
  
  
  	</body>
  </html>
