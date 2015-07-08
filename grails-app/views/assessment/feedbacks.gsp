
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Feedback List</title>
	<r:require module="grid" />
    </head>
    <body>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            Event:<g:select id="event" name="event" from="${events}" optionValue="title" optionKey="id" value="${event?.id}"  onchange="reloadGrid()"/>
            <div>
			<!-- table tag will hold our grid -->
			<table id="feedback_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="feedback_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#feedback_list").jqGrid({
      url:'jq_feedback_list?eid='+$('#event').val(),
      datatype: "json",
      colNames:['Name','Gender','Loginid','Regcode','Language','Date','TimeTaken','Score','Grade','Item1','Item2','Item3','Item4','Item5','Item6','Item7','Item8','Item9','Item10','Item11','Item12','Item13','Item14','Item15','Id'],
      colModel:[
	{name:'name', search:true,editable: false},
	{name:'gender', search:true,editable: false},
	{name:'loginid', search:true,editable: false},
	{name:'regCode', search:true,editable: false},
	{name:'language', search:true,editable: false,stype:'select', searchoptions: { value: ':ALL;English:English;Hindi:Hindi;Marathi:Marathi;Telugu:Telugu'}},
	{name:'assessmentDate', search:false,editable: false},
	{name:'timeTaken', search:false,editable: false},
	{name:'score', search:false,editable: false},
	{name:'result', search:false,editable: false},
	{name:'item1', search:false,editable: false},
	{name:'item2', search:false,editable: false},
	{name:'item3', search:false,editable: false},
	{name:'item4', search:false,editable: false},
	{name:'item5', search:false,editable: false},
	{name:'item6', search:false,editable: false},
	{name:'item7', search:false,editable: false},
	{name:'item8', search:false,editable: false},
	{name:'item9', search:false,editable: false},
	{name:'item10', search:false,editable: false},
	{name:'item11', search:false,editable: false},
	{name:'item12', search:false,editable: false},
	{name:'item13', search:false,editable: false},
	{name:'item14', search:false,editable: false},
	{name:'item15', search:false,editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:15,
    rowList:[10,15,20,30,40,50,100,200],
    pager: '#feedback_list_pager',
    viewrecords: true,
    sortname: 'assessmentDate',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Feedback List"
    });
    $("#feedback_list").jqGrid('filterToolbar',{autosearch:true});
    $("#feedback_list").jqGrid('navGrid',"#feedback_list_pager",{edit:false,add:false,del:false,search:false});
    $("#feedback_list").jqGrid('inlineNav',"#feedback_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    }
    );
	// add custom button to export the detail data to excel	
	jQuery("#feedback_list").jqGrid('navGrid',"#feedback_list_pager").jqGrid('navButtonAdd',"#feedback_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var query = 'jq_feedback_list?eid='+$('#event').val();			
			jQuery("#feedback_list").jqGrid('excelExport',{"url":query});
	       }
	       });
    
    });

</script>


    </body>
</html>
