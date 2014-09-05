
<%@ page import="ics.Followup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'followup.label', default: 'Followup')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
          <r:require module="grid" />

  </head>
    <body>

      <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
      	<g:javascript src="jquery.jqGrid.min.js"/>
      	<g:javascript src="grid.locale-en.js"/>
    	<g:javascript src="jquery-ui-timepicker-addon.js" />
	

      <script type="text/javascript">
          jQuery(document).ready(function()
          {
            $("#sstartDate").datepicker({dateFormat: 'dd-mm-yy'});
            $("#endDate").datepicker({dateFormat: 'dd-mm-yy'});
            $("#sstartDate1").datepicker({dateFormat: 'dd-mm-yy'});
            $("#endDate1").datepicker({dateFormat: 'dd-mm-yy'});
            
          });
      </script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
       </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            	   <!-- <a href="javascript:toggleSearchParams()">Search Parameters </a>-->
<!--//***************************************Search Parameter*************************************//-->
	    
	    <!--<div id='div-search' class="dialog" style="display: none">

            <g:if test="${!cheque}">
		<g:form name="searchForm" action="search" >
               	<g:hiddenField name="ExactFW" value="LikeFW" />
               	<g:hiddenField name="ExactFB" value="LikeFB" />
               	<g:hiddenField name="ExactDEC" value="LikeDEC" />
               	<g:hiddenField name="ExactCAT" value="LikeCAT" />               	
               	<g:hiddenField name="ExactREF" value="LikeREF" />               	
               	<g:hiddenField name="Rangeed" value="NoRange" />    
               	<g:hiddenField name="Rangesd" value="NoRange" />                   	

               	<table>
                    <thead>
	                                     
	                        <tr>
	                        <td>Followup With</td>
	                        <td><g:textField name="followupwith" /></td>
				<td>Exact <g:checkBox name="ExactFW1" onClick="checkActual() "  /></td>	                        
	                        
				</tr>
	                        <tr>
	                        <td>Followup By</td>
	                        <td><g:textField name="followupby" /></td>
				<td>Exact <g:checkBox name="ExactFB1" onClick="checkActual() "  /></td>	                        
	                        
				</tr>

	                        <tr>
	                        <td>Start Date</td>
	                        <td>FROM<g:textField name="sstartDate" /></td></tr>
	                        <tr><td></td><td>To  <g:textField name="sstartDate1" /></td>
				<td>Range <g:checkBox name="Rangesd1" onClick="checkRange() "  /></td>	                        	                        
				</tr>
	                        <tr>
	                        <td>End Date</td>
	                        <td>FROM<g:textField name="endDate" /></td></tr>
	                        <tr><td></td><td>To  <g:textField name="endDate1" /></td>
				<td>Range <g:checkBox name="Rangeed1" onClick="checkRange() "  /></td>	                        	                        
				</tr>


	                        <tr>
	                        <td>Category</td>
	                        <td><g:textField name="category" /></td>
				<td>Exact <g:checkBox name="ExactCAT1" onClick="checkActual() "  /></td>	                        
	                        
				</tr>
	                        <tr>
	                        <td>Reference</td>
	                        <td><g:textField name="ref" /></td>
			
				<td>Exact <g:checkBox name="ExactREF1" onClick="checkActual() "  /></td>
	                        
				</tr>
	                        <tr>
	                        <td>Description</td>
	                        <td><g:textField name="description" /></td>
				<td>Exact <g:checkBox name="ExactDEC1" onClick="checkActual() "  /></td>	                        
	                        
				</tr>
				<tr>
	                        <td> Comments</td>
	                        <td><g:textField name="Comments" /></td>
				</tr>
	                        <tr>
			</thead>
		</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
                <br>
		</g:form>
            </g:if>
            </div>-->


<!--//****************************************List***********************************************8//-->
            <!--<div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'followup.id.label', default: 'Id')}" />
                        
                            <th><g:message code="followup.followupWith.label" default="Followup With" /></th>
                   	    
                            <th><g:message code="followup.followupBy.label" default="Followup By" /></th>
                   	    
                            <g:sortableColumn property="startDate" title="${message(code: 'followup.startDate.label', default: 'Start Date')}" />
                        
                            <g:sortableColumn property="endDate" title="${message(code: 'followup.endDate.label', default: 'End Date')}" />
                        
                            <g:sortableColumn property="category" title="${message(code: 'followup.category.label', default: 'Category')}" />
                        
                            <g:sortableColumn property="ref" title="${message(code: 'followup.ref.label', default: 'Reference')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${followupInstanceList}" status="i" var="followupInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${followupInstance.id}">${fieldValue(bean: followupInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: followupInstance, field: "followupWith")}</td>
                        
                            <td>${fieldValue(bean: followupInstance, field: "followupBy")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${followupInstance.startDate}" /></td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${followupInstance.endDate}" /></td>
                        
                            <td>${fieldValue(bean: followupInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: followupInstance, field: "ref")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${!search}">
            <div class="paginateButtons">
                <g:paginate total="${followupInstanceTotal}" />
            </div>
            </g:if>-->

	<g:render template="followupGrid1"/>

        <script language="javascript"> 
	    function toggleSearchParams() {
		var ele = document.getElementById("div-search");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
	    } 
	    
	    function checkActual() {
		var cb = document.getElementById('ExactFW1');
		var cb1 = document.getElementById('ExactFB1');
		var flag = document.getElementById('ExactFW');
		var flag1 = document.getElementById('ExactFB');

		var cb2 = document.getElementById('ExactDEC1');
		var cb3 = document.getElementById('ExactCAT1');
		var flag2 = document.getElementById('ExactDEC');
		var flag3 = document.getElementById('ExactCAT');

		var ref = document.getElementById('ExactREF1');	    		
		var flagref = document.getElementById('ExactREF');			


		if (cb.checked)
		{flag.value = "ExactFW";}
		else
			{flag.value = "LikeFW";}
		if (cb1.checked)
		{flag1.value = "ExactFB";}
		else
			{flag1.value = "LikeFB";}	   

		if (cb2.checked)
		{flag2.value = "ExactDEC";}
		else
			{flag2.value = "LikeDEC";}
		if (cb3.checked)
		{flag3.value = "ExactCAT";}
		else
			{flag3.value = "LikeCAT";}

		if (ref.checked)
		{flagref.value = "ExactREF";}
		else
			{flagref.value = "LikeREF";}

	    } 
	    function checkRange() {

		var rged = document.getElementById('Rangeed1');
		var rgflaged = document.getElementById('Rangeed');

		var rgsd = document.getElementById('Rangesd1');
		var rgflagsd = document.getElementById('Rangesd');

		if (rged.checked)
		{rgflaged.value = "Range";}
		else
			{rgflaged.value = "NoRange";}

		if (rgsd.checked)
		{rgflagsd.value = "Range";}
		else
			{rgflagsd.value = "NoRange";}

		}



	    	    
	</script>



    </body>
</html>
