
<%@ page import="ics.Sadhana" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sadhana.label', default: 'Sadhana')}" />
		<title>Sadhana Chart</title>

		<r:require module="grid" />
		    <style>
		    .ui-autocomplete-loading {
			background: white url("${resource(dir: 'images/', file: 'spinner.gif')}") right center no-repeat;
		    }
		    </style>
	</head>
	<body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
		<!-- table tag will hold our grid -->
		<table id="sadhana_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="sadhana_list_pager" class="scroll" style="text-align:center;"></div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#sadhana_list").jqGrid({
		      url:'jq_sadhana_list',
		      editurl:'jq_edit_sadhana',
		      datatype: "json",
		      colNames:['Week','Day','Date','MangalAratik','SandhyaAratik','<9am','9am-12noon','12noon-6pm','6pm-9pm','>9pm','Reading','Hearing','Association','Comments','id'],
		      colModel:[
				{name:'Week', editable:false},
				{name:'Day', editable:false},
				{name:'Date', editable:true,
				editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}},
				    {name:'attendedMangalAratik', editable:true,
				    edittype:"select",editoptions:{value:"${'false:NotAttended;true:Attended'}"}
				    },
				    {name:'attendedSandhyaAratik', editable:true,
				    edittype:"select",editoptions:{value:"${'false:NotAttended;true:Attended'}"}
				    },
				    {name:'numRoundsBefore9', editable:true},
				    {name:'numRoundsBetween9And12', editable:true},
				    {name:'numRoundsBetween12And6', editable:true},
				    {name:'numRoundsBetween6And9', editable:true},
				    {name:'numRoundsAfter9', editable:true},
				    {name:'minutesRead', editable:true},
				    {name:'minutesHeard', editable:true},
				    {name:'minutesAssociated', editable:true},
				    {name:'comments', editable:true},
				    {name:'id',hidden:true}
		     		],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager: '#sadhana_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "desc",
		    width: 1250,
		    height: "100%",
		    multiselect: false,
		    caption:"Sadhana Card"
		    });
		   $("#sadhana_list").jqGrid('setGroupHeaders', 
			{
			useColSpanStyle: true,
			groupHeaders:[
				{startColumnName: 'numRoundsBefore9', numberOfColumns: 5, titleText: 'Chanting'},
				]
			});
		jQuery("#sadhana_list").jqGrid('setFrozenColumns');
		jQuery("#sadhana_list").jqGrid('navGrid',"#sadhana_list_pager",{edit:false,add:false,del:true});
		jQuery("#sadhana_list").jqGrid('inlineNav',"#sadhana_list_pager");
		    });

		</script>
	</body>
</html>
