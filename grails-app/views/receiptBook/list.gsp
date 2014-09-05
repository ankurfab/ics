
<%@ page import="ics.ReceiptBook" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBook.label', default: 'ReceiptBook')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" controller="helper" action="bulkcreate">New ReceiptBook Bulk</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
		<g:form name="searchForm" action="search" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bookSerialNumber">Book Serial Number:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="bookSerialNumber" value="" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category">Category:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="category" value="" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status">Status:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="status" value="" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments">Comments:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="comments" value="" />
                                </td>
                            </tr>


                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
		</g:form>
<br>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'receiptBook.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="category" title="${message(code: 'receiptBook.category.label', default: 'Category')}" />
                        
                            <g:sortableColumn property="bookSeries" title="${message(code: 'receiptBook.bookSeries.label', default: 'Book Series')}" />
                        
                            <g:sortableColumn property="bookSerialNumber" title="${message(code: 'receiptBook.bookSerialNumber.label', default: 'Book Serial Number')}" />
                        
                            <g:sortableColumn property="status" title="${message(code: 'receiptBook.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="comments" title="${message(code: 'receiptBook.comments.label', default: 'Comments')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${receiptBookInstanceList}" status="i" var="receiptBookInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${receiptBookInstance.id}">${fieldValue(bean: receiptBookInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: receiptBookInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: receiptBookInstance, field: "bookSeries")}</td>
                        
                            <td>${fieldValue(bean: receiptBookInstance, field: "bookSerialNumber")}</td>
                        
                            <td>${fieldValue(bean: receiptBookInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: receiptBookInstance, field: "comments")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${receiptBookInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
