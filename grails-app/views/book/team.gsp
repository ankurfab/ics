
<%@ page import="ics.Book" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="team.list" default="Team List" /></title>
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
			<table id="team_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="team_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="member_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="member_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#team_list").jqGrid({
      url:'jq_team_list',
      editurl:'jq_edit_team',
      datatype: "json",
      colNames:['TeamName','From','Till','Comments','Status','Id'],
      colModel:[
	{name:'groupName', search:true, editable: true, editrules:{required:true}},
	{name:'fromDate', search:true, editable: true, editrules:{required:true},
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}	
	},
	{name:'tillDate', search:true, editable: true, editrules:{required:true},
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	}, 
	{name:'comments', search:true, editable: true},
	{name:'status', search:true, editable: true,
		edittype:"select",editoptions:{value:"${'INACTIVE:INACTIVE;ACTIVE:ACTIVE;DELETED:DELETED'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;INACTIVE:INACTIVE;ACTIVE:ACTIVE;DELETED:DELETED'}
	},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#team_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Team List",
    onSelectRow: function(ids) { 
      	if(ids!='new_row')
    		{
		var sel = jQuery('#team_list').jqGrid('getCell', ids, 'groupName');
		jQuery("#member_list").jqGrid('setCaption',"Members for Team: "+sel);
		$("#editurl").val("jq_edit_teammember?teamid="+ids);
		jQuery("#member_list").jqGrid('setGridParam',{url:"jq_teammember_list?teamid="+ids,editurl:"jq_edit_teammember?teamid="+ids}).trigger('reloadGrid');    	
    		}
    	}    
    });
    $("#team_list").jqGrid('filterToolbar',{autosearch:true});
    $("#team_list").jqGrid('navGrid',"#team_list_pager",{edit:false,add:false,del:true,search:false});
    $("#team_list").jqGrid('inlineNav',"#team_list_pager");

    jQuery("#member_list").jqGrid({
      url:'jq_teammember_list',
      editurl:'jq_edit_teammember',
      datatype: "json",
      colNames:['Name','Id'],
      colModel:[
	{name:'name', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}',
					minLength: 3,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	
					  	var newURL = $("#editurl").val();
					  	if(ui.item.id)
					  		newURL += "&item.id="+ui.item.id;
    					   jQuery("#member_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }},
	},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#member_list_pager',
    viewrecords: true,
    sortname: 'name',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Team Member List"
    });
    $("#member_list").jqGrid('filterToolbar',{autosearch:true});
    $("#member_list").jqGrid('navGrid',"#member_list_pager",{edit:false,add:false,del:false,search:false});
    $("#member_list").jqGrid('inlineNav',"#member_list_pager");


    });
</script>


    </body>
</html>
