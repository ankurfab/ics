
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Month Summary</title>
	<r:require module="grid" />

		<style>
			.bgGreen{
			   background: none repeat scroll 0 0 green !important;
			  }
			.bgLightGreen{
			   background: none repeat scroll 0 0 lightgreen !important;
			  }
			.bgOrange{
			   background: none repeat scroll 0 0 orange !important;
			  }
			.bgRed{
			   background: none repeat scroll 0 0 red !important;
			  }
			.bgYellow{
			   background: none repeat scroll 0 0 yellow !important;
			  }
		</style>		

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="monthSummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="monthSummary_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>

            <div>
			<!-- table tag will hold our grid -->
			<table id="audit_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="audit_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>

		<div>
		Upload Budget for Cost Centers<br />
		Format of upload file<br/>
		ccId,amount<br/>
		    <g:uploadForm controller="CostCenter" action="uploadCurrentBudget">
			<input type="file" name="myFile" />
			<input type="submit" value="UploadBudget"/>
		    </g:uploadForm>
		</div>
	    <g:form name="downloadForm" controller="CostCenter" action="downloadCurrentBudget" >
		    <input id = "btnDownloadBudget" type="submit" value="DownloadBudget"/>
	    </g:form>

		<div id="dialogBudget" title="Update Budget">
			<g:render template="updateBudget" />
		</div>            

        </div>


<script>
  $(document).ready(function () {
    jQuery("#monthSummary_list").jqGrid({
      url:'jq_monthSummary_list',
      datatype: "json",
      colNames:['CCId','CostCategory','Name','Alias','Budget','RemainingBudget','Consumption','SubmittedExpense','ApprovedExpense','DraftSettlement','RejectedSettlement','SubmittedSettlement','ApprovedSettlement','SettledExpense','AdvanceIssued(FYI Only)','check','Id'],
      colModel:[
	{name:'ccid',search:false},
	{name:'ccat',search:true},
	{name:'name',search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'CostCenter',action:'show')}'}
        },
	{name:'alias',search:true},
	{name:'budget',search:false},
	{name:'remainingbudget',search:false},
	{name:'balance',search:false},
	{name:'submittedExpense',search:false},
	{name:'approvedExpense',search:false},
	{name:'draftSettlement',search:false},
	{name:'rejectedSettlement',search:false},
	{name:'submittedSettlement',search:false},
	{name:'approvedSettlement',search:false},
	{name:'settledExpense',search:false},
	{name:'advanceIssued',search:false},
	{name:'check',hidden:true},
	{name:'id',hidden:true}
     ],
    rowattr: function (rd) {
	    if (rd.check!= null && rd.check.indexOf("notok") > -1 ) {
		return {"class": "bgYellow"};
		}
	    },		             
    rowNum:10,
    rowList:[10,20,30,40,50,100,200,500],
    pager: '#monthSummary_list_pager',
    viewrecords: true,
    sortname: "name",
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
	footerrow : true,
	userDataOnFooter : true,							    
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
		var selName = jQuery('#monthSummary_list').jqGrid('getCell', ids, 'name');
		
		//set detail grid for audit
		jQuery("#audit_list").jqGrid('setGridParam',{url:"jq_audit_list?ccid="+ids});
		jQuery("#audit_list").jqGrid('setCaption',"Audit Records for CostCenter: "+selName).trigger('reloadGrid');   	

		}
    	},    
    caption:"Month Summary"
    });
    $("#monthSummary_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#monthSummary_list").jqGrid('navGrid', "#monthSummary_list_pager", {edit: false, add: false, del: false, search: false});
	
	jQuery("#monthSummary_list").jqGrid('navGrid',"#monthSummary_list_pager").jqGrid('navButtonAdd',"#monthSummary_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	   onClickButton : function () {
	   var url = "exportMonthlySummaryEntries";
		jQuery("#monthSummary_list").jqGrid('excelExport',{"url":url});
	   }
	});
    $("#monthSummary_list").jqGrid('navGrid',"#monthSummary_list_pager").jqGrid('navButtonAdd',"#monthSummary_list_pager",{caption:"UpdateBudget", buttonicon:"ui-icon-calculator", onClickButton:updateBudget, position: "last", title:"UpdateBudget", cursor: "pointer"});

    jQuery("#audit_list").jqGrid({
      url:'jq_audit_list',
      datatype: "json",
      colNames:['Date','By','Details','Id'],
      colModel:[
	{name:'dateCreated', search:false, editable: false},
	{name:'creator', search:false, editable: false},
	{name:'value', search:false, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30],
    pager: '#audit_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: 'desc',
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Audit(s)"
    });
    //$("#audit_list").jqGrid('filterToolbar',{autosearch:true});
    $("#audit_list").jqGrid('navGrid',"#audit_list_pager",{edit:false,add:false,del:false,search:false});
    $("#audit_list").jqGrid('inlineNav',"#audit_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    }
	);


	function updateBudget() {
		var id = $('#monthSummary_list').jqGrid('getGridParam','selrow');
		if(id) {
				$( "#dialogBudget" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}

		$( "#dialogBudget" ).dialog({
			autoOpen: false,
			height: 400,
			width: 400,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#ccid_updatebudget").val($('#monthSummary_list').jqGrid('getGridParam','selrow'));
					    $("#formUpdateBudget").submit();					    
						
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
