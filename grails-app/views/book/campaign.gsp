
<%@ page import="ics.Book" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="campaign.list" default="Campaign List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
    </head>
    <body>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
	    <g:hiddenField name="editurl" value="" />
            <div>
			<!-- table tag will hold our grid -->
			<table id="campaign_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="campaign_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="bookprice_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="bookprice_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#campaign_list").jqGrid({
      url:'jq_campaign_list',
      editurl:'jq_edit_campaign',
      datatype: "json",
      colNames:['Name','Description','FromDate','TillDate','Category','Status','Id'],
      colModel:[
	{name:'name', search:true, editable: true},
	{name:'description', search:true, editable: true},
	{name:'fromDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}	
	},
	{name:'tillDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}	
	},
	{name:'category', search:true, editable: true,
		edittype:"select",editoptions:{value:"${'Marathon:Marathon;Festival:Festival;Other:Other'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;Marathon:Marathon;Festival:Festival;Other:Other'}
	},
	{name:'status', search:true, editable: true,
		edittype:"select",editoptions:{value:"${'Active:Active;InActive:InActive;Deleted:Deleted'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;Active:Active;InActive:InActive;Deleted:Deleted'}
	},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#campaign_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Campaign List",
    onSelectRow: function(ids) { 
      	if(ids!='new_row')
    		{
		var sel = jQuery('#campaign_list').jqGrid('getCell', ids, 'name');
		jQuery("#bookprice_list").jqGrid('setCaption',"Campaign Line Item(s) List for Campaign: "+sel);
		$("#editurl").val("jq_edit_bookprice?campaignid="+ids);
		jQuery("#bookprice_list").jqGrid('setGridParam',{url:"jq_bookprice_list?campaignid="+ids,editurl:"jq_edit_bookprice?campaignid="+ids}).trigger('reloadGrid');    	
    		}
    	}    
    });
    $("#campaign_list").jqGrid('filterToolbar',{autosearch:true});
    $("#campaign_list").jqGrid('navGrid',"#campaign_list_pager",{edit:false,add:false,del:false,search:false});
    $("#campaign_list").jqGrid('inlineNav',"#campaign_list_pager");

    jQuery("#bookprice_list").jqGrid({
      url:'jq_bookprice_list',
      editurl:'jq_edit_bookprice',
      datatype: "json",
      colNames:['Name','Language','Price','Id'],
      colModel:[
	{name:'book', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'book',action:'allBooksAsJSON_JQ')}',
					minLength: 0,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	
					  	var newURL = $("#editurl").val();
					  	if(ui.item.id)
					  		newURL += "&item.id="+ui.item.id;
    					   jQuery("#bookprice_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }},
	},
	{name:'language', search:true, editable: true,
        	edittype:"select",editoptions:{value:"${':--Please Select Language--;'+(ics.Book.createCriteria().list{projections{distinct('language')}}?.collect{it+':'+it}.join(';'))}"},
        	stype:'select', searchoptions: {value:"${':--Please Select Language--;'+(ics.Book.createCriteria().list{projections{distinct('language')}}?.collect{it+':'+it}.join(';'))}"}
	},
	{name:'price', search:true, editable: true,editrules:{required:true}},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#bookprice_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Campaign Line Item(s) List"
    });
    $("#bookprice_list").jqGrid('filterToolbar',{autosearch:true});
    $("#bookprice_list").jqGrid('navGrid',"#bookprice_list_pager",{edit:false,add:false,del:false,search:false});
    $("#bookprice_list").jqGrid('inlineNav',"#bookprice_list_pager");



    });
</script>


    </body>
</html>
