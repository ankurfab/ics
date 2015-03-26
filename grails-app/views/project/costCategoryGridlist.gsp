
  
  <%@ page import="ics.CostCategory" %>
  <%@ page import="ics.CostCenter" %>
  <!doctype html>
  <html>
  	<head>
  		<meta name="layout" content="main">
  		<title>Cost Category Master</title>
   
  		<r:require module="grid" />
  	</head>
  	<body>  		
  		<div id="dialogNewCostCategoryForm" title="Add New Cost Category">
			 <g:form name="addCostCategory" controller="project" action="" method="POST">
			 <g:render template="addCostCategory" />	         
			</g:form>
                </div> 
                
                <div id="dialogEditCostCategoryForm" title="Update Cost Category">
			 <g:form name="addCostCategory" controller="project" action="" method="POST">
			 <g:render template="addCostCategory" />	         
			</g:form>
                </div>           
                
  		
  		<div id="dialogNewCostCenterForm" title="Add New Cost Center">
		        <g:form name="addcostcenter" controller="project" action="" method="POST">
		            <g:render template="addCostCenter" /> 
		        </g:form>
                </div> 
                
             <div id="dialogEditCostCenterForm" title="Update Cost Center">
		        <g:form name="addcostcenter" controller="project" action="" method="POST">
		            <g:render template="addCostCenter" /> 
		        </g:form>
                </div> 
                
                
  		<!-- table tag will hold our grid -->
  		<table id="costcategory_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="costcategory_list_pager" class="scroll" style="text-align:center;"></div>
  		
  		<!-- table tag will hold our grid -->
		<table id="costcenter_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
       		<!-- pager will hold our paginator -->
  		<div id="costcenter_list_pager" class="scroll" style="text-align:center;"></div>
  
            <script type="text/javascript">		
  		  $(document).ready(function () {
  		    jQuery("#costcategory_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_costcategory_list')}",
		      editurl:"${createLink(controller:'Project',action:'jq_edit_costcategory')}",	                    
	               datatype:"json",
  	 	   
  	            colNames:['Name','Alias','Owner','Phone','Email','Id'],
  		      colModel:[
  			{name:'name',search: true, editable: true,
				formatter:'showlink', 
	             		formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'CostCategory',action:'show')}'}
  			},
  			{name:'alias',search: true, editable: true},
  			{name:'owner',search: true, editable: true},
  			{name:'phone',search: true, editable: true},
  			{name:'emailcontact',search: true, editable: true},  			
  			{name:'id',hidden:true}  				
  		     ], 
  		    rowNum:10,
  		    rowList:[5,10,20],
  		    pager:'#costcategory_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'name',
		    sortorder: "asc",
  		    caption:" Cost Category List",  	  
  	            onSelectRow: function(ids) { 
			   if(ids!='new_row')
			   { 	    	      
			   var selName = jQuery('#costcategory_list').jqGrid('getCell', ids, 'name'); 
			   var url = "${createLink(controller:'Project',action:'jq_costcenter_list')}"+"?ccatid="+ids;
			   jQuery("#costcenter_list").jqGrid('setGridParam',{url:url});
			   var editurl = "${createLink(controller:'Project',action:'jq_edit_costcenter')}"+"?ccatid="+ids;
			   jQuery("#costcenter_list").jqGrid('setGridParam',{editurl:url});
			   jQuery("#costcenter_list").jqGrid('setCaption',"Cost Centers Under Category : "+selName).trigger('reloadGrid');   	
			     }
	                }
                   });		   
  		   
  		    $("#costcategory_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#costcategory_list").jqGrid('navGrid', "#costcategory_list_pager", {edit: true, add: true, del: true, search: true});
  		    $("#costcategory_list").jqGrid('navGrid',"#costcategory_list_pager").jqGrid('navButtonAdd',"#costcategory_list_pager",{caption:"NewCostCategory", buttonicon:"ui-icon-document", onClickButton:newCostCategory, position: "last", title:"newCostCategory", cursor: "pointer"}); 
  		    $("#costcategory_list").jqGrid('navGrid',"#costcategory_list_pager").jqGrid('navButtonAdd',"#costcategory_list_pager",{caption:"EditCostCategory", buttonicon:"ui-icon-document", onClickButton:editCostCategory, position: "last", title:"editCostCategory", cursor: "pointer"}); 
                  
                   function newCostCategory()
                     {
                      $("#dialogNewCostCategoryForm").dialog("open");
                     }
                
                $("#dialogNewCostCategoryForm").dialog({
                        autoOpen: false,
                        height: 500,
                        width: 600,
                        modal: true,
                        buttons:
                        {
                            "Submit": function()
                            {
                                //$('#addcostCategoryformform').submit();
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
                      });
                      
                     function editCostCategory()
                     {
                      $("#dialogEditCostCategoryForm").dialog("open");
                       }
                  $("#dialogEditCostCategoryForm").dialog({
                        autoOpen: false,
                        height: 500,
                        width: 600,
                        modal: true,
                        buttons:
                        {
                            "Update": function()
                            {
                                //$('#addcostCategoryformform').submit();
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
  	 	  
  	            colNames:['Name','Alias','Owner','Phone','Email','Id'],
  		      colModel:[
  			{name:'name',search: true, editable: true,
				formatter:'showlink', 
	             		formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'CostCenter',action:'show')}'}
	             	},
  			{name:'alias',search: true, editable: true},
  			{name:'owner',search: true, editable: true},
  			{name:'phone',search: true, editable: true},
  			{name:'emailContact',search: true, editable: true},
  			{name:'id',hidden:true}
  			
  		     ], 
  		    rowNum:10,
  		    rowList:[10,20,30,40,50,100],
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
  		    caption:" Cost Center  List"
  		    });
  	
  		    $("#costcenter_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#costcenter_list").jqGrid('navGrid', "#costcenter_list_pager", {edit: true, add: true, del: true, search: true});  		    
  		    $("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"NewCostCenter", buttonicon:"ui-icon-document", onClickButton:newCostCostCenter, position: "last", title:"newCostCenter", cursor: "pointer"}); 
  		    $("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"EditCostCategory", buttonicon:"ui-icon-document", onClickButton:updateCostCenter, position: "last", title:"updateCostCenter", cursor: "pointer"}); 
                    
                    function newCostCostCenter()
                     { 
                      $("#dialogNewCostCenterForm").dialog("open");
                     }
                     
                     
                      $("#dialogNewCostCenterForm").dialog({
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
                      
             
                     
                     function updateCostCenter()
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
                            "Update": function()
                            {
                              
                                $(this).dialog("close");
                            },
                            "Cancel": function() {
                                $(this).dialog("close");
                            }
                        }
                      });
                         
  		    
  		    
  		    
  		    
  		 });    
  		</script>
  
  
  
  	</body>
  </html>
