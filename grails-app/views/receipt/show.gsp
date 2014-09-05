
<%@ page import="ics.Receipt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receipt.label', default: 'Receipt')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>-->
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
                            <td valign="top" class="name"><g:message code="receipt.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${receiptInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receipt.receiptBook.label" default="Receipt Book" /></td>
                            
                            <td valign="top" class="value"><g:link controller="receiptBook" action="show" id="${receiptInstance?.receiptBook?.id}">${receiptInstance?.receiptBook?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receipt.receiptNumber.label" default="Receipt Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptInstance, field: "receiptNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Donation</td>
                            
                            <g:set var="donation" value="${ics.Donation.findByDonationReceipt(receiptInstance)}" />

                            
                            <td valign="top" class="value"><g:link controller="donation" action="show" id="${donation?.id}">${donation?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receipt.isBlank.label" default="Is Blank" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${receiptInstance?.isBlank}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receipt.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${receiptInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receipt.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receipt.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${receiptInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receipt.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <!--<div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${receiptInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>-->
        </div>
    </body>
</html>
