
<%@ page import="ics.Item" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="item.list" default="Item List" /></title>
	<r:require module="grid" />
	<r:require module="ajaxform"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="item_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="item_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>

		<div id="dialogIssueForm" title="Item(s) Issue Form">
		</div>

        </div>

<script>
  $(document).ready(function () {
    jQuery("#item_list").jqGrid({
      url:'vsUser_jq_item_list',
      datatype: "json",
      colNames:['Name','OtherNames','Category','SubCategory','Variety','Brand','Description','Id'],
      colModel:[
	{name:'name', search:true},
	{name:'otherNames', search:true},
	{name:'category', search:true}, 
	{name:'subcategory', search:true}, 
	{name:'variety', search:true},
	{name:'brand', search:true},
	{name:'comments', search:true},
	{name:'id',hidden:true}
     ],
    rowNum:20,
    rowList:[10,20,30,40,50,100,200],
    pager: '#item_list_pager',
    viewrecords: true,
    sortname: 'name',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Item List",
    });
    $("#item_list").jqGrid('filterToolbar',{autosearch:true});
    $("#item_list").jqGrid('navGrid',"#item_list_pager",{edit:false,add:false,del:false,search:false});
    $("#item_list").jqGrid('inlineNav',"#item_list_pager",
    	{ 
	       delete: false,
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    }
);
    $("#item_list").jqGrid('navGrid',"#item_list_pager").jqGrid('navButtonAdd',"#item_list_pager",{caption:"Issue", buttonicon:"ui-icon-cart", onClickButton:issue, position: "last", title:"Issue", cursor: "pointer"});

	function issue() {
			var ids = $('#item_list').jqGrid('getGridParam','selarrrow');
			if(ids!="") {
				var url = "${createLink(controller:'item',action:'vsUserIssue')}"+"?idlist="+ids
				$( "#dialogIssueForm" ).load( url );
				$( "#dialogIssueForm" ).dialog( "open" );
			}
			else
				alert("Please select item(s)!!");
	}

		$( "#dialogIssueForm" ).dialog({
			autoOpen: false,
			height: 450,
			width: 350,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#erid").val($('#registration_list').jqGrid('getGridParam','selrow'));
					    $("#formPaymentReference").ajaxForm({
						success: function() {
							alert("Item(s) issue request submitted");
							}
					    }).submit();
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		});
</script>


    </body>
</html>
