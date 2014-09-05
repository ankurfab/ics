
<%@ page import="ics.AccommodationAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Invalid Accommodation Allotment List</title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="EventAccommodation">Accommodation List</g:link></span>
        </div>
        <div class="body">
            <div>
			<h2>The below list represents all such accommodation allotments that have now become invalid since either the registration has been rejected or the group leader does not want any accommodation. Please 'delete' such records to free up capacity in the accommodation places.<br></h2>
			<h3></h3>
			
			<!-- table tag will hold our grid -->
			<table id="invalid_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="invalid_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#invalid_list").jqGrid({
      url:'jq_invalid_list',
      editurl:'jq_edit_invalid',
      datatype: "json",
      colNames:['RegCode','GL Name','Acco Name','Number Allotted','Id'],
      colModel:[
	{name:'regCode',sortable:false},
	{name:'glName',sortable:false},
	{name:'accoName',sortable:false}, 
	{name:'numberAllotted',sortable:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#invalid_list_pager',
    viewrecords: true,
    sortname: "numberAllotted",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Invalid Accommodation Allotment List"
    });
    $("#invalid_list").jqGrid('navGrid',"#invalid_list_pager",{edit:false,add:false,del:true,search:false});

    });
</script>


    </body>
</html>
