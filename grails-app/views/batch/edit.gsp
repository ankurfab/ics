
<%@ page import="ics.Batch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="batch.edit" default="Edit Batch" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="batch.list" default="Batch List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="batch.new" default="New Batch" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="batch.edit" default="Edit Batch" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${batchInstance}">
            <div class="errors">
                <g:renderErrors bean="${batchInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${batchInstance?.id}" />
                <g:hiddenField name="version" value="${batchInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="batch.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: batchInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="batch.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: batchInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="batch.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: batchInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="batch.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: batchInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ref"><g:message code="batch.ref" default="Ref" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'ref', 'errors')}">
                                    <g:textField name="ref" value="${fieldValue(bean: batchInstance, field: 'ref')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fromDate"><g:message code="batch.fromDate" default="From Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'fromDate', 'errors')}">
                                    <g:datePicker name="fromDate" value="${batchInstance?.fromDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="toDate"><g:message code="batch.toDate" default="To Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'toDate', 'errors')}">
                                    <g:datePicker name="toDate" value="${batchInstance?.toDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="batch.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: batchInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="batch.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${batchInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="batch.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${batchInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="batch.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: batchInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="batch.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: batchInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="items"><g:message code="batch.items" default="Items" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: batchInstance, field: 'items', 'errors')}">
                                    
<ul>
<g:each in="${batchInstance?.items}" var="batchItemInstance">
    <li><g:link controller="batchItem" action="show" id="${batchItemInstance.id}">${batchItemInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="batchItem" params="['batch.id': batchInstance?.id]" action="create"><g:message code="batchItem.new" default="New BatchItem" /></g:link>


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
