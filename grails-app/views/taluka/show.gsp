
<%@ page import="ics.Taluka" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="taluka.show" default="Show Taluka" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="taluka.list" default="Taluka List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="taluka.new" default="New Taluka" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="taluka.show" default="Show Taluka" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${talukaInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="taluka.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: talukaInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="taluka.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: talukaInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="taluka.district" default="District" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="district" action="show" id="${talukaInstance?.district?.id}">${talukaInstance?.district?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="taluka.villages" default="Villages" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${talukaInstance?.villages.sort{it.name}}" var="villageInstance">
                                        <li><g:link controller="village" action="show" id="${villageInstance.id}">${villageInstance.encodeAsHTML()}</g:link></li>
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
