
<%@ page import="ics.Relationship" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationship.label', default: 'Relationship')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${relationshipInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <g:if test="${relationshipInstance?.relationshipGroup?.groupName.startsWith('Family')}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.relationshipGroup.label" default="Relationship Group" /></td>
                            
                            <td valign="top" class="value"><g:link controller="relationshipGroup" action="show" id="${relationshipInstance?.relationshipGroup?.id}">${relationshipInstance?.relationshipGroup?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                        </g:if>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.individual1.label" default="Individual1" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${relationshipInstance?.individual1?.id}">${relationshipInstance?.individual1?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.relation.label" default="Relation" /></td>
                            
                            <!--<td valign="top" class="value"><g:link controller="relation" action="show" id="${relationshipInstance?.relation?.id}">${relationshipInstance?.relation?.encodeAsHTML()}</g:link></td>-->
                            <td valign="top" class="value">${relationshipInstance?.relation?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.individual2.label" default="Individual2" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${relationshipInstance?.individual2?.id}">${relationshipInstance?.individual2?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.comment.label" default="Comment" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipInstance, field: "comment")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${relationshipInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${relationshipInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationship.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${relationshipInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
