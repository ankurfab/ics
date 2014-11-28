
<%@ page import="ics.Commitment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="commitment.list" default="Commitment Report" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="commitment_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="commitment_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#commitment_list").jqGrid({
      url:'jq_commitment_list',
      editurl:'jq_edit_commitment',
      datatype: "json",
      colNames:['CommittedBy','Scheme','DonationCommitment','CollectionCommitment','TotalCommitted','ECSMandate','CommittedOn','CommitmentTill','Status','HoldTill','Id'],
      colModel:[
	{name:'committedByName'},
	{name:'schemeName'},
	{name:'committedAmount', editable: true},
	{name:'ccAmount'},
	{name:'total'},
	{name:'ecsMandate', editable: true},
	{name:'commitmentOn'},
	{name:'commitmentTill'},
    {name:'status',search:true},
    {name:'holdTill',search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#commitment_list_pager',
    viewrecords: true,
    sortname: "id",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Commitment List"
    });
    $("#commitment_list").jqGrid('filterToolbar',{autosearch:true});
    $("#commitment_list").jqGrid('navGrid',"#commitment_list_pager",{edit:false,add:false,del:true,search:false});
    $("#commitment_list").jqGrid('inlineNav',"#commitment_list_pager");
	// add custom button to export the detail data to excel	
	jQuery("#commitment_list").jqGrid('navGrid',"#commitment_list_pager").jqGrid('navButtonAdd',"#commitment_list_pager",{caption:"Download ECS Active", buttonicon:"ui-icon-disk",title:"Download",
	       onClickButton : function () { 
			var url = jQuery("#commitment_list").jqGrid('getGridParam', 'url');		
			jQuery("#commitment_list").jqGrid('excelExport',{"url":url});
	       }
	       });
    });
</script>


    </body>
</html>
