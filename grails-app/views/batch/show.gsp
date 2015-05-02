
<%@ page import="ics.Batch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="batch.show" default="Show Batch" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="batch.list" default="Batch List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="batch.new" default="New Batch" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="batch.show" default="Show Batch" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${batchInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.ref" default="Ref" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "ref")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.fromDate" default="From Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchInstance?.fromDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.toDate" default="To Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchInstance?.toDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${batchInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: batchInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="batch.items" default="Items" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${batchInstance?.items}" var="batchItemInstance">
                                        <li><g:link controller="batchItem" action="show" id="${batchItemInstance.id}">${batchItemInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
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
