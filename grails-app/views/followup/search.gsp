<%@ page import="ics.Followup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'followup.label', default: 'Followup')}" />
        <title>Followup Search</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Search for followups with Individual:</h1>
            <g:form action="listforindividual" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="followupWith"><g:message code="followup.followupWith.label" default="Followup With" /></label>
                                </td>

                                <td valign="top" class="value ${hasErrors(bean: followupInstance, field: 'followupWith', 'errors')}">
                                    <g:select name="followupWith.id" from="${rilist}" optionKey="id" value="${followupInstance?.followupWith?.id}"  />
                                </td>
				     
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
