
<%@ page import="ics.Subscription" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="subscription.show" default="Show Subscription" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="subscription.list" default="Subscription List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="subscription.new" default="New Subscription" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="subscription.show" default="Show Subscription" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${subscriptionInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.amount" default="Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${subscriptionInstance?.amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${subscriptionInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.deliveryChannel" default="Delivery Channel" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "deliveryChannel")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.frequency" default="Frequency" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "frequency")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${subscriptionInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.paymentDate" default="Payment Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${subscriptionInstance?.paymentDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.paymentReference" default="Payment Reference" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "paymentReference")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.periodical" default="Periodical" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="book" action="show" id="${subscriptionInstance?.periodical?.id}">${subscriptionInstance?.periodical?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.since" default="Since" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${subscriptionInstance?.since}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.subscriber" default="Subscriber" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${subscriptionInstance?.subscriber?.id}">${subscriptionInstance?.subscriber?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.subscriptionNumber" default="Subscription Number" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "subscriptionNumber")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.till" default="Till" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${subscriptionInstance?.till}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="subscription.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: subscriptionInstance, field: "updator")}</td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
