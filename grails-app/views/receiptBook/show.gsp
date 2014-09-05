
<%@ page import="ics.ReceiptBook" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBook.label', default: 'ReceiptBook')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="receiptBook.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${receiptBookInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "category")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.bookSeries.label" default="Book Series" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "bookSeries")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.bookSerialNumber.label" default="Book Serial Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "bookSerialNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.startingReceiptNumber.label" default="Starting Receipt Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "startingReceiptNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.numPages.label" default="Num Pages" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "numPages")}</td>
                            
                        </tr>
                    
                        <!--<tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.isBlank.label" default="Is Blank" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${receiptBookInstance?.isBlank}" /></td>
                            
                        </tr>-->
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.receipts.label" default="Receipts" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${receiptBookInstance.receipts}" var="r">
                                    <g:set var="donation" value="${ics.Donation.findByDonationReceipt(r)}" />
                                    <g:if test="${donation}">
                                   	<li><g:link controller="receipt" action="show" id="${r.id}">${r?.encodeAsHTML()} (${donation?.currency} ${donation?.amount} on ${donation?.donationDate?.format('dd-MM-yyyy')} from ${donation?.donatedBy})</g:link></li>
                                   </g:if>
                                   <g:else>
                                   	<li><g:link controller="receipt" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
                                   </g:else>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Total Collection till Date</td>
                            
                            <td valign="top" class="value">${totalCollection}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${receiptBookInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${receiptBookInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBook.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: receiptBookInstance, field: "updator")}</td>
                            
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${receiptBookInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <g:if test = "${receiptBookInstance?.status == 'Blank' || receiptBookInstance?.status == 'Hold'}">
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
	                   </g:if>
                </g:form>
            </div>
        </div>
    </body>
</html>
