

<%@ page import="ics.Denomination" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'denomination.label', default: 'Denomination')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${denominationInstance}">
            <div class="errors">
                <g:renderErrors bean="${denominationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${denominationInstance?.id}" />
                <g:hiddenField name="version" value="${denominationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="collectedBy"><g:message code="denomination.collectedBy.label" default="Collected By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'collectedBy', 'errors')}">
                                    ${denominationInstance?.collectedBy}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="collectionDate"><g:message code="denomination.collectionDate.label" default="Collection Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'collectionDate', 'errors')}">
                                    ${denominationInstance?.collectionDate?.format("dd-MM-yy")}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Denominations
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'fiftyPaiseCoinQty', 'errors')}">
                                    ${denominationInstance}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="denomination.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${denominationInstance?.comments}" rows="5" cols="40" readonly="true"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  New Comments
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="newcomments" value="" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                <!--<g:hiddenField name="status" value="HANDEDOVER" />-->
                <g:hiddenField name="status" value="TAKENOVER" />
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>

<script type="text/javascript">
function calcAmt()
{
	document.getElementById("total").value = document.getElementById("fiftyPaiseCoinQty").value  * 0.5 + document.getElementById("oneRupeeCoinQty").value  * 1 + document.getElementById("twoRupeeCoinQty").value  * 2 + document.getElementById("fiveRupeeCoinQty").value  * 5 + document.getElementById("tenRupeeCoinQty").value  * 10 + document.getElementById("oneRupeeNoteQty").value  * 1 + document.getElementById("twoRupeeNoteQty").value  * 2 + document.getElementById("fiveRupeeNoteQty").value  * 5 + document.getElementById("tenRupeeNoteQty").value  * 10 + document.getElementById("twentyRupeeNoteQty").value  * 20 + document.getElementById("fiftyRupeeNoteQty").value  * 50 + document.getElementById("hundredRupeeNoteQty").value  * 100 + document.getElementById("fiveHundredRupeeNoteQty").value  * 500 + document.getElementById("oneThousandRupeeNoteQty").value  * 1000
}
</script>

        
    </body>
</html>
