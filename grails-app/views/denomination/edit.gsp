

<%@ page import="ics.Denomination" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'denomination.label', default: 'Denomination')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
            <g:form method="post">
                <g:hiddenField name="id" value="${denominationInstance?.id}" />
                <g:hiddenField name="version" value="${denominationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="collectedBy"><g:message code="denomination.collectedBy.label" default="Received By" /></label>
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
                                    <g:set var="oldtotal" value="${denominationInstance.fiftyPaiseCoinQty * 0.5 + denominationInstance.oneRupeeCoinQty * 1 + denominationInstance.twoRupeeCoinQty * 2 + denominationInstance.fiveRupeeCoinQty * 5 + denominationInstance.tenRupeeCoinQty * 10 + denominationInstance.oneRupeeNoteQty * 1 + denominationInstance.twoRupeeNoteQty * 2 + denominationInstance.fiveRupeeNoteQty * 5 + denominationInstance.tenRupeeNoteQty * 10 + denominationInstance.twentyRupeeNoteQty * 20 + denominationInstance.fiftyRupeeNoteQty * 50 + denominationInstance.hundredRupeeNoteQty * 100 + denominationInstance.fiveHundredRupeeNoteQty * 500 + denominationInstance.oneThousandRupeeNoteQty * 1000}" />
                                    <g:hiddenField name="ot" value="${oldtotal}" />
                                    <g:textField name="total" value="${oldtotal}" readonly="true"/>
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
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"  onclick="return checkTotal();" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>

<script type="text/javascript">
function calcAmt()
{
	document.getElementById("total").value = (parseInt((document.getElementById("fiftyPaiseCoinQty").value).replace(",","")) * 0.5) + (parseInt((document.getElementById("oneRupeeCoinQty").value).replace(",","")) * 1) + (parseInt((document.getElementById("twoRupeeCoinQty").value).replace(",","")) * 2) + (parseInt((document.getElementById("fiveRupeeCoinQty").value).replace(",","")) * 5) + (parseInt((document.getElementById("tenRupeeCoinQty").value).replace(",","")) * 10) + (parseInt((document.getElementById("oneRupeeNoteQty").value).replace(",","")) * 1) + (parseInt((document.getElementById("twoRupeeNoteQty").value).replace(",","")) * 2) + (parseInt((document.getElementById("fiveRupeeNoteQty").value).replace(",","")) * 5) + (parseInt((document.getElementById("tenRupeeNoteQty").value).replace(",","")) * 10) + (parseInt((document.getElementById("twentyRupeeNoteQty").value).replace(",","")) * 20) + (parseInt((document.getElementById("fiftyRupeeNoteQty").value).replace(",","")) * 50) + (parseInt((document.getElementById("hundredRupeeNoteQty").value).replace(",","")) * 100) + (parseInt((document.getElementById("fiveHundredRupeeNoteQty").value).replace(",","")) * 500) + (parseInt((document.getElementById("oneThousandRupeeNoteQty").value).replace(",","")) * 1000);
}

function checkTotal()
{
if(parseFloat(document.getElementById("total").value) != parseFloat(document.getElementById("ot").value))
	return confirm("Total Difference!!Old Total: "+document.getElementById("ot").value+" New Total: "+document.getElementById("total").value);
return true;
}
</script>

        
    </body>
</html>
