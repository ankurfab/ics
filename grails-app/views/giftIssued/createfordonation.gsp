
<%@ page import="ics.GiftIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'giftIssued.label', default: 'GiftIssued')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
       
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
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${giftIssuedInstance}">
            <div class="errors">
                <g:renderErrors bean="${giftIssuedInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gift"><g:message code="giftIssued.gift.label" default="Gift" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'gift', 'errors')}">
                                    <g:select name="gift.id" from="${ics.Gift.list(sort:'name')}" optionKey="id" value="${giftIssuedInstance?.gift?.id}"  noSelection="['':'-Select Gift-']" onchange="${remoteFunction(controller:'gift',action:'getAmount',onSuccess:'processResponse(data)', params:'\'id=\' + document.getElementById(\'gift.id\').value+\'&quantity=\'+document.getElementById(\'issuedQty\').value'  )}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedQty"><g:message code="giftIssued.issuedQty.label" default="Issued Qty" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedQty', 'errors')}">
                                    <g:textField name="issuedQty" value="${giftIssuedInstance?.issuedQty?:1}" onchange="${remoteFunction(controller:'gift',action:'getAmount',onSuccess:'processResponse(data)', params:'\'id=\' + document.getElementById(\'gift.id\').value+\'&quantity=\'+document.getElementById(\'issuedQty\').value'  )}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccAmount">Gift Worth Amount:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'nvccAmount', 'errors')}">
                                    <g:textField name="nvccAmount" value="${giftIssuedInstance?.nvccAmount?:0}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedTo"><g:message code="giftIssued.issuedTo.label" default="Issued To" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedTo', 'errors')}">
                                    <g:hiddenField name="issuedTo.id" value="${giftIssuedInstance?.issuedTo?.id}" />
                                    ${giftIssuedInstance?.issuedTo?.toString()}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedBy"><g:message code="giftIssued.issuedBy.label" default="Issued By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedBy', 'errors')}">
                                    <g:hiddenField name="issuedBy.id" value="${giftIssuedInstance?.issuedBy?.id}" />
                                    ${giftIssuedInstance?.issuedBy?.toString()}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issueDate"><g:message code="giftIssued.issueDate.label" default="Issue Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issueDate', 'errors')}">
                                    <!--<g:datePicker name="issueDate" precision="day" value="${giftIssuedInstance?.issueDate}"  />-->
                                    <g:textField name="issueDate" value="${giftIssuedInstance?.issueDate?.format('dd-MM-yyyy')?:(new Date().format('dd-MM-yyyy'))}"/>
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
                                    <g:hiddenField name="donation.id" value="${giftIssuedInstance?.donation?.id}" />
                                    ${giftIssuedInstance?.donation?.toString()}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Total Donation Given Till Date:
                                </td>
                                <td valign="top" class="value">
                                    ${totalDonation}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Total Worth of Gifts Given Till Date:
                                </td>
                                <td valign="top" class="value">
                                    ${totalGiftsWorth}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Number of Gifts Given Till Date:
                                </td>
                                <td valign="top" class="value">
                                    ${totalGiftsNumber}
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
	function processResponse(response) { 
		var ele = document.getElementById("nvccAmount");
		ele.value = response;
	}
	</script>


    </body>
</html>
