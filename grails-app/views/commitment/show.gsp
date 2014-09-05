
<%@ page import="ics.Commitment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="commitment.show" default="Show Commitment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="commitment.list" default="Commitment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="commitment.new" default="New Commitment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="commitment.show" default="Show Commitment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${commitmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commitmentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.donatedAmount" default="Donated Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${commitmentInstance?.donatedAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.collectedAmount" default="Collected Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${commitmentInstance?.collectedAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.commitmentOn" default="Commitment On" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${commitmentInstance?.commitmentOn}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.commitmentTill" default="Commitment Till" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${commitmentInstance?.commitmentTill}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.scheme" default="Scheme" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="scheme" action="show" id="${commitmentInstance?.scheme?.id}">${commitmentInstance?.scheme?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commitmentInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${commitmentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commitmentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${commitmentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commitmentInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.committedAmount" default="Committed Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${commitmentInstance?.committedAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commitment.committedBy" default="Committed By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${commitmentInstance?.committedBy?.id}">${commitmentInstance?.committedBy?.encodeAsHTML()}</g:link></td>
                                
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
