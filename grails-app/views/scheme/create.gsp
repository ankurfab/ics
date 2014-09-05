
<%@ page import="ics.Scheme" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'scheme.label', default: 'Scheme')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <gui:resources components="['autoComplete']" />
	    <style>
	    .yui-skin-sam .yui-ac-content {
	      width: 350px !important;
	    </style>

	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
        
    </head>
    <body>
	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />    
	<script type="text/javascript">
	    $(document).ready(function()
	    {
	      $("#effectiveFrom").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
		dateFormat: 'dd-mm-yy'});
	      $("#effectiveTill").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
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
            <g:hasErrors bean="${schemeInstance}">
            <div class="errors">
                <g:renderErrors bean="${schemeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="scheme.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list(sort:'name')}"  optionKey="id" value="${schemeInstance?.department?.id}" noSelection="['': '--Select Department--']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="scheme.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${schemeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="scheme.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${schemeInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="minAmount"><g:message code="scheme.minAmount.label" default="Min Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'minAmount', 'errors')}">
                                    <g:textField name="minAmount" value="${fieldValue(bean: schemeInstance, field: 'minAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="benefits"><g:message code="scheme.benefits.label" default="Benefits" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'benefits', 'errors')}">
                                    <g:textArea name="benefits" value="${schemeInstance?.benefits}"  rows="5" cols="50"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="effectiveFrom"><g:message code="scheme.effectiveFrom.label" default="Effective From" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'effectiveFrom', 'errors')}">
                                    <!--<g:datePicker name="effectiveFrom" precision="day" value="${schemeInstance?.effectiveFrom}"  />-->
                                    <g:textField name="effectiveFrom" precision="day" value="${(schemeInstance?.effectiveFrom)?.format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="effectiveTill"><g:message code="scheme.effectiveTill.label" default="Effective Till" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'effectiveTill', 'errors')}">
                                    <!--<g:datePicker name="effectiveTill" precision="day" value="${schemeInstance?.effectiveTill}"  />-->
                                    <g:textField name="effectiveTill" precision="day" value="${(schemeInstance?.effectiveTill)?.format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="scheme.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${schemeInstance?.description}" rows="5" cols="50"/>
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCenter"><g:message code="scheme.costCenter.label" default="Cost Center" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeInstance, field: 'costCenter', 'errors')}">
                                    <g:select name="cc.id" from="${ics.CostCenter.list([sort:name])}" value="${schemeInstance?.cc?.id}"
          					optionKey="id"  noSelection="['':'-Choose Cost Center-']"/>
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
