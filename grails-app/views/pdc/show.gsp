
<%@ page import="ics.Pdc" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pdc.label', default: 'Pdc')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="createdonation" id="${pdcInstance?.id}"  onclick="return confirm('Are you sure?');">CreateDonation</g:link></span>
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
                            <td valign="top" class="name"><g:message code="pdc.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${pdcInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.issuedBy.label" default="Issued By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${pdcInstance?.issuedBy?.id}">${pdcInstance?.issuedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.collectedBy.label" default="Collected By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${pdcInstance?.collectedBy?.id}">${pdcInstance?.collectedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.scheme.label" default="Scheme" /></td>
                            
                            <td valign="top" class="value"><g:link controller="scheme" action="show" id="${pdcInstance?.scheme?.id}">${pdcInstance?.scheme?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.chequeNo.label" default="Cheque No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pdcInstance, field: "chequeNo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.chequeDate.label" default="Cheque Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${pdcInstance?.chequeDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.bank.label" default="Bank" /></td>
                            
                            <td valign="top" class="value"><g:link controller="bank" action="show" id="${pdcInstance?.bank?.id}">${pdcInstance?.bank?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.branch.label" default="Branch" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pdcInstance, field: "branch")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.amount.label" default="Amount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pdcInstance, field: "amount")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.receivedBy.label" default="Received By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${pdcInstance?.receivedBy?.id}">${pdcInstance?.receivedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.receiptDate.label" default="Receipt Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${pdcInstance?.receiptDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pdcInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pdcInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${pdcInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pdcInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${pdcInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pdc.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pdcInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${pdcInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
