
<%@ page import="ics.GiftIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'giftIssued.label', default: 'GiftIssued')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
        
    </head>
    <body>

	    	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
	    	<script type="text/javascript">
	            $(document).ready(function()
	            {
	        	$("#issueDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
				dateFormat: 'dd-mm-yy'});
	          	
	            })
    	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${giftIssuedInstance}">
            <div class="errors">
                <g:renderErrors bean="${giftIssuedInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${giftIssuedInstance?.id}" />
                <g:hiddenField name="version" value="${giftIssuedInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gift"><g:message code="giftIssued.gift.label" default="Gift" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'gift', 'errors')}">
                                    <g:select name="gift.id" from="${ics.Gift.list(sort:'name')}" optionKey="id" value="${giftIssuedInstance?.gift?.id}"   onchange="${remoteFunction(controller:'gift',action:'getAmount',onSuccess:'processResponse(data)', params:'\'id=\' + document.getElementById(\'gift.id\').value+\'&quantity=\'+document.getElementById(\'issuedQty\').value'  )}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issuedQty"><g:message code="giftIssued.issuedQty.label" default="Issued Qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedQty', 'errors')}">
                                    <g:textField name="issuedQty" value="${fieldValue(bean: giftIssuedInstance, field: 'issuedQty')}"  onchange="${remoteFunction(controller:'gift',action:'getAmount',onSuccess:'processResponse(data)', params:'\'id=\' + document.getElementById(\'gift.id\').value+\'&quantity=\'+document.getElementById(\'issuedQty\').value'  )}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccAmount"><g:message code="giftIssued.nvccAmount.label" default="Nvcc Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'nvccAmount', 'errors')}">
                                    <g:textField name="nvccAmount" value="${giftIssuedInstance?.nvccAmount}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issuedTo"><g:message code="giftIssued.issuedTo.label" default="Issued To" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedTo', 'errors')}">
                                    ${giftIssuedInstance?.issuedTo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issuedBy"><g:message code="giftIssued.issuedBy.label" default="Issued By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedBy', 'errors')}">
                                    ${giftIssuedInstance?.issuedBy}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issueDate"><g:message code="giftIssued.issueDate.label" default="Issue Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issueDate', 'errors')}">
                                    
                                    <g:textField name="issueDate" precision="day" value="${(giftIssuedInstance?.issueDate)?.format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="giftIssued.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${giftIssuedInstance?.comments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="donation"><g:message code="giftIssued.donation.label" default="Donation" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'donation', 'errors')}">
                                    ${giftIssuedInstance?.donation}
                                </td>
                            </tr>
                        
                            <!--
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccDonarType"><g:message code="giftIssued.nvccDonarType.label" default="Nvcc Donar Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'nvccDonarType', 'errors')}">
                                    <g:textField name="nvccDonarType" value="${giftIssuedInstance?.nvccDonarType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccDonarId"><g:message code="giftIssued.nvccDonarId.label" default="Nvcc Donar Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'nvccDonarId', 'errors')}">
                                    <g:textField name="nvccDonarId" value="${giftIssuedInstance?.nvccDonarId}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccGiftId"><g:message code="giftIssued.nvccGiftId.label" default="Nvcc Gift Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'nvccGiftId', 'errors')}">
                                    <g:textField name="nvccGiftId" value="${giftIssuedInstance?.nvccGiftId}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccGift"><g:message code="giftIssued.nvccGift.label" default="Nvcc Gift" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'nvccGift', 'errors')}">
                                    <g:textField name="nvccGift" value="${giftIssuedInstance?.nvccGift}" />
                                </td>
                            </tr>
                        -->
                        
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
	function processResponse(response) { 
		var ele = document.getElementById("nvccAmount");
		ele.value = response;
	}
	</script>



    </body>
</html>
