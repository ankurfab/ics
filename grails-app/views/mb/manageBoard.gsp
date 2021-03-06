
<%@ page import="ics.Mb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Marriage Board</title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(controller:'Mb',action:'home')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!--    table tag will hold our grid -->
			<table id="mb_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="mb_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<g:set var="attr" value="${ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','Centre','Config')}" />
<g:set var="centres" value="${ics.AttributeValue.findAllByAttribute(attr)?.collect{it.value}}" />

<script>
  $(document).ready(function () {
    jQuery("#mb_list").jqGrid({
      url:'jq_mb_list',
      editurl:'jq_edit_mb',
      datatype: "json",
      colNames:['IcsId','Name','Phone','Email','Centre','Role','LoginId','Id'],
      colModel:[
	{name:'icsid',search:true},
	{name:'name',search:true,editable:true,editrules:{required:true}},         
	{name:'phone',search:true,editable:true,editrules:{required:true,integer:true, minValue:1000000000, maxValue:9999999999}},
	{name:'email',search:true,editable:true,editrules:{required:true,email:true}},
	{name:'centre',search:true,editable:true,
		formatter: 'select',
		edittype:"select",editoptions:{ value: "${centres?.collect{(it?:'')+':'+(it?:'')}.join(';')}"},
		stype:'select', searchoptions: { value: "${':ALL;'+(centres?.collect{(it?:'')+':'+(it?:'')}.join(';'))}"}						
	},
	{name:'role',search:true,editable:true,
		formatter: 'select',
		edittype:"select",editoptions:{ value: "MEMBER:MEMBER;SECRETARY:SECRETARY;ADMIN:ADMIN"},
		stype:'select', searchoptions: { value: "${':ALL;'+'MEMBER:MEMBER;SECRETARY:SECRETARY;ADMIN:ADMIN'}"}						
	},
	{name:'loginid',search:true},
	{name:'id',hidden:true}
     ],
     
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#mb_list_pager',
    viewrecords: true,
    sortname: "lastUpdated",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Mb List"
    });
    $("#mb_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#mb_list").jqGrid('navGrid', "#mb_list_pager", {edit: false, add: true, del: false, search: false});
    $("#mb_list").jqGrid('navGrid',"#mb_list_pager").jqGrid('navButtonAdd',"#mb_list_pager",{caption:"User", buttonicon:"ui-icon-unlocked", onClickButton:unlockUser, position: "last", title:"UnlockUser", cursor: "pointer"});

	function unlockUser() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#mb_list').jqGrid('getGridParam','selrow');
			if(idlist) {
				var url = "${createLink(controller:'mb',action:'unlockAndResetUser')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

    
    });
</script>


    </body>
</html>
