
<%@ page import="ics.Subscription" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="subscription.edit" default="Edit Subscription" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="subscription.list" default="Subscription List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="subscription.new" default="New Subscription" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="subscription.edit" default="Edit Subscription" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${subscriptionInstance}">
            <div class="errors">
                <g:renderErrors bean="${subscriptionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${subscriptionInstance?.id}" />
                <g:hiddenField name="version" value="${subscriptionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="subscription.amount" default="Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: subscriptionInstance, field: 'amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="subscription.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: subscriptionInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="subscription.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${subscriptionInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deliveryChannel"><g:message code="subscription.deliveryChannel" default="Delivery Channel" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'deliveryChannel', 'errors')}">
                                    <g:textField name="deliveryChannel" value="${fieldValue(bean: subscriptionInstance, field: 'deliveryChannel')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="frequency"><g:message code="subscription.frequency" default="Frequency" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'frequency', 'errors')}">
                                    <g:textField name="frequency" value="${fieldValue(bean: subscriptionInstance, field: 'frequency')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="subscription.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${subscriptionInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentDate"><g:message code="subscription.paymentDate" default="Payment Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'paymentDate', 'errors')}">
                                    <g:datePicker name="paymentDate" value="${subscriptionInstance?.paymentDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentReference"><g:message code="subscription.paymentReference" default="Payment Reference" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'paymentReference', 'errors')}">
                                    <g:textField name="paymentReference" value="${fieldValue(bean: subscriptionInstance, field: 'paymentReference')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="periodical"><g:message code="subscription.periodical" default="Periodical" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'periodical', 'errors')}">
                                    <g:select name="periodical.id" from="${ics.Book.list()}" optionKey="id" value="${subscriptionInstance?.periodical?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="since"><g:message code="subscription.since" default="Since" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'since', 'errors')}">
                                    <g:datePicker name="since" value="${subscriptionInstance?.since}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="subscription.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: subscriptionInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subscriber"><g:message code="subscription.subscriber" default="Subscriber" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'subscriber', 'errors')}">
                                    <g:select name="subscriber.id" from="${ics.Individual.list()}" optionKey="id" value="${subscriptionInstance?.subscriber?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subscriptionNumber"><g:message code="subscription.subscriptionNumber" default="Subscription Number" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'subscriptionNumber', 'errors')}">
                                    <g:textField name="subscriptionNumber" value="${fieldValue(bean: subscriptionInstance, field: 'subscriptionNumber')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="till"><g:message code="subscription.till" default="Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'till', 'errors')}">
                                    <g:datePicker name="till" value="${subscriptionInstance?.till}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="subscription.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: subscriptionInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: subscriptionInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
