<%@ page import="ics.Mb" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Activity Stream</title>
		<r:require module="grid" />
		<r:require module="dateTimePicker" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(controller:'Mb',action:'home')}"><g:message code="default.home.label"/></a></span>
		</div>

            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>

		<div id='message' class="message" style="display:none;"></div>

		<div id="dialogcandidateReason" title="Reason">
			<g:textArea name="candidateReason" value="" rows="5" cols="40"/>
		</div>            

		<div id="dialogFullProfile" title="Full Profile">
			<div id="divFullProfile"></div>
		</div>

		
            <div>
			<!-- table tag will hold our grid -->
			<table id="activityStream_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="activityStream_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
		

<script type="text/javascript">
  $(document).ready(function () {		    


    jQuery("#activityStream_list").jqGrid({
      url:'activityStream_list',
      editurl:'activityStream_edit',
      datatype: "json",
      colNames:['By','With','Category','StartDate','EndDate','Description','Comments','Status','Reference','Id'],
      colModel:[
	{name:'followupByName',search:true},
	{name:'followupWithName',search:true},
	{name:'category', editable:true,edittype:"select",editoptions:{value:"PREACHING:PREACHING;DONATION:DONATION;EVENT:EVENT;OTHER:OTHER"}},
	{name:'startDate', editable:true, editoptions:{size:20, 
                  dataInit:function(el){ 
                        $(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
                  }}},
	{name:'endDate', editable:true, editoptions:{size:20, 
                  dataInit:function(el){ 
                        $(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
                  }}},
	{name:'description', editable:true},
	{name:'comments', editable:true,edittype:"textarea", editoptions:{rows:"2",cols:"20"}},
	{name:'status', editable:true,edittype:"select",editoptions:{value:"OPEN:OPEN;CLOSE:CLOSE"}},
	{name:'ref', editable:true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10],
    pager: '#activityStream_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1250,
    height: "100%",
    multiselect: false,
    caption:"Activity Stream"
    });
    $("#activityStream_list").jqGrid('filterToolbar',{autosearch:true});
    $("#activityStream_list").jqGrid('navGrid',"#activityStream_list_pager",{edit:false,add:false,del:false,search:false,refresh:false});
    $("#activityStream_list").jqGrid('inlineNav',"#activityStream_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    });	
  
  });
</script>


	</body>
</html>
