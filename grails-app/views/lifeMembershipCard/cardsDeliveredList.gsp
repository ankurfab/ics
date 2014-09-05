

<%@ page import="ics.LifeMembershipCard" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'lifeMembershipCard.label', default: 'LifePatronCard')}" />
		<title>Cards Delivered List</title>
		<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
		<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
		<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
	</head>
	<body>
		<g:javascript src="datatable/jquery.dataTables.min.js" />    
		<g:javascript src="datatable/ZeroClipboard.js" />    
		<g:javascript src="datatable/TableTools.min.js" />    

		<script type="text/javascript" charset="utf-8">
			$(document).ready( function () {
			    $('#example').dataTable( {
				"sDom": 'T<"clear">lfrtip',
				"oTableTools": {
				    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"		    
				}
			    } );
			} );

		</script>    
	
		<!--<a href="#list-lifeMembershipCard" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>-->
		<div class="nav" role="navigation">
			<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            		<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>		
            		<span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>	
            		<span class="menuButton"><g:link class="list" action="formsSubmittedList">'Forms Submitted by Patron Care Dept To NVCC' List</g:link></span>	
            		<span class="menuButton"><g:link class="list" action="formsSentToJuhuList">'Forms Sent to Juhu' List</g:link></span>	
            		<sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
            			<span class="menuButton"><g:link class="list" action="cardsArrivedList">'Cards Arrived' List</g:link></span>
            		</sec:ifNotGranted>
            		<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
            			<span class="menuButton"><g:link class="list" action="cardsArrivedList" params="['acOriginatingDeptCollector_id': session.individualid]">'Cards Arrived' List</g:link></span>
            		</sec:ifAnyGranted>
            		
            		<!--<span class="menuButton"><g:link class="list" action="cardsDelivery">'Cards Arrived' List</g:link></span>
            		-->

			<!--<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>-->
		</div>
		<div id="cardsArrivedList-lifeMembershipCard" class="content scaffold-cardsArrivedList" role="main">
			<h1>Cards Delivered List</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="example">
				<thead>
					<tr>
					
						<!--<g:sortableColumn property="lifeMembershipCardNumber" title="${message(code: 'lifeMembershipCard.lifeMembershipCardNumber.label', default: 'Life Membership Card Number')}" />
					
						<th><g:message code="lifeMembershipCard.lifeMember.label" default="Life Patron" /></th>
					
						<th><g:message code="lifeMembershipCard.originatingDeptCollector.label" default="Originating Dept Collector" /></th>
					
						<th><g:message code="lifeMembershipCard.forwardingDeptRepresentative.label" default="Forwarding Dept Representative" /></th>
					
						<g:sortableColumn property="acceptedByOriginatingDept" title="${message(code: 'lifeMembershipCard.acceptedByOriginatingDept.label', default: 'Accepted By Originating Dept')}" />
					
						<g:sortableColumn property="dateFormSubmissionOriginatingDeptToForwardingDept" title="${message(code: 'lifeMembershipCard.dateFormSubmissionOriginatingDeptToForwardingDept.label', default: 'Date Form Submission Originating Dept To Forwarding Dept')}" />-->
						
						<g:sortableColumn property="id" title="${message(code: 'lifeMembershipCard.id.label', default: 'Life Patron Card Id')}" />
						
						<g:sortableColumn property="lifeMembershipCardNumber" title="${message(code: 'lifeMembershipCard.lifeMembershipCardNumber.label', default: 'Life Patron Card Number')}" />
					
						<th><g:message code="lifeMembershipCard.lifeMember.label" default="Life Patron" /></th>
					
						<th>Patron Care Dept Collector</th>
					
						<th>NVCC Representative</th>
					
						<th>Card Status</th>
						
						<!--<th> <g:checkBox name="checkAll" value="SelectAll" checked="false" onclick="checkUncheckAll()"/> Check All</th>
						-->

					</tr>
				</thead>
				<tbody>
				<g:each in="${cardsDeliveredList}" status="i" var="lifeMembershipCardInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${lifeMembershipCardInstance.id}">${fieldValue(bean: lifeMembershipCardInstance, field: "id")}</g:link></td>
					
						<td>${fieldValue(bean: lifeMembershipCardInstance, field: "lifeMembershipCardNumber")}</td>
						
						<td>${fieldValue(bean: lifeMembershipCardInstance, field: "lifeMember")}</td>
					
						<td>${fieldValue(bean: lifeMembershipCardInstance, field: "originatingDeptCollector")}</td>
					
						<td>${fieldValue(bean: lifeMembershipCardInstance, field: "forwardingDeptRepresentative")}</td>
					
						<td>${lifeMembershipCardInstance.cardStatus}
							<g:if test="${lifeMembershipCardInstance.cardStatus == 'Card Delivered'}">
								on ${(lifeMembershipCardInstance.dateCardDelivery)?.format('dd-MM-yyyy')}
							</g:if>
						</td>
						
						<!--<td><g:checkBox name="cardDelivered" value="${lifeMembershipCardInstance?.id}" checked="false" /></td>
						-->
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cardsDeliveredListTotal}" />
			</div>
			<!--<br>
			    <div class="buttons">
				<g:form name="markAsCardsDeliveredForm" controller="lifeMembershipCard" action="markAsCardsDelivered" >
					<g:hiddenField name="lifePatronCardIds" id="lifePatronCardIds" value=""/>
					<span class="button"><g:actionSubmit name="markAsCardDelivered" class="save" action="markAsCardsDelivered" onclick="markAsCardsDelivered()" value="Mark as 'Card Delivered'" /></span>
				</g:form>
			    </div>
			-->
		</div>
		<script language="javascript"> 		
			function checkUncheckAll()
			{
				var cardDeliveredChkBoxes = document.getElementsByName("cardDelivered");
				var checkedAll = document.getElementById("checkAll");

				if(checkedAll.checked == true)
				{
					for(i=0; i< cardDeliveredChkBoxes.length; i++)
						cardDeliveredChkBoxes[i].checked = true;
				}
				else
				{
					for(i=0; i< cardDeliveredChkBoxes.length; i++)
						cardDeliveredChkBoxes[i].checked = false;
				}
			}

		</script>
		<g:javascript>
			function markAsCardsDelivered()
			{
				var CardDeliveredChkBoxes = document.getElementsByName("cardDelivered");
				var lifePatronCardIds = new Array();

				for(i=0; i< CardDeliveredChkBoxes.length; i++)
				{
					if(CardDeliveredChkBoxes[i].checked == true)
						lifePatronCardIds[i] = CardDeliveredChkBoxes[i].value;
				}
				if(lifePatronCardIds.length == 0)
				{
					alert("Please select records(s) to be marked as 'Card Delivered");
					return false;
				}
				else
				{
					document.getElementById("lifePatronCardIds").value = lifePatronCardIds;
					return true;
				}
			}

		</g:javascript>		
	</body>
</html>
		