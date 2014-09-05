<!--
TO DO

1) implementing search
2) Have a link to Create Page
3) Making recipe name a link to recipe
4) Hide unwanted columns and column width
5) Verify edit del operations

-->

<%@ page import="ics.Recipe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="recipe.list" default="Recipe List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="recipe" params="[cmd:'create']">Create</g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="recipe_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="recipe_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="recipeVersion_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="recipeVersion_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#recipe_list").jqGrid({
      url:'jq_recipe_list',
      editurl:'jq_edit_recipe',
      datatype: "json",      colNames:['Name','Cuisine','Category','Spicy','Healthy','Economical','PreprationTime','ShelfLife','Rating','Feedback','Comments','Status','Updator','LastUpdated','Creator','DateCreated','Id'],
      colModel:[
	{name:'name', search:true, width:300, editable: true, editrules:{required:true},formatter: 'showlink', formatoptions:{baseLinkUrl:'recipe',addParam:'&cmd=show'}},
	{name:'cuisine', search:true, width:300, editable: true, editrules:{required:false}},
	{name:'category', search:true, width:600, editable: true, editrules:{required:false}}, 
	{name:'spicy', search:true, editable: true, edittype:"select", editoptions:{value:":--Please Select Spicy Indicator--;NONSPICY:Non Spicy;LOWSPICE:Low Spicy;MEDIUMSPICY:Medium Spicy;HOT:Spicy;VERYHOT:Very Spicy"},formatter: 'select',stype:'select', searchoptions: { value: ':ALL;NONSPICY:Non Spicy;LOWSPICE:Low Spicy;MEDIUMSPICY:Medium Spicy;HOT:Spicy;VERYHOT:Very Spicy' }},
	{name:'healthy', search:true, editable: true, edittype:"select", editoptions:{value:":--Please Select Health Indicator--;JUNKFOOD:Junk Food;LOW:Low Health;MEDIUMHEALTH:Medium Health;AVGHEALTH:Average Health;HEALTH:Healthy"}},
	{name:'economical', search:true, editable: true, edittype:"select", editoptions:{value:":--Please Select Cost Indicator--;LOW:Low Cost;MEDIUM:Medium Cost;HIGH:High Cost;VERYHIGH:Opulent"}},
	{name:'preprationtime', search:true, editable: true, edittype:"select", editoptions:{value:":--Please Select Preperation Time Indicator--;QUICK:Less than 15min;LOW:15mins-30mins;MEDIUM:30mins-45mins;HIGH:45mins-60mins;LONG:More than 1hr"}},
	{name:'shelflife', search:true, editable: true, edittype:"select", editoptions:{value:":--Please Select Shelf Life Indicator--;LOW:Low Shelf Life;MEDIUM:Medium Shelf Life;LONG:Long Shelf Life;EXTRALONG:Very Long Shelf Life"}},
	{name:'rating', search:true, editable: true, edittype:"select", editoptions:{value:":--Please Specify Rating--;NA:NA;ONE:*;TWO:**;THREE:***;FOUR:****;FIVE:*****"}},
	{name:'feedback', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'status', search:true, editable: true, edittype:"select", editoptions:{value:":--Please Select Status--;NOTTESTED:Not Yet Tested;Tested:Tested;AVAILABLE:Available"}},
	{name:'updator', search:true, editable: false,hidden:true},
	{name:'lastUpdated', search:true, editable: false, hidden:true},
	{name:'creator', search:true, editable: false, hidden:true},
	{name:'dateCreated', search:true, editable: false, hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#recipe_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Recipe List",
    /*onSelectRow: function(ids) { 
    	jQuery("#recipeVersion_list").jqGrid('setGridParam',{url:"jq_recipeVersion_list?recipeid="+ids}).trigger('reloadGrid');    	
    	} */   
    });
    $("#recipe_list").jqGrid('filterToolbar',{autosearch:true});
    $("#recipe_list").jqGrid('navGrid',"#recipe_list_pager",{edit:false,add:false,del:true,search:false});
    $("#recipe_list").jqGrid('inlineNav',"#recipe_list_pager");

    /*jQuery("#recipeVersion_list").jqGrid({
      url:'jq_recipeVersion_list',
      editurl:'jq_edit_recipeVersion',
      datatype: "json",
      colNames:['FromTime','FromLocation','ToLocation','ToTime','InchargeName','InchargeNumber','DriverName','DriverNumber','Comments','Id'],
      colModel:[
	{name:'departureTime', search:true, editable: true},
	{name:'source', search:true, editable: true},
	{name:'destination', search:true, editable: true},
	{name:'arrivalTime', search:true, editable: true},
	{name:'inchargeName', search:true, editable: true},
	{name:'inchargeNumber', search:true, editable: true},
	{name:'driverName', search:true, editable: true},
	{name:'driverNumber', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#recipeVersion_list_pager',
    viewrecords: true,
    sortname: 'departureTime',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Recipe RecipeVersion List"
    });
    $("#recipeVersion_list").jqGrid('filterToolbar',{autosearch:true});
    $("#recipeVersion_list").jqGrid('navGrid',"#recipeVersion_list_pager",{edit:false,add:false,del:false,search:false});
    //$("#recipeVersion_list").jqGrid('inlineNav',"#recipeVersion_list_pager");*/


    });
</script>


    </body>
</html>
