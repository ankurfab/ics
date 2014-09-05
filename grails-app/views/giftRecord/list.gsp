
<%@ page import="ics.GiftRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="giftRecord.list" default="GiftRecord List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            
        </div>
        <div class="body">
            <h1><g:message code="giftRecord.list" default="GiftRecord List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="giftRecord.id" />
                        
                   	    <th><g:message code="giftRecord.giftedTo" default="Gifted To" /></th>
                   	    
                   	    <th><g:message code="giftRecord.gift" default="Gift" /></th>
                   	    
                   	    <g:sortableColumn property="giftDate" title="Gift Date" titleKey="giftRecord.giftDate" />
                        
                   	    <g:sortableColumn property="quantity" title="Quantity" titleKey="giftRecord.quantity" />
                        
                   	    <g:sortableColumn property="reference" title="Reference" titleKey="giftRecord.reference" />

                        <th><g:message code="giftRecord.gift" default="Way Gift Collected" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${giftRecordInstanceList}" status="i" var="giftRecordInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${giftRecordInstance.id}">${fieldValue(bean: giftRecordInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: giftRecordInstance, field: "giftedTo")}</td>
                        
                            <td>${fieldValue(bean: giftRecordInstance, field: "gift")}</td>
                        
                            <td><g:formatDate date="${giftRecordInstance.giftDate}" /></td>
                        
                            <td>${fieldValue(bean: giftRecordInstance, field: "quantity")}</td>
                        
                            <td>${fieldValue(bean: giftRecordInstance, field: "reference")}</td>

                            <td>${fieldValue(bean: giftRecordInstance, field: "giftChannel")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${giftRecordInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
