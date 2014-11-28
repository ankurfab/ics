
<%@ page import="ics.Challan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="challan.create" default="Create Challan" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="challan.list" default="Challan List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="challan.create" default="Create Challan" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${challanInstance}">
            <div class="errors">
                <g:renderErrors bean="${challanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refNo"><g:message code="challan.refNo" default="Ref No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'refNo', 'errors')}">
                                    <g:textField name="refNo" value="${fieldValue(bean: challanInstance, field: 'refNo')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedTo"><g:message code="challan.issuedTo" default="Issued To" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'issuedTo', 'errors')}">
                                    <g:select name="issuedTo.id" from="${ics.Individual.list()}" optionKey="id" value="${challanInstance?.issuedTo?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedBy"><g:message code="challan.issuedBy" default="Issued By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'issuedBy', 'errors')}">
                                    <g:select name="issuedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${challanInstance?.issuedBy?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="settleBy"><g:message code="challan.settleBy" default="Settle By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'settleBy', 'errors')}">
                                    <g:select name="settleBy.id" from="${ics.Individual.list()}" optionKey="id" value="${challanInstance?.settleBy?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issueDate"><g:message code="challan.issueDate" default="Issue Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'issueDate', 'errors')}">
                                    <g:datePicker name="issueDate" value="${challanInstance?.issueDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="settleDate"><g:message code="challan.settleDate" default="Settle Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'settleDate', 'errors')}">
                                    <g:datePicker name="settleDate" value="${challanInstance?.settleDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="advanceAmount"><g:message code="challan.advanceAmount" default="Advance Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'advanceAmount', 'errors')}">
                                    <g:textField name="advanceAmount" value="${fieldValue(bean: challanInstance, field: 'advanceAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="totalAmount"><g:message code="challan.totalAmount" default="Total Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'totalAmount', 'errors')}">
                                    <g:textField name="totalAmount" value="${fieldValue(bean: challanInstance, field: 'totalAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="settleAmount"><g:message code="challan.settleAmount" default="Settle Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'settleAmount', 'errors')}">
                                    <g:textField name="settleAmount" value="${fieldValue(bean: challanInstance, field: 'settleAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="challan.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: challanInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="challan.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: challanInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="challan.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: challanInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="challan.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${challanInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="challan.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: challanInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="challan.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${challanInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="challan.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challanInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: challanInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
