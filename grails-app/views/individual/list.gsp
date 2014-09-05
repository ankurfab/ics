
<%@ page import="ics.Individual" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
		<title>List of Individuals</title>
 
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		<span class="menuButton"><a class="ist"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span>
		</div>
		Fuzzy Search?<g:checkBox name="fuzzy" value="${true}" onClick="setURL()"/>
		<!-- table tag will hold our grid -->
		<table id="individual_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="individual_list_pager" class="scroll" style="text-align:center;"></div>

		<sec:ifAnyGranted roles="ROLE_DATA_CLEAN">
		 <input class="menuButton" type="BUTTON" id="mergeBtn" value="MergeRecords" />
		</sec:ifAnyGranted>
		<!--<input class="menuButton" type="BUTTON" id="relateBtn" value="RelateRecords" />
		<input class="menuButton" type="BUTTON" id="deleteBtn" value="DeleteRecords" />-->

		<script type="text/javascript">		
		  $(document).ready(function () {
		    jQuery("#individual_list").jqGrid({
		      url:'jq_full_list?fuzzy='+true,
		      datatype: "local",
		      colNames:['IcsId','LegalName','InitiatedName','DoB','Address','Phone','Email','Relationships','Status'],
		      colModel:[
			{name:'icsid', editable:false, search:true},
			{name:'legalName',
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}
			},
			{name:'initiatedName', search:false},
			{name:'dob', search:false},
			{name:'address', editable:false},
			{name:'phone', editable:false},
			{name:'email', editable:false, search:true},
			{name:'relationship', editable:false},
			{name:'status', editable:false, search:false}			
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,150,200],
		    pager: '#individual_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    width: 1250,
		    height: "100%",
		    multiselect: true,
		    caption:"Individual List",
		    loadComplete: function () { $("#individual_list").jqGrid().setGridParam({datatype:'json'});}
		    });
		   $("#individual_list").jqGrid('filterToolbar',{autosearch:true});
		   $("#individual_list").jqGrid('navGrid',"#individual_list_pager",
			{edit:false,add:false,del:false,search:false}
		    );
	$( "#mergeBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#individual_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'mergeRecords')}"+"?idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
					    });	
			}
			else
				alert("Please select rows!!");
		});
	$( "#relateBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#individual_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'relateRecords')}"+"?idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
					    });	
			}
			else
				alert("Please select rows!!");
		});
	$( "#deleteBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#individual_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'deleteRecords')}"+"?idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
					    });	
			}
			else
				alert("Please select rows!!");
		});

		    });
		    
		function setURL(){
			jQuery("#individual_list").jqGrid('setGridParam',{url:"jq_full_list"+"?fuzzy="+$('#fuzzy').is(':checked')});
			}
		    
		</script>



	</body>
</html>
