
<%@ page import="com.krishna.IcsUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'icsUser.label', default: 'IcsUser')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" controller="individual" action="create">New Individual</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

		<div id='message' class="message" style="display:none;"></div>

		<!-- table tag will hold our grid -->
		<table id="user_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="user_list_pager" class="scroll" style="text-align:center;"></div>

		<input class="menuButton" type="BUTTON" id="disableBtn" value="Disable" />
		<input class="menuButton" type="BUTTON" id="enableBtn" value="Enable" />

        </div>

		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {		    
		    jQuery("#user_list").jqGrid({
		      url:'jq_user_list',
		      datatype: "json",
		      colNames:['LegalName','InitiatedName','LoginId','Role(s)','id'],
		      colModel:[
			{name:'legal_name', search:true},
			{name:'initiated_name', search:true},
			{name:'username', search:true,
				formatter:'showlink', 
				formatoptions:{baseLinkUrl:'show'}},
			{name:'authority', search:true},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager:'#user_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    multiselect: true,
		    width: 1200,
		    height: "100%",
		    caption:"User List"
		    });

		    $("#user_list").jqGrid('filterToolbar',{autosearch:true});
		    $("#user_list").jqGrid('navGrid',"#user_list_pager",
			{add:false,edit:false,del:false, search: false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
		    );

		$( "#disableBtn" )
			.button()
			.click(function() {
				var idlist = jQuery("#user_list").jqGrid('getGridParam','selarrrow');
				if(idlist!='')
					{
					var url = "${createLink(controller:'IcsUser',action:'status')}"+'?status=false&idlist='+idlist
					$.getJSON(url, function(data) {
						alert(data.message);
					    });
					}
				else
					alert("Select at least 1 row!!");				
			});

		$( "#enableBtn" )
			.button()
			.click(function() {
				var idlist = jQuery("#user_list").jqGrid('getGridParam','selarrrow');
				if(idlist!='')
					{
					var url = "${createLink(controller:'IcsUser',action:'status')}"+'?status=true&idlist='+idlist
					$.getJSON(url, function(data) {
						alert(data.message);
					    });
					}
				else
					alert("Select at least 1 row!!");				
			});
	        });

		// ]]></script>


    </body>
</html>
