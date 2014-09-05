
<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>Show Advance Donation</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create0"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.lotId.label" default="Lot Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "lotId")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Advance Donation Date</td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${loanInstance?.loanDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Advance Donation By</td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${loanInstance?.loanedBy?.id}">${loanInstance?.loanedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.reference1.label" default="Witness" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${loanInstance?.reference1?.id}">${loanInstance?.reference1?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.reference2.label" default="Project Co-ordinator- Finance" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${loanInstance?.reference2?.id}">${loanInstance?.reference2?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.nominee.label" default="Nominee" /></td>
                            
                            
                            <td valign="top" class="value">${loanInstance?.nominee}</td>
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.panNo.label" default="IT PAN No." /></td>
                            
                            <td valign="top" class="value">${loanInstance?.loanedBy?.panNo}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.amount.label" default="Amount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "amount")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.term.label" default="Term" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "term")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "category")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Advance Donation Receipt No</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "loanReceiptNo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.mode.label" default="Mode" /></td>
                            
                            <td valign="top" class="value"><g:link controller="paymentMode" action="show" id="${loanInstance?.mode?.id}">${loanInstance?.mode?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.bank.label" default="Bank" /></td>
                            
                            <td valign="top" class="value"><g:link controller="bank" action="show" id="${loanInstance?.bank?.id}">${loanInstance?.bank?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.bankBranch.label" default="Bank Branch" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "bankBranch")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.chequeNo.label" default="Cheque No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "chequeNo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.chequeDate.label" default="Cheque Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${loanInstance?.chequeDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.paymentComments.label" default="Payment Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "paymentComments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Advance Donation Start Date</td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${loanInstance?.loanStartDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Advance Donation End Date</td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${loanInstance?.loanEndDate}" /></td>
                            
                        </tr>
                        
						<tr class="prop">
							<td valign="top" class="name">
							  <label for="accoutsReceiptNo"><g:message code="loan.accoutsReceiptNo.label" default="Accounts Receipt No" /></label>
							</td>
							<td valign="top" class="value">${fieldValue(bean: loanInstance, field: "accoutsReceiptNo")}</td>
						</tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value"><b>${fieldValue(bean: loanInstance, field: "status")}<b></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${loanInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${loanInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="loan.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${loanInstance?.id}" />
                    <g:if test = "${loanInstance.status == 'PENDING'}">
                    	<g:hiddenField name="toBeSubmitted" value="" />
                    	<span class="button"><g:actionSubmit class="edit" action="edit" value="Mark as Submitted" onclick="markSubmitted();"/></span>
                    </g:if>
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
        <script language="javascript">
        	function markSubmitted()
        	{
        		document.getElementById("toBeSubmitted").value = 1;
        	}
        </script>
    </body>
</html>
