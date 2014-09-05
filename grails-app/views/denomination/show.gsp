
<%@ page import="ics.Denomination" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'denomination.label', default: 'Denomination')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
	<g:if test="${denominationInstance?.status == 'PENDING'}">
	    <span class="menuButton"><g:link class="create" controller="donation" action="tally" params="['id': denominationInstance?.id]">Tally</g:link></span>
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
                            <td valign="top" class="name"><g:message code="denomination.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${denominationInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.collectedBy.label" default="Received By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${denominationInstance?.collectedBy?.id}">${denominationInstance?.collectedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.collectionDate.label" default="Collection Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${denominationInstance?.collectionDate}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="dialog">
            	Currency Notes
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.oneThousandRupeeNoteQty.label" default="Rs. 1000 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "oneThousandRupeeNoteQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.fiveHundredRupeeNoteQty.label" default="Rs. 500 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "fiveHundredRupeeNoteQty")}</td>
                            
                        </tr>
                    
                       <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.hundredRupeeNoteQty.label" default="Rs. 100 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "hundredRupeeNoteQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.fiftyRupeeNoteQty.label" default="Rs. 50 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "fiftyRupeeNoteQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.twentyRupeeNoteQty.label" default="Rs. 20 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "twentyRupeeNoteQty")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.tenRupeeNoteQty.label" default="Rs. 10 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "tenRupeeNoteQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.fiveRupeeNoteQty.label" default="Rs. 5 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "fiveRupeeNoteQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.twoRupeeNoteQty.label" default="Rs. 2 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "twoRupeeNoteQty")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.oneRupeeNoteQty.label" default="Rs. 1 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "oneRupeeNoteQty")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="dialog">
            	Coins
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.fiftyPaiseCoinQty.label" default="50p qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "fiftyPaiseCoinQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.oneRupeeCoinQty.label" default="Re. 1 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "oneRupeeCoinQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.twoRupeeCoinQty.label" default="Rs. 2 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "twoRupeeCoinQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.fiveRupeeCoinQty.label" default="Rs. 5 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "fiveRupeeCoinQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.tenRupeeCoinQty.label" default="Rs. 10 qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "tenRupeeCoinQty")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Total</td>
                            
                            <td valign="top" class="value">${denominationInstance.fiftyPaiseCoinQty * 0.5 + denominationInstance.oneRupeeCoinQty * 1 + denominationInstance.twoRupeeCoinQty * 2 + denominationInstance.fiveRupeeCoinQty * 5 + denominationInstance.tenRupeeCoinQty * 10 + denominationInstance.oneRupeeNoteQty * 1 + denominationInstance.twoRupeeNoteQty * 2 + denominationInstance.fiveRupeeNoteQty * 5 + denominationInstance.tenRupeeNoteQty * 10 + denominationInstance.twentyRupeeNoteQty * 20 + denominationInstance.fiftyRupeeNoteQty * 50 + denominationInstance.hundredRupeeNoteQty * 100 + denominationInstance.fiveHundredRupeeNoteQty * 500 + denominationInstance.oneThousandRupeeNoteQty * 1000}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.ackDate.label" default="Ack Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${denominationInstance?.ackDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.ackBy.label" default="Ack By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${denominationInstance?.ackBy?.id}">${denominationInstance?.ackBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.ackRef.label" default="Ack Ref" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "ackRef")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${denominationInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${denominationInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="denomination.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: denominationInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${denominationInstance?.id}" />
	      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
		<g:if test="${denominationInstance?.status == 'PENDING'}">
                    <span class="button"><g:actionSubmit class="edit" action="takeover" value="TakeOver" /></span>
		</g:if>
		
		<g:if test="${denominationInstance?.status == 'TAKENOVER'}">
                    <span class="button"><g:actionSubmit class="edit" action="deposit" value="Deposit" /></span>
		</g:if>
	      </sec:ifAnyGranted>
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
