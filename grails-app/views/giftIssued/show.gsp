
<%@ page import="ics.GiftIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'giftIssued.label', default: 'GiftIssued')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="giftIssued.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${giftIssuedInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.gift.label" default="Gift" /></td>
                            
                            <td valign="top" class="value"><g:link controller="gift" action="show" id="${giftIssuedInstance?.gift?.id}">${giftIssuedInstance?.gift?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.issuedQty.label" default="Issued Qty" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "issuedQty")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.issuedTo.label" default="Issued To" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${giftIssuedInstance?.issuedTo?.id}">${giftIssuedInstance?.issuedTo?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.issuedBy.label" default="Issued By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${giftIssuedInstance?.issuedBy?.id}">${giftIssuedInstance?.issuedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.issueDate.label" default="Issue Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${giftIssuedInstance?.issueDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.donation.label" default="Donation" /></td>
                            
                            <td valign="top" class="value"><g:link controller="donation" action="show" id="${giftIssuedInstance?.donation?.id}">${giftIssuedInstance?.donation?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.nvccDonarType.label" default="Nvcc Donar Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "nvccDonarType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.nvccDonarId.label" default="Nvcc Donar Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "nvccDonarId")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.nvccGiftId.label" default="Nvcc Gift Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "nvccGiftId")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.nvccGift.label" default="Nvcc Gift" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "nvccGift")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.nvccAmount.label" default="Nvcc Amount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "nvccAmount")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${giftIssuedInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${giftIssuedInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="giftIssued.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: giftIssuedInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${giftIssuedInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
