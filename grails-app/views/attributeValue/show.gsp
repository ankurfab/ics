
<%@ page import="ics.AttributeValue" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="attributeValue.show" default="Show AttributeValue" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="attributeValue.list" default="AttributeValue List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="attributeValue.new" default="New AttributeValue" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="attributeValue.show" default="Show AttributeValue" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${attributeValueInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeValueInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.attribute" default="Attribute" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="attribute" action="show" id="${attributeValueInstance?.attribute?.id}">${attributeValueInstance?.attribute?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeValueInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${attributeValueInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${attributeValueInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.objectClassName" default="Object Class Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeValueInstance, field: "objectClassName")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.objectId" default="Object Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeValueInstance, field: "objectId")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeValueInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attributeValue.value" default="Value" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeValueInstance, field: "value")}</td>
                                
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
