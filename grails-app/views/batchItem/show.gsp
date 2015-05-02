
<%@ page import="ics.BatchItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="batchItem.show" default="Show BatchItem" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="batchItem.list" default="BatchItem List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="batchItem.new" default="New BatchItem" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="batchItem.show" default="Show BatchItem" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${batchItemInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.postingDate" default="Posting Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchItemInstance?.postingDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.effectiveDate" default="Effective Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchItemInstance?.effectiveDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.ref" default="Ref" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "ref")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.debit" default="Debit" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${batchItemInstance?.debit}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.grossAmount" default="Gross Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${batchItemInstance?.grossAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.netAmount" default="Net Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${batchItemInstance?.netAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.linkedEntityName" default="Linked Entity Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "linkedEntityName")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.linkedEntityRef" default="Linked Entity Ref" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "linkedEntityRef")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.linkedEntityId" default="Linked Entity Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "linkedEntityId")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.linkedBatchRef" default="Linked Batch Ref" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "linkedBatchRef")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchItemInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchItemInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchItemInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batchItem.batch" default="Batch" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="batch" action="show" id="${batchItemInstance?.batch?.id}">${batchItemInstance?.batch?.encodeAsHTML()}</g:link></td>
                                
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
