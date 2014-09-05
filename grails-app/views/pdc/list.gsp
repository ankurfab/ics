
<%@ page import="ics.Pdc" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pdc.label', default: 'Pdc')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
    </head>
    <body>
    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#sChequeDate").datepicker({yearRange: "-1:+0",dateFormat: 'dd-mm-yy'});
          $("#sReceiptDate").datepicker({yearRange: "-1:+0",dateFormat: 'dd-mm-yy'});
        })
    </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list">List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
	    <a href="javascript:toggleSearchParams()">Search Parameters </a>
	    
	    <div id='div-search' class="dialog" style="display: none">

		<g:form name="searchForm" action="search" >
               	<table>
                    <thead>
	                        <tr>
	                        <td>Issuer Name</td>
	                        <td><g:textField name="sIssName" value="${searchparams?.sIssName}" /></td>
				</tr>
	                        <tr>
	                        <td>Cheque No</td>
	                        <td><g:textField name="sChequeNo" value="${searchparams?.sChequeNo}" /></td>
				</tr>
	                        <tr>
	                        <tr>
	                        <td>Cheque Date</td>
	                        <td><g:textField name="sChequeDate" value="${searchparams?.sChequeDate}" /></td>
				</tr>
	                        <tr>
	                        <td>Bank Name</td>
	                        <td><g:textField name="sBankName" value="${searchparams?.sBankName}" /></td>
				</tr>
	                        <tr>
	                        <td>Branch</td>
	                        <td><g:textField name="sBranch" value="${searchparams?.sBranch}" /></td>
				</tr>
	                        <tr>
	                        <tr>
	                        <td>Amount</td>
	                        <td><g:textField name="sAmount" value="${searchparams?.sAmount}" /></td>
	                        </tr>
	                        <tr>
	                        <td>Collected By</td>
	                        <td><g:textField name="sCollector" value="${searchparams?.sCollector}" /></td>
	                        </tr>
	                        <tr>
	                        <td>Received By</td>
	                        <td><g:textField name="sReceiver" value="${searchparams?.sReceiver}" /></td>
	                        </tr>
	                        <tr>
	                        <td>Receipt Date</td>
	                        <td><g:textField name="sReceiptDate" value="${searchparams?.sReceiptDate}" /></td>
	                        </tr>
	                        <tr>
	                        <td>Comments</td>
	                        <td><g:textField name="sComments" value="${searchparams?.sComments}" /></td>
				</tr>
				<tr>
	                        <td>Status</td>
	                        <td><g:textField name="sStatus" value="${searchparams?.sStatus}"/></td>
				</tr>
			</thead>
		</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
                <br>
		</g:form>
            </div>

            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}"  property="id" title="${message(code: 'pdc.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}"  property="issuedBy" title="${message(code: 'pdc.issuedBy.label', default: 'Issued By')}" />
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}" property="chequeNo" title="${message(code: 'pdc.chequeNo.label', default: 'Cheque No')}" />
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}"  property="chequeDate" title="${message(code: 'pdc.chequeDate.label', default: 'Cheque Date')}" />
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}"  property="bank" title="${message(code: 'pdc.bank.label', default: 'Bank')}" />
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}"  property="branch" title="${message(code: 'pdc.branch.label', default: 'Branch')}" />
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}"  property="amount" title="${message(code: 'pdc.amount.label', default: 'Amount')}" />
                        
                            <g:sortableColumn action="search" params="${searchparams?:''}"  property="status" title="${message(code: 'pdc.status.label', default: 'Status')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pdcInstanceList}" status="i" var="pdcInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${pdcInstance.id}">${fieldValue(bean: pdcInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: pdcInstance, field: "issuedBy")}</td>
                        
                            <td>${fieldValue(bean: pdcInstance, field: "chequeNo")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${pdcInstance.chequeDate}" /></td>
                        
                            <td>${fieldValue(bean: pdcInstance, field: "bank")}</td>
                        
                            <td>${fieldValue(bean: pdcInstance, field: "branch")}</td>
                        
                            <td>${fieldValue(bean: pdcInstance, field: "amount")}</td>
                        
                            <td>${fieldValue(bean: pdcInstance, field: "status")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${!search}">
            <div class="paginateButtons">
                <g:paginate total="${pdcInstanceTotal}" />
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
