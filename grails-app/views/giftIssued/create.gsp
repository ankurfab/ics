
<%@ page import="ics.GiftIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'giftIssued.label', default: 'GiftIssued')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
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
                                    <label for="gift"><g:message code="giftIssued.gift.label" default="Gift" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'gift', 'errors')}">
                               <g:hiddenField name="gift.id" value="" />
			       <div style="width: 200px">
				<gui:autoComplete
				    id="acGift"
				    width="200px"
				    controller="gift"
				    action="findGiftsAsJSON"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
			    />
			    </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedQty"><g:message code="giftIssued.issuedQty.label" default="Issued Qty" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedQty', 'errors')}">
                                    <g:textField name="issuedQty" value="${fieldValue(bean: giftIssuedInstance, field: 'issuedQty')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedTo"><g:message code="giftIssued.issuedTo.label" default="Issued To" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedTo', 'errors')}">
                               <g:hiddenField name="issuedTo.id" value="" />
			       <div style="width: 200px">
				<gui:autoComplete
				    id="acIssuedTo"
				    width="200px"
				    controller="individual"
				    action="findWellwishersAsJSON"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
			    />
			    </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedBy"><g:message code="giftIssued.issuedBy.label" default="Issued By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issuedBy', 'errors')}">
                               <g:hiddenField name="issuedBy.id" value="" />
			       <div style="width: 200px">
				<gui:autoComplete
				    id="acIssuedBy"
				    width="200px"
				    controller="individual"
				    action="findIssuersAsJSON"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
			    />
			    </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issueDate"><g:message code="giftIssued.issueDate.label" default="Issue Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftIssuedInstance, field: 'issueDate', 'errors')}">
                                    <g:datePicker name="issueDate" precision="day" value="${giftIssuedInstance?.issueDate}"  />
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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
