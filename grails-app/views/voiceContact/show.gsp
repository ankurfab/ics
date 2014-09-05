
<%@ page import="ics.VoiceContact" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'voiceContact.label', default: 'VoiceContact')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <!--<span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>-->
            <span class="menuButton"><g:link class="create" action="create" params="['individual.id': voiceContactInstance?.individual?.id]"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="voiceContact.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${voiceContactInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="voiceContact.individual.label" default="Individual" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${voiceContactInstance?.individual?.id}">${voiceContactInstance?.individual?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="voiceContact.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: voiceContactInstance, field: "category")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="voiceContact.number.label" default="Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: voiceContactInstance, field: "number")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="voiceContact.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${voiceContactInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="voiceContact.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: voiceContactInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="voiceContact.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${voiceContactInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="voiceContact.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: voiceContactInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${voiceContactInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
