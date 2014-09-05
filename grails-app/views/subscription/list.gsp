
<%@ page import="ics.Subscription" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="subscription.list" default="Subscription List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="subscription.new" default="New Subscription" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="subscription.list" default="Subscription List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="subscription.id" />
                        
                   	    <g:sortableColumn property="amount" title="Amount" titleKey="subscription.amount" />
                        
                   	    <g:sortableColumn property="creator" title="Creator" titleKey="subscription.creator" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="subscription.dateCreated" />
                        
                   	    <g:sortableColumn property="deliveryChannel" title="Delivery Channel" titleKey="subscription.deliveryChannel" />
                        
                   	    <g:sortableColumn property="frequency" title="Frequency" titleKey="subscription.frequency" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${subscriptionInstanceList}" status="i" var="subscriptionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${subscriptionInstance.id}">${fieldValue(bean: subscriptionInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatNumber number="${subscriptionInstance.amount}" /></td>
                        
                            <td>${fieldValue(bean: subscriptionInstance, field: "creator")}</td>
                        
                            <td><g:formatDate date="${subscriptionInstance.dateCreated}" /></td>
                        
                            <td>${fieldValue(bean: subscriptionInstance, field: "deliveryChannel")}</td>
                        
                            <td>${fieldValue(bean: subscriptionInstance, field: "frequency")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${subscriptionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
