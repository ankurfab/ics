
  <%@ page import="ics.CostCenterGroup" %>
  <%@ page import="ics.CostCenter" %> 
  <!doctype html>
  <html>
  	<head>
  		<meta name="layout" content="main">
  		<title>Vertical-Department List</title>
   
  		<r:require module="grid" />

  	</head>
  	<body>  		
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		    <span class="menuButton"><g:link class="list" controller="CostCenter" action="ccBackup">Download CostCenters</g:link></span>
		    <span class="menuButton"><g:link class="list" controller="CostCenterGroup" action="cgBackup">Download CostCenterGroups</g:link></span>
		    <span class="menuButton"><g:link class="list" controller="CostCenter" action="orgStructureBackup">Download Org Structure</g:link></span>
		</div>

                <div id="dialogNewCostCenterGroupForm" title="Add New Vertical">
			 <g:form name="addCostCenterGroup" controller="project" action="addCostCenterGroup" method="POST">
			 <g:render template="addCostCenterGroup" />	         
			 </g:form>
		</div>
		
		
		 <div id="dialogEditCostCenterGroupForm" title="Update Vertical">
			<g:form name="editCostCenterGroupForm" controller="project" action="" method="POST">
			<g:render template="addCostCenterGroup" />	         
			</g:form>
		</div>
		
	       <div id="dialogNewCostCenterForm" title="Add New Cost Center">
	                 <g:form name="addcostcenter" controller="project" action="" method="POST">
	           
		            <g:render template="addCostCenter" /> 
		         </g:form>
	       </div>            
		        
	       <div id="dialogEditCostCenterForm" title="Update Cost Center">
	                <g:form name="editcostcenterForm" controller="project" action="" method="POST">
	                <g:render template="addCostCenter" />	
		        </g:form>
	       </div>            
		 
		 <!-- table tag will hold our grid -->
		<table id="costcentergroup_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
       		<!-- pager will hold our paginator -->
  		<div id="costcentergroup_list_pager" class="scroll" style="text-align:center;"></div>	
  		
  		<!-- table tag will hold our grid -->
		<table id="costcenter_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
       		<!-- pager will hold our paginator -->
  		<div id="costcenter_list_pager" class="scroll" style="text-align:center;"></div>
  
		<div>
		Bulk create Verticals : <br />
		    <g:uploadForm controller="CostCenterGroup" action="uploadForCG">
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>
		<div>
		Bulk create Cost Center : <br />
		    <g:uploadForm controller="CostCenter" action="uploadForCC">
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>


             <script type="text/javascript">		
  		  $(document).ready(function () {
  	
                jQuery("#costcentergroup_list").jqGrid({
  		     url:"${createLink(controller:'Project',action:'jq_costcentergroup_list')}",
		     editurl:"${createLink(controller:'Project',action:'jq_edit_costcentergroup')}",	                    
	             datatype:"json",
  	 	  colNames:['Name','Description','Owner','Phone','Email','Loginid','Id'],
  		      colModel:[
  			{name:'name',search: true, editable: true,
				formatter:'showlink', 
	             		formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'CostCenterGroup',action:'show')}'}
  			},
  			{name:'description',search: true, editable: true},
  			{name:'owner',search: true, editable: true,
				formatter:'showlink', 
	             		formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'CostCenterGroup',action:'showOwner')}'}
  			},  			
  			{name:'phone',search: true, editable: true},
  			{name:'emailContact',search: true, editable: true},
  			{name:'loginid',search: true, editable: true},
  			{name:'id',hidden:true}  			
  		     ], 
  		    rowNum:10,
  		    rowList:[5,10,20,30,40,50,100],
  		    pager:'#costcentergroup_list_pager',
  		    viewrecords: true,
  		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
  		    caption:"List of Verticals",  		    
  	            onSelectRow: function(ids) { 
			   if(ids!='new_row')
			   { 	    	        
			   var selName = jQuery('#costcentergroup_list').jqGrid('getCell', ids, 'name'); 
			   var url = "${createLink(controller:'Project',action:'jq_costcenter_list')}"+"?cgid="+ids;
			   jQuery("#costcenter_list").jqGrid('setGridParam',{url:url});
			   var editurl = "${createLink(controller:'Project',action:'jq_edit_costcenter')}"+"?cgid="+ids;
			   jQuery("#costcenter_list").jqGrid('setGridParam',{editurl:url});
			   jQuery("#costcenter_list").jqGrid('setCaption',"Departments under vertical: "+selName).trigger('reloadGrid');   	
			     }
				}
                  });	    
  		
  	
  		    $("#costcentergroup_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#costcentergroup_list").jqGrid('navGrid', "#costcentergroup_list_pager", {edit: false, add: false, del: false, search: false});  		    
  		    //$("#costcentergroup_list").jqGrid('navGrid',"#costcentergroup_list_pager").jqGrid('navButtonAdd',"#costcentergroup_list_pager",{caption:"UpdateVertical", buttonicon:"ui-icon-document", onClickButton:editCostCenterGroup, position: "last", title:"updateVertical", cursor: "pointer"}); 
          	    <sec:ifAnyGranted roles="ROLE_FINANCE">

				$("#costcentergroup_list").jqGrid('navGrid',"#costcentergroup_list_pager").jqGrid('navButtonAdd',"#costcentergroup_list_pager",{caption:"NewVertical", buttonicon:"ui-icon-document", onClickButton:newCostCenterGroup, position: "last", title:"NewVertical", cursor: "pointer"});				
				jQuery("#costcentergroup_list").jqGrid('navGrid',"#costcentergroup_list_pager").jqGrid('navButtonAdd',"#costcentergroup_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
			   onClickButton : function () {
			   var url = "exportCostCenterGroupEntries";
				jQuery("#costcentergroup_list").jqGrid('excelExport',{"url":url});
			   }
			});
  		    	//$("#costcentergroup_list").jqGrid('navGrid',"#costcentergroup_list_pager").jqGrid('navButtonAdd',"#costcentergroup_list_pager",{caption:"GenerateLoginId", buttonicon:"ui-icon-gear", onClickButton:generateCGOLoginId, position: "last", title:"Generate Login Id", cursor: "pointer"}); 
			$("#costcentergroup_list").jqGrid('navGrid',"#costcentergroup_list_pager").jqGrid('navButtonAdd',"#costcentergroup_list_pager",{caption:"UnlockUser", buttonicon:"ui-icon-unlocked", onClickButton:unlockVH, position: "last", title:"UnlockUser", cursor: "pointer"});
  		    </sec:ifAnyGranted>

	function unlockVH() {
		var answer = confirm("This action would reset the password of the user to harekrishna ! Are you sure?");
		if (answer){
			var idlist = $('#costcentergroup_list').jqGrid('getGridParam','selrow');
			if(idlist) {
				var url = "${createLink(controller:'project',action:'unlockAndResetVH')}"+"?idlist="+idlist
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
                    
                    function newCostCenterGroup()
                     { 
                     $("#dialogNewCostCenterGroupForm").dialog("open");
                     }
                    
                    $("#dialogNewCostCenterGroupForm").dialog({
                        autoOpen: false,
                        modal: true,
                        buttons:
                        {
                            "Submit": function()
                            {
			      var url = "${createLink(controller:'Project',action:'addCostCenterGroup')}";

			      // gather the form data
			      var data=$("#addCostCenterGroup").serialize();
			      // post data
			      $.post(url, data , function(returnData){
					  //alert(returnData);
					  $( "#dialogNewCostCenterGroupForm" ).dialog( "close" );
					  jQuery("#costcentergroup_list").jqGrid().trigger("reloadGrid");
					})
						                         
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
                      });              
                     function editCostCenterGroup()
                     {
                        $("#dialogEditCostCenterGroupForm").dialog("open");
                       }  
                       
                  $("#dialogEditCostCenterGroupForm").dialog({
                        autoOpen: false,
                        height: 500,
                        width: 600,
                        modal: true,
                        buttons:
                        {
                            "Update": function()
                            {
                         
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
                      });            
  		    	
  	
  	
                  jQuery("#costcenter_list").jqGrid({
  		     url:"${createLink(controller:'Project',action:'jq_costcenter_list')}",
		     editurl:"${createLink(controller:'Project',action:'jq_edit_costcenter')}",	                    
	             datatype:"json",
  	 	  
  	            colNames:['Name','Alias','Owner','Phone','Email','LoginId','Id'],
  		      colModel:[
  			{name:'name',search: true, editable: true,
				formatter:'showlink', 
	             		formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'CostCenter',action:'show')}'}
	             	},
  			{name:'alias',search: true, editable: true},
  			{name:'owner',search: true, editable: true,
				formatter:'showlink', 
	             		formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'CostCenter',action:'showOwner')}'}
  			},
  			{name:'phone',search: true, editable: true},
  			{name:'emailContact',search: true, editable: true},
  			{name:'loginid',search: true, editable: true},
  			{name:'id',hidden:true}  			
  		     ], 
  		    rowNum:10,
  		    rowList:[5,10,20,30,40,50,100],
  		    pager:'#costcenter_list_pager',
  		    viewrecords: true,
  		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
  		    caption:"List of departments",
  		    });
  		   
  		   $("#costcenter_list").jqGrid('filterToolbar',{autosearch:true});
  		   $("#costcenter_list").jqGrid('navGrid', "#costcenter_list_pager", {edit: false, add: false, del: false, search: false});  		    
  		   //$("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"EditCostCenter", buttonicon:"ui-icon-document", onClickButton:editCostCenter, position: "last", title:"editCostCenter", cursor: "pointer"}); 
          	    <sec:ifAnyGranted roles="ROLE_FINANCE">
  		   	$("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"NewCostCenter", buttonicon:"ui-icon-document", onClickButton:newCostCenter, position: "last", title:"NewCostCenter", cursor: "pointer"}); 
			
			jQuery("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	   onClickButton : function () {
	   var url = "exportCostCenterEntries";
		jQuery("#costcenter_list").jqGrid('excelExport',{"url":url});
	   }
	});
  		   	//$("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"GenerateLoginId", buttonicon:"ui-icon-gear", onClickButton:generateCCLoginid, position: "last", title:"Generate LoginId", cursor: "pointer"}); 
			$("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"UnlockUser", buttonicon:"ui-icon-unlocked", onClickButton:unlockHOD, position: "last", title:"UnlockUser", cursor: "pointer"});
  		    </sec:ifAnyGranted>
                    
	function unlockHOD() {
		var answer = confirm("This action would reset the password of the user to harekrishna ! Are you sure?");
		if (answer){
			var idlist = $('#costcenter_list').jqGrid('getGridParam','selrow');
			if(idlist) {
				var url = "${createLink(controller:'project',action:'unlockAndResetHOD')}"+"?idlist="+idlist
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

                   function newCostCenter()
                    { 
                    $("#dialogNewCostCenterForm").dialog("open");
                    }
            
            
                $("#dialogNewCostCenterForm").dialog({
                        autoOpen: false,
                        height: 300,
                        width: 600,
                        modal: true,
                        buttons:
                        {
                            "Submit": function()
                            {
			      var url = "${createLink(controller:'Project',action:'addCostCenter')}";

			      // gather the form data
			      var data=$("#addcostcenter").serialize();
			      // post data
			      $.post(url, data , function(returnData){
					  //alert(returnData);
					  $( "#dialogNewCostCenterForm" ).dialog( "close" );
					  jQuery("#costcenter_list").jqGrid().trigger("reloadGrid");
					})
						                         
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
                      });                 
                     function editCostCenter()
                     {
                     $("#dialogEditCostCenterForm").dialog("open");
                       } 
                       
                     $("#dialogEditCostCenterForm").dialog({
                        autoOpen: false,
                        height: 500,
                        width: 600,
                        modal: true,
                        buttons:
                        {
                            "Submit": function()
                            {
                              
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
                      });                    
  		    
	function generateCGOLoginId(){
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#costcentergroup_list').jqGrid('getGridParam','selrow');
			if(id) {
			        var url = "${createLink(controller:'Project',action:'generateCGOLoginId')}"+"?cgid="+id;
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#costcentergroup_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a vertical!!");
		} else {
		    return false;
		}
	}
  		       
	function generateCCLoginid(){
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#costcenter_list').jqGrid('getGridParam','selrow');
			if(id) {
			        var url = "${createLink(controller:'Project',action:'generateCCLoginid')}"+"?ccid="+id;
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#costcenter_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a department!!");
		} else {
		    return false;
		}
	}
  		 });    
  		</script>
  
  
  
  	</body>
  </html>
