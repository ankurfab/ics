
<%@ page import="ics.BatchItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="batchItem.create" default="Create BatchItem" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="batchItem.list" default="BatchItem List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="batchItem.create" default="Create BatchItem" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${batchItemInstance}">
            <div class="errors">
                <g:renderErrors bean="${batchItemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="postingDate"><g:message code="batchItem.postingDate" default="Posting Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'postingDate', 'errors')}">
                                    <g:datePicker name="postingDate" value="${batchItemInstance?.postingDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="effectiveDate"><g:message code="batchItem.effectiveDate" default="Effective Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'effectiveDate', 'errors')}">
                                    <g:datePicker name="effectiveDate" value="${batchItemInstance?.effectiveDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="batchItem.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: batchItemInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ref"><g:message code="batchItem.ref" default="Ref" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'ref', 'errors')}">
                                    <g:textField name="ref" value="${fieldValue(bean: batchItemInstance, field: 'ref')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="debit"><g:message code="batchItem.debit" default="Debit" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'debit', 'errors')}">
                                    <g:checkBox name="debit" value="${batchItemInstance?.debit}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="grossAmount"><g:message code="batchItem.grossAmount" default="Gross Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'grossAmount', 'errors')}">
                                    <g:textField name="grossAmount" value="${fieldValue(bean: batchItemInstance, field: 'grossAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="netAmount"><g:message code="batchItem.netAmount" default="Net Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'netAmount', 'errors')}">
                                    <g:textField name="netAmount" value="${fieldValue(bean: batchItemInstance, field: 'netAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="linkedEntityName"><g:message code="batchItem.linkedEntityName" default="Linked Entity Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'linkedEntityName', 'errors')}">
                                    <g:textField name="linkedEntityName" value="${fieldValue(bean: batchItemInstance, field: 'linkedEntityName')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="linkedEntityRef"><g:message code="batchItem.linkedEntityRef" default="Linked Entity Ref" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'linkedEntityRef', 'errors')}">
                                    <g:textField name="linkedEntityRef" value="${fieldValue(bean: batchItemInstance, field: 'linkedEntityRef')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="linkedEntityId"><g:message code="batchItem.linkedEntityId" default="Linked Entity Id" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'linkedEntityId', 'errors')}">
                                    <g:textField name="linkedEntityId" value="${fieldValue(bean: batchItemInstance, field: 'linkedEntityId')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="linkedBatchRef"><g:message code="batchItem.linkedBatchRef" default="Linked Batch Ref" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'linkedBatchRef', 'errors')}">
                                    <g:textField name="linkedBatchRef" value="${fieldValue(bean: batchItemInstance, field: 'linkedBatchRef')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="batchItem.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: batchItemInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="batchItem.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${batchItemInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="batchItem.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${batchItemInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="batchItem.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: batchItemInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="batchItem.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: batchItemInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="batch"><g:message code="batchItem.batch" default="Batch" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchItemInstance, field: 'batch', 'errors')}">
                                    <g:select name="batch.id" from="${ics.Batch.list()}" optionKey="id" value="${batchItemInstance?.batch?.id}"  />

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
