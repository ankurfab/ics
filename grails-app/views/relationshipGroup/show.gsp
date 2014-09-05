
<%@ page import="ics.RelationshipGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationshipGroup.label', default: 'RelationshipGroup')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>-->
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
                            <td valign="top" class="name"><g:message code="relationshipGroup.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${relationshipGroupInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationshipGroup.groupName.label" default="Group Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipGroupInstance, field: "groupName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">LinkedIndividual</td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${relationshipGroupInstance?.refid}">${ics.Individual.get(relationshipGroupInstance?.refid)}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationshipGroup.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipGroupInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationshipGroup.relationships.label" default="Relationships" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${relationshipGroupInstance.relationships}" var="r">
            			<sec:ifNotGranted roles="ROLE_COUNSELLOR_GROUP">
                                    <li><g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
                                </sec:ifNotGranted>
            			<sec:ifAnyGranted roles="ROLE_COUNSELLOR_GROUP">
                                    <li><g:link controller="individual" action="show" id="${r.individual1?.id}">${r.individual1?.encodeAsHTML()}</g:link></li>
                                </sec:ifAnyGranted>
                                </g:each>
                                </ul>
				<g:link controller="relationship" action="create" params="['relationshipGroup.id': relationshipGroupInstance?.id,'individual2.id': relationshipGroupInstance?.refid]">${message(code: 'default.add.label', args: [message(code: 'relationship.label', default: 'Relationship')])}</g:link>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationshipGroup.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${relationshipGroupInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationshipGroup.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipGroupInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationshipGroup.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${relationshipGroupInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="relationshipGroup.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: relationshipGroupInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR_GROUP">
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${relationshipGroupInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
            </sec:ifNotGranted>
        </div>
    </body>
</html>
