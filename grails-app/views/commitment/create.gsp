
<%@ page import="ics.Commitment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="commitment.create" default="Create Commitment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="commitment.list" default="Commitment List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="commitment.create" default="Create Commitment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${commitmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${commitmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donatedAmount"><g:message code="commitment.donatedAmount" default="Donated Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'donatedAmount', 'errors')}">
                                    <g:textField name="donatedAmount" value="${fieldValue(bean: commitmentInstance, field: 'donatedAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="collectedAmount"><g:message code="commitment.collectedAmount" default="Collected Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'collectedAmount', 'errors')}">
                                    <g:textField name="collectedAmount" value="${fieldValue(bean: commitmentInstance, field: 'collectedAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="commitmentOn"><g:message code="commitment.commitmentOn" default="Commitment On" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'commitmentOn', 'errors')}">
                                    <g:datePicker name="commitmentOn" value="${commitmentInstance?.commitmentOn}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="commitmentTill"><g:message code="commitment.commitmentTill" default="Commitment Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'commitmentTill', 'errors')}">
                                    <g:datePicker name="commitmentTill" value="${commitmentInstance?.commitmentTill}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="scheme"><g:message code="commitment.scheme" default="Scheme" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'scheme', 'errors')}">
                                    <g:select name="scheme.id" from="${ics.Scheme.list()}" optionKey="id" value="${commitmentInstance?.scheme?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="commitment.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: commitmentInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="commitment.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${commitmentInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="commitment.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: commitmentInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="commitment.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${commitmentInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="commitment.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: commitmentInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedAmount"><g:message code="commitment.committedAmount" default="Committed Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'committedAmount', 'errors')}">
                                    <g:textField name="committedAmount" value="${fieldValue(bean: commitmentInstance, field: 'committedAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedBy"><g:message code="commitment.committedBy" default="Committed By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commitmentInstance, field: 'committedBy', 'errors')}">
                                    <g:select name="committedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${commitmentInstance?.committedBy?.id}"  />

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
