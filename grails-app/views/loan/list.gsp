
<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>Advance Donation</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" controller="loan" action="create0"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status': 'PENDING']">Pending <g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status': 'SUBMITTED']">Submitted <g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status': 'ACCEPTED']">Accepted <g:message code="default.list.label" args="[entityName]" /></g:link></span>
            
            
            <!--<span class="menuButton"><g:link class="list" controller="loan" action="submitpendingloans">Submit Pending Advance Donations</g:link></span>-->
        </div>
        <div class="body">
        
            <h1>
				<g:if test = "${pendingLoanList}">
					Pending
				</g:if>
				<g:if test = "${submittedLoanList}">
					Submitted
				</g:if>
				<g:if test = "${acceptedLoanList}">
					Accepted
				</g:if>
				
				<g:message code="default.list.label" args="[entityName]" />
            </h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form name="listForm">
            <div class="list">
            
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="lotId" title="${message(code: 'loan.lotId.label', default: 'Lot Id')}" />
                        
                            <g:sortableColumn property="id" title="${message(code: 'loan.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="loanDate" title="Advance Donation Date" />
                        
                            <th>Advance Donation By</th>
                        
                            <th>Councellor</th>
                        
                            <th><g:message code="loan.reference1.label" default="Witness" /></th>
                        
                            <th><g:message code="loan.reference2.label" default="Project Co-ordinator- Finance" /></th>
                            
                            <g:sortableColumn property="amount" title="${message(code: 'loan.amount.label', default: 'Amount')}" />
                            
                            <g:sortableColumn property="status" title="${message(code: 'loan.status.label', default: 'Status')}" />
                            
							<g:if test = "${allList || acceptedLoanList}">
                            	<g:sortableColumn property="fdNumber" title="${message(code: 'loan.fdNumber.label', default: 'FD Number')}" />
                            
                            	<th>FD Amount</th>
                            </g:if>	
                            
                            <!--<g:if test = "${pendingLoanList}">
                            	<th> <g:checkBox name="checkAll" value="SelectAll" checked="false" onclick="checkUncheckAll()"/> Submit</th>
                            </g:if>
                            <g:if test = "${submittedLoanList}">
                            	<th> <g:checkBox name="checkAll" value="SelectAll" checked="false" onclick="checkUncheckAll()"/> Enter Lot Id</th>
                            </g:if>-->
                            
                        
                        </tr>
                    </thead>
                    <tbody>
                    
                    <g:if test = "${pendingLoanList!='' && pendingLoanList!=null}">
                    <g:hiddenField name="listType" value="pendingLoanList" />
                    <g:hiddenField name="loanIds" value="" />
			<g:each in="${pendingLoanList}" status="i" var="loanInstance">

				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td>${fieldValue(bean: loanInstance, field: "lotId")}</td>

					<td><g:link action="show" id="${loanInstance.id}">${fieldValue(bean: loanInstance, field: "id")}</g:link></td>

					<td><g:formatDate format="dd-MM-yyyy" date="${loanInstance.loanDate}" /></td>

					<td>${fieldValue(bean: loanInstance, field: "loanedBy")}</td>

					<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
					<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(loanInstance?.loanedBy,crel)?.individual2}" />
					<td valign="top" class="value">${counsellor}</td>
					
					<td>${fieldValue(bean: loanInstance, field: "reference1")}</td>

					<td>${fieldValue(bean: loanInstance, field: "reference2")}</td>

					<td>${fieldValue(bean: loanInstance, field: "amount")}</td>

					<td>${fieldValue(bean: loanInstance, field: "status")}</td>

					<!--<td>${fieldValue(bean: loanInstance, field: "fdNumber")}</td>-->

					<!--<td><g:checkBox name="toSubmit" value="${loanInstance?.id}" checked="false" /></td>-->
				</tr>
			</g:each>

                    	
                    </g:if>
                    <g:if test = "${submittedLoanList!='' && submittedLoanList!=null}">
                    <g:hiddenField name="listType" value="submittedLoanList" />
                    <g:hiddenField name="loanIds" value="" />
			<g:each in="${submittedLoanList}" status="i" var="loanInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td>${fieldValue(bean: loanInstance, field: "lotId")}</td>

					<td><g:link action="show" id="${loanInstance.id}">${fieldValue(bean: loanInstance, field: "id")}</g:link></td>

					<td><g:formatDate format="dd-MM-yyyy" date="${loanInstance.loanDate}" /></td>

					<td>${fieldValue(bean: loanInstance, field: "loanedBy")}</td>

					<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
					<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(loanInstance?.loanedBy,crel)?.individual2}" />
					<td valign="top" class="value">${counsellor}</td>

					<td>${fieldValue(bean: loanInstance, field: "reference1")}</td>

					<td>${fieldValue(bean: loanInstance, field: "reference2")}</td>

					<td>${fieldValue(bean: loanInstance, field: "amount")}</td>

					<td>${fieldValue(bean: loanInstance, field: "status")}</td>

					<!--<td>${fieldValue(bean: loanInstance, field: "fdNumber")}</td>-->

					<!--<td><g:checkBox name="toAccept" value="${loanInstance?.id}" checked="false" /></td>-->

				</tr>
			</g:each>
                    
                    </g:if>
                    <g:if test = "${acceptedLoanList!='' && acceptedLoanList!=null}">
                    <g:hiddenField name="listType" value="acceptedLoanList" />
                    <g:hiddenField name="loanIds" value="" />
			<g:each in="${acceptedLoanList}" status="i" var="loanInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td>${fieldValue(bean: loanInstance, field: "lotId")}</td>

					<td><g:link action="show" id="${loanInstance.id}">${fieldValue(bean: loanInstance, field: "id")}</g:link></td>

					<td><g:formatDate format="dd-MM-yyyy" date="${loanInstance.loanDate}" /></td>

					<td>${fieldValue(bean: loanInstance, field: "loanedBy")}</td>

					<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
					<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(loanInstance?.loanedBy,crel)?.individual2}" />
					<td valign="top" class="value">${counsellor}</td>

					<td>${fieldValue(bean: loanInstance, field: "reference1")}</td>

					<td>${fieldValue(bean: loanInstance, field: "reference2")}</td>

					<td>${fieldValue(bean: loanInstance, field: "amount")}</td>

					<td>${fieldValue(bean: loanInstance, field: "status")}</td>

					<td>${fieldValue(bean: loanInstance, field: "fdNumber")}</td>

					<td>
						<g:if test = "${loanInstance.fdNumber}">
							${(loanInstance?.amount).toInteger()/2}
						</g:if>
					</td>

					<!--<td><g:checkBox name="toAccept" value="${loanInstance?.id}" checked="false" /></td>-->

				</tr>
			</g:each>
                    
                    </g:if>

                    <g:if test = "${allList}">
                    	<g:hiddenField name="listType" value="allLoanList" />
			<g:each in="${loanInstanceList}" status="i" var="loanInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td>${fieldValue(bean: loanInstance, field: "lotId")}</td>

					<td><g:link action="show" id="${loanInstance.id}">${fieldValue(bean: loanInstance, field: "id")}</g:link></td>

					<td><g:formatDate format="dd-MM-yyyy" date="${loanInstance.loanDate}" /></td>

					<td>${fieldValue(bean: loanInstance, field: "loanedBy")}</td>

					<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
					<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(loanInstance?.loanedBy,crel)?.individual2}" />
					<td valign="top" class="value">${counsellor}</td>

					<td>${fieldValue(bean: loanInstance, field: "reference1")}</td>

					<td>${fieldValue(bean: loanInstance, field: "reference2")}</td>

					<td>${fieldValue(bean: loanInstance, field: "amount")}</td>

					<td>${fieldValue(bean: loanInstance, field: "status")}</td>

					<td>${fieldValue(bean: loanInstance, field: "fdNumber")}</td>

					<td>
						<g:if test = "${loanInstance.fdNumber}">
							${(loanInstance?.amount).toInteger()/2}
						</g:if>
					</td>

				</tr>
			</g:each>
                    </g:if>
                    <tr bgcolor='lavender'>
			<td>
			</td>
			<td>
			</td>
			<td>
			</td>
			<td>
			</td>
			<td>
			</td>			
			<td>
			</td>
			<td align="right">
				<b>Total<b>
			</td>
			<td>
				<b>${totalAmt}<b>
			</td>
			<td>
			</td>
			<g:if test = "${allList || acceptedLoanList}">
				<td>
				</td>
				<td>
					<b>${totalFDAmt}<b>
				</td>
			</g:if>
                    </tr>
                    </tbody>
                </table>
            </div>
            
            <div class="paginateButtons">
                <g:paginate total="${loanInstanceTotal}" />
            </div>
            
		<div class="buttons">
			<!--<g:if test = "${pendingLoanList}">
				<span class="button"><g:actionSubmit name="submitLoans" class="save" action="submitselectedloans" onclick="submitSelectedLoans()" value="Submit Loan(s)" /></span>
			</g:if>-->
			<g:if test = "${submittedLoanList}">
				<span class="button"><g:actionSubmit name="acceptLoans" class="edit" action="acceptselectedloans" value="Assign Lot Id" onclick="return confirm('Are you sure?');"/></span>
			</g:if>
			<g:if test = "${allList || acceptedLoanList}">
				<span class="button"><g:actionSubmit name="assignFDNum" class="edit" action="assignfdnumber" value="Assign FD Number to Lot"/></span>
			</g:if>
		</div>
            
		</g:form>
			
			
        </div>
        <script language="javascript">

		function checkUncheckAll()
		{

			if (document.getElementById("listType").value == "pendingLoanList")
			{
				var allChkBoxes = document.getElementsByName("toSubmit");
			}
			if (document.getElementById("listType").value == "submittedLoanList")
			{
				var allChkBoxes = document.getElementsByName("toAccept");
			}

			var checkedAll = document.getElementById("checkAll");

			if(checkedAll.checked == true)
			{
				for(i=0; i< allChkBoxes.length; i++)
					allChkBoxes[i].checked = true;
			}

			else
			{
				for(i=0; i< allChkBoxes.length; i++)
					allChkBoxes[i].checked = false;
			}
		}

		function submitSelectedLoans()
		{
			var toSubmitChkBoxes = document.getElementsByName("toSubmit");
			var loanIds = new Array();

			for(i=0; i< toSubmitChkBoxes.length; i++)
			{
				if(toSubmitChkBoxes[i].checked == true)
					loanIds[i] = toSubmitChkBoxes[i].value;
			}
			if(loanIds.length == 0)
			{
				alert("Please select loans(s) to be submitted");
				return false;
			}
			else
			{
				document.getElementById("loanIds").value = loanIds;
				return true;
			}
		}

		function acceptSelectedLoans()
		{
			var toAcceptChkBoxes = document.getElementsByName("toAccept");
			var loanIds = new Array();

			for(i=0; i< toAcceptChkBoxes.length; i++)
			{
				if(toAcceptChkBoxes[i].checked == true)
					loanIds[i] = toAcceptChkBoxes[i].value;
			}
			if(loanIds.length == 0)
			{
				alert("Please select loans(s) to be alloted Lot Id");
				return false;
			}
			else
			{
				document.getElementById("loanIds").value = loanIds;
				return true;
			}
		}
			
        </script>
    </body>
</html>
