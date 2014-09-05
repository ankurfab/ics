
<%@ page import="ics.GiftIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'giftIssued.label', default: 'GiftIssued')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">

    </head>
    <body>

    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#sIssueDate").datepicker({dateFormat: 'dd-mm-yy'});
        })
    </script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
	    <a href="javascript:toggleSearchParams()">Search Parameters </a>
	    
	    <div id='div-search' class="dialog" style="display: none">

            <g:if test="${!cheque}">
		<g:form name="searchForm" action="search" >
               	<table>
                    <thead>
	                        <tr>
	                        <td>Donor Legal Name</td>
	                        <td><g:textField name="sDonorLegalName" /></td>
				</tr>
	                        <tr>
	                        <td>Donor Initiated Name</td>
	                        <td><g:textField name="sDonorInitName" /></td>
				</tr>
	                        <tr>
	                        <td>Gift Name</td>
	                        <td><g:textField name="sGiftName" /></td>
				</tr>
	                        <tr>
	                        <td>Issuer Legal Name</td>
	                        <td><g:textField name="sIssuedByLegalName" /></td>
				</tr>
	                        <tr>
	                        <tr>
	                        <td>Issuer Initiated Name</td>
	                        <td><g:textField name="sIssuedByInitName" /></td>
	                        </tr>
	                        <tr>
	                        <td>Issue Date</td>
	                        <td><g:textField name="sIssueDate" /></td>
				</tr>
				<tr>
	                        <td>Comments</td>
	                        <td><g:textField name="sComments" /></td>
				</tr>
			</thead>
		</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
                <br>
		</g:form>
            </g:if>
            </div>

            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'giftIssued.id.label', default: 'Id')}" />
                        
                            <th><g:message code="giftIssued.gift.label" default="Gift" /></th>
                        
                            <th><g:message code="giftIssued.issuedTo.label" default="Issued To" /></th>
                        
                            <g:sortableColumn property="issueDate" title="${message(code: 'giftIssued.issueDate.label', default: 'Issue Date')}" />
                        
                            <g:sortableColumn property="issuedQty" title="${message(code: 'giftIssued.issuedQty.label', default: 'Issued Qty')}" />
                        
                            <th><g:message code="giftIssued.issuedBy.label" default="Issued By" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${giftIssuedInstanceList}" status="i" var="giftIssuedInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${giftIssuedInstance.id}">${fieldValue(bean: giftIssuedInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: giftIssuedInstance, field: "gift")}</td>
                        
                            <td>${fieldValue(bean: giftIssuedInstance, field: "issuedTo")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${giftIssuedInstance.issueDate}" /></td>
                        
                            <td>${fieldValue(bean: giftIssuedInstance, field: "issuedQty")}</td>
                        
                            <td>${fieldValue(bean: giftIssuedInstance, field: "issuedBy")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${!search}">
            <div class="paginateButtons">
                <g:paginate total="${giftIssuedInstanceTotal}" />
            </div>
            </g:if>
        </div>

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
	</script>

    </body>
</html>
