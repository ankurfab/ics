
<%@ page import="ics.AttributeValue" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="attributeValue.list" default="AttributeValue List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="attributeValue.new" default="New AttributeValue" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="attributeValue.list" default="AttributeValue List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="attributeValue.id" />
                        
                   	    <th><g:message code="attributeValue.attribute" default="Attribute" /></th>
                   	    
                   	    <g:sortableColumn property="creator" title="Creator" titleKey="attributeValue.creator" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="attributeValue.dateCreated" />
                        
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="attributeValue.lastUpdated" />
                        
                   	    <g:sortableColumn property="objectClassName" title="Object Class Name" titleKey="attributeValue.objectClassName" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${attributeValueInstanceList}" status="i" var="attributeValueInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${attributeValueInstance.id}">${fieldValue(bean: attributeValueInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: attributeValueInstance, field: "attribute")}</td>
                        
                            <td>${fieldValue(bean: attributeValueInstance, field: "creator")}</td>
                        
                            <td><g:formatDate date="${attributeValueInstance.dateCreated}" /></td>
                        
                            <td><g:formatDate date="${attributeValueInstance.lastUpdated}" /></td>
                        
                            <td>${fieldValue(bean: attributeValueInstance, field: "objectClassName")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${attributeValueInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
