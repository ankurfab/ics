
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="reminders.list" default="Reminders List" /></title>
	<r:require module="grid" />
    <r:require module="export"/>    
        <export:resource />
        <style>
        td{vertical-align:top;}
        </style>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            
            <span class="menuButton"><g:link class="list" controller="schemeMember" action="list"><g:message code="schememMembers.list" default="Scheme Members List" /></g:link></span>                
        </div>
        <div class="body">
            <h1><g:message code="reminders.list" default="Reminders List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
		  <div>
        
    <table>
    <tr>
      <td>        
        <!-- table tag will hold our grid -->
        <table id="profile_complete_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="profile_complete_pager" class="scroll" style="text-align:center;"></div>

      </td>
      <td>
        <table id="concernToAddress_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="concernToAddress_pager" class="scroll" style="text-align:center;"></div>
      </td>
    </tr>
    <tr>
      <td>
         <table id="prospects_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="prospects_pager" class="scroll" style="text-align:center;"></div>
      </td>
      <td>
         <table id="recentbirthday_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="recentbirthday_pager" class="scroll" style="text-align:center;"></div>
      </td>
    </tr>
    </table>
    
		</div>
        </div>
        
<script type="text/javascript">

  jQuery(document).ready(function () {
    jQuery("#profile_complete_list").jqGrid({
      url:'${createLink(controller:'schemeMember',action:'notcompleteprofiles_list')}',
      postData:{isProfileComplete:function(){return "false";}},
      datatype: "json",
      colNames:['Member','Status','RecentCommunication','center','isProfileComplete','id'],
      colModel:[	
	{name:'member',search:true,formatter:'showlink',
	formatoptions:{baseLinkUrl:'${createLink(controller:'schemeMember',action:'show')}',target:'_blank'}
	},
	{name:'status',search:false},	
	{name:'recentCommunication',search:false},  
  {name:'center',search:false},
  {name:'isProfileComplete',search:false},
	{name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30,40,50,100],
    pager: '#profile_complete_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'member',
    sortorder: "asc",
    width: 600,
    height: "100%",
    caption:"Not Yet Complete Profile List"
    });
    

     jQuery("#concernToAddress_list").jqGrid({
      url:'${createLink(controller:'schemeMember',action:'concernToAddress_list')}',      
      datatype: "json",
      colNames:['Member','Status','RecentCommunication','center','ConcernToAddress','id'],
      colModel:[  
  {name:'member',search:true,formatter:'showlink',
  formatoptions:{baseLinkUrl:'${createLink(controller:'schemeMember',action:'show')}',target:'_blank'}
  },
  {name:'status',search:false}, 
  {name:'recentCommunication',search:false},  
  {name:'center',search:false},
  {name:'ConcernToAddress',search:false},
  {name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30,40,50,100],
    pager: '#concernToAddress_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'member',
    sortorder: "asc",
    width: 600,
    height: "100%",
    caption:"Concern To Address List"
    });

     jQuery("#prospects_list").jqGrid({
      url:'${createLink(controller:'schemeMember',action:'prospects_list')}',      
      datatype: "json",
      colNames:['Member','Status','RecentCommunication','center','Future Start Date','id'],
      colModel:[  
  {name:'member',search:true,formatter:'showlink',
  formatoptions:{baseLinkUrl:'${createLink(controller:'schemeMember',action:'show')}',target:'_blank'}
  },
  {name:'status',search:false}, 
  {name:'recentCommunication',search:false},  
  {name:'center',search:false},
  {name:'futureStartDate',search:false},
  {name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30,40,50,100],
    pager: '#prospects_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'member',
    sortorder: "asc",
    width: 600,
    height: "100%",
    caption:"Prospects List"
    });
    
    jQuery("#recentbirthday_list").jqGrid({
      url:'${createLink(controller:'schemeMember',action:'recentbirthday_list')}',      
      datatype: "json",
      colNames:['Member','Status','RecentCommunication','center','Birthday','id'],
      colModel:[  
  {name:'member',search:true,formatter:'showlink',
  formatoptions:{baseLinkUrl:'${createLink(controller:'schemeMember',action:'show')}',target:'_blank'}
  },
  {name:'status',search:false}, 
  {name:'recentCommunication',search:false},  
  {name:'center',search:false},
  {name:'dob',search:false},
  {name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30,40,50,100],
    pager: '#recentbirthday_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'member',
    sortorder: "asc",
    width: 600,
    height: "100%",
    caption:"Recent Birthday List(within two months)"
    });
    
    });


</script>

        
    </body>
</html>
