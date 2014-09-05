

<%@ page import="ics.Denomination" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'denomination.label', default: 'Denomination')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
<SCRIPT language=Javascript>
      <!--
      function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

         return true;
      }
      //-->
   </SCRIPT>
    </head>
    <body>
    <br>
    <br>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${denominationInstance}">
            <div class="errors">
                <g:renderErrors bean="${denominationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <g:hiddenField name="collectedBy.id" value="${session.individualid}" />
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="collectedBy"><g:message code="denomination.collectedBy.label" default="Received By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'collectedBy', 'errors')}">
                                    ${session.individualname}
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="dialog">
                	Currency Notes
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="oneThousandRupeeNoteQty"><g:message code="denomination.oneThousandRupeeNoteQty.label" default="Rs. 1000 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'oneThousandRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="oneThousandRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'oneThousandRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fiveHundredRupeeNoteQty"><g:message code="denomination.fiveHundredRupeeNoteQty.label" default="Rs. 500 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'fiveHundredRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="fiveHundredRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'fiveHundredRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="hundredRupeeNoteQty"><g:message code="denomination.hundredRupeeNoteQty.label" default="Rs. 100 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'hundredRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="hundredRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'hundredRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fiftyRupeeNoteQty"><g:message code="denomination.fiftyRupeeNoteQty.label" default="Rs. 50 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'fiftyRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="fiftyRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'fiftyRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="twentyRupeeNoteQty"><g:message code="denomination.twentyRupeeNoteQty.label" default="Rs. 20 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'twentyRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="twentyRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'twentyRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tenRupeeNoteQty"><g:message code="denomination.tenRupeeNoteQty.label" default="Rs. 10 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'tenRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="tenRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'tenRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fiveRupeeNoteQty"><g:message code="denomination.fiveRupeeNoteQty.label" default="Rs. 5 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'fiveRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="fiveRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'fiveRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="twoRupeeNoteQty"><g:message code="denomination.twoRupeeNoteQty.label" default="Rs. 2 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'twoRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="twoRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'twoRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="oneRupeeNoteQty"><g:message code="denomination.oneRupeeNoteQty.label" default="Rs. 1 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'oneRupeeNoteQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="oneRupeeNoteQty" value="${fieldValue(bean: denominationInstance, field: 'oneRupeeNoteQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>

                <div class="dialog">
                	Coins
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fiftyPaiseCoinQty"><g:message code="denomination.fiftyPaiseCoinQty.label" default="50p qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'fiftyPaiseCoinQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="fiftyPaiseCoinQty" value="${fieldValue(bean: denominationInstance, field: 'fiftyPaiseCoinQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="oneRupeeCoinQty"><g:message code="denomination.oneRupeeCoinQty.label" default="Re. 1 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'oneRupeeCoinQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="oneRupeeCoinQty" value="${fieldValue(bean: denominationInstance, field: 'oneRupeeCoinQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="twoRupeeCoinQty"><g:message code="denomination.twoRupeeCoinQty.label" default="Rs. 2 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'twoRupeeCoinQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="twoRupeeCoinQty" value="${fieldValue(bean: denominationInstance, field: 'twoRupeeCoinQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fiveRupeeCoinQty"><g:message code="denomination.fiveRupeeCoinQty.label" default="Rs. 5 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'fiveRupeeCoinQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="fiveRupeeCoinQty" value="${fieldValue(bean: denominationInstance, field: 'fiveRupeeCoinQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tenRupeeCoinQty"><g:message code="denomination.tenRupeeCoinQty.label" default="Rs. 10 qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'tenRupeeCoinQty', 'errors')}">
                                    <g:textField onkeypress="return isNumberKey(event)"  name="tenRupeeCoinQty" value="${fieldValue(bean: denominationInstance, field: 'tenRupeeCoinQty')}" onchange="calcAmt();"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                        
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Total
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'comments', 'errors')}">
                                    <g:textField name="total" readonly="true"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="denomination.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: denominationInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${denominationInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
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
