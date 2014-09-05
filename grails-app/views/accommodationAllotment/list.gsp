
<%@ page import="ics.AccommodationAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Accommodation Allocation for Registrations</title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="EventAccommodation">Accommodation List</g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="full_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="full_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#full_list").jqGrid({
      url:'jq_full_list',
      editurl:'jq_edit_invalid',
      datatype: "json",
      colNames:['RegCode','RegName','RegStatus','AccoRequired','PrjiReq','MatajiReq','ChildReq','BrahmacharisReq','TotalReq','AllotmentStatus','Acco Name','Number Allotted','Id'],
      colModel:[
	{name:'regCode',sortable:false},
	{name:'name',sortable:false},
	{name:'verificationStatus',sortable:false},
	{name:'isAccommodationRequired',sortable:false},
	{name:'numberofPrabhujis',sortable:false},
	{name:'numberofMatajis',sortable:false},
	{name:'numberofChildren',sortable:false},
	{name:'numberofBrahmacharis',sortable:false},
	{name:'totalReq',sortable:false},
	{name:'accommodationAllotmentStatus',sortable:false},
	{name:'accoName',sortable:false}, 
	{name:'numberAllotted',sortable:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#full_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Accommodation Allotment List",
    footerrow : true,
    userDataOnFooter : true								

    });
    $("#full_list").jqGrid('filterToolbar',{autosearch:true});
    $("#full_list").jqGrid('navGrid',"#full_list_pager",{edit:false,add:false,del:true,search:false});
    $("#full_list").jqGrid('inlineNav',"#full_list_pager");

    });
</script>


    </body>
</html>
