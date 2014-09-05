
<%@ page import="ics.CostCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCategory.create" default="Create CostCategory" /></title>
	<r:require module="jqui" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCategory.list" default="CostCategory List" /></g:link></span>
        </div>
        <div class="body">
	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $(document.getElementById('owner.id')).val(ui.item.id); // update the hidden field.
			  }
		});
	});
	</script>
            <h1><g:message code="costCategory.create" default="Create CostCategory" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${costCategoryInstance}">
            <div class="errors">
                <g:renderErrors bean="${costCategoryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="costCategory.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: costCategoryInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="alias"><g:message code="costCategory.alias" default="Alias" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'alias', 'errors')}">
                                    <g:textField name="alias" value="${fieldValue(bean: costCategoryInstance, field: 'alias')}" />

                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="owner">Owner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'owner', 'errors')}">
                                    <g:hiddenField name="owner.id" value=""/>
                                    <input id="ind" size="40" />
                                </td>
                            </tr>
                        

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
