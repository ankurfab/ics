
<%@ page import="ics.BouncedCheque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'bouncedCheque.label', default: 'Dishonoured Cheque')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>-->
            <span class="menuButton"><g:link class="create" controller="followup" action="createforbouncedcheque" params="['bouncedCheque.id': bouncedChequeInstance?.id]">Create Followup</g:link></span>
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
                            <td valign="top" class="name"><g:message code="bouncedCheque.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${bouncedChequeInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.donation.label" default="Donation" /></td>
                            
                            <td valign="top" class="value"><g:link controller="donation" action="show" id="${bouncedChequeInstance?.donation?.id}">${bouncedChequeInstance?.donation}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.chequeNo.label" default="Cheque No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: bouncedChequeInstance, field: "chequeNo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.chequeDate.label" default="Cheque Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${bouncedChequeInstance?.chequeDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.bankName.label" default="Bank Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: bouncedChequeInstance, field: "bankName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.branchName.label" default="Branch Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: bouncedChequeInstance, field: "branchName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.issuedBy.label" default="Issued By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: bouncedChequeInstance, field: "issuedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.issuedTo.label" default="Issued To" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: bouncedChequeInstance, field: "issuedTo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.presentedOn.label" default="Presented On" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${bouncedChequeInstance?.presentedOn}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${bouncedChequeInstance?.comments}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${bouncedChequeInstance?.status}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${bouncedChequeInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: bouncedChequeInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${bouncedChequeInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="bouncedCheque.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: bouncedChequeInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${bouncedChequeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
