
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="Issue ReceiptBook" /></g:link></span>
            <g:if test = "${receiptBookIssuedInstance?.status != 'Issued'}">
            	<span class="menuButton"><g:link class="create" action="returnacknowledgement"  params="[id:receiptBookIssuedInstance?.id]"><g:message code="Print Return Acknowledgement" /></g:link></span>
            </g:if>
            
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
                            <td valign="top" class="name"><g:message code="receiptBookIssued.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${receiptBookIssuedInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.receiptBook.label" default="Receipt Book" /></td>
                            
                            <td valign="top" class="value"><g:link controller="receiptBook" action="show" id="${receiptBookIssuedInstance?.receiptBook?.id}">${receiptBookIssuedInstance?.receiptBook?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${receiptBookIssuedInstance?.issuedTo?.id}">${receiptBookIssuedInstance?.issuedTo?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
			
			<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
			<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(receiptBookIssuedInstance.issuedTo,crel)?.individual2}" />
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${counsellor?.id}">${counsellor}</g:link></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issueDate.label" default="Issue Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.issueDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.returnDate.label" default="Return Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.returnDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookIssuedInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.tempCash.label" default="Submitted Cash" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookIssuedInstance, field: "tempCash")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.tempCheque.label" default="Submitted Cheque" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookIssuedInstance, field: "tempCheque")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookIssuedInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${receiptBookIssuedInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookIssuedInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${receiptBookIssuedInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookIssuedInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${receiptBookIssuedInstance?.id}" />
                    <!--<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>-->
                    <g:if test = "${receiptBookIssuedInstance?.status == 'Issued'||receiptBookIssuedInstance?.status == 'Submitted'}">
                    <sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                    	<span class="button"><g:actionSubmit class="edit" action="edit" value="Return" /></span>
                    </sec:ifNotGranted>
                    </g:if>
                   	<!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
                </g:form>
            </div>
        </div>
    </body>
</html>
