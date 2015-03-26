
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenter.show" default="Show CostCenter" /></title>
	<r:require module="qtip" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCenter.list" default="CostCenter List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCenter.new" default="New CostCenter" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenter.show" default="Show CostCenter" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${costCenterInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.alias" default="Alias" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterInstance, field: "alias")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.isProfitCenter" default="Is Profit Center" />:</td>
                                
                                <td valign="top" class="value">${costCenterInstance.isProfitCenter?'Yes':'No'}</td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.isServiceCenter" default="Is Service Center" />:</td>
                                
                                <td valign="top" class="value">${costCenterInstance.isServiceCenter?'Yes':'No'}</td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.budget" default="Budget" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterInstance, field: "budget")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.capitalBudget" default="Capital Budget" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterInstance, field: "capitalBudget")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.owner" default="Owner" />:</td>
                                
                                <td valign="top" class="value">
                                <g:link class="lex" title="test" controller="individual" action="show" id="${costCenterInstance?.owner?.id}">${fieldValue(bean: costCenterInstance, field: "owner")}</g:link>                                
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.owner1" default="Owner1" />:</td>
                                
                                <td valign="top" class="value">
                                <g:link class="lex" title="test" controller="individual" action="show" id="${costCenterInstance?.owner1?.id}">${fieldValue(bean: costCenterInstance, field: "owner1")}</g:link>                                
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.owner2" default="Owner2" />:</td>
                                
                                <td valign="top" class="value">
                                <g:link class="lex" title="test" controller="individual" action="show" id="${costCenterInstance?.owner2?.id}">${fieldValue(bean: costCenterInstance, field: "owner2")}</g:link>                                
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${costCenterInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${costCenterInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.costCategory" default="Cost Category" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="costCategory" action="show" id="${costCenterInstance?.costCategory?.id}">${costCenterInstance?.costCategory?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenter.costCenterGroup" default="Cost Center Group" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="costCenterGroup" action="show" id="${costCenterInstance?.costCenterGroup?.id}">${costCenterInstance?.costCenterGroup?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>

	<style>
		.lex {
		    color: green;
		    text-decoration: underline;
		}	
	</style>

	<script>
	function qTip(node) {
	    var url = node.attr("href");
	    node.qtip({
		content: {
		    text: "loading...",
		    ajax: {
			url: url,
			type: 'post',
			data: { html: 'test' }
		    }
		},
		show: {
		            ready: true // Show it immediately
        }
	    });
	}
	$(document).ready(function() {
	    $('.lex').on('mouseover', function() {
		var _self = $(this);
		qTip(_self);
	    });
	    $('a.lex').click(function(e) {
	        e.preventDefault();
	        //do other stuff when a click happens
		});
	})
	</script>

    </body>
</html>
