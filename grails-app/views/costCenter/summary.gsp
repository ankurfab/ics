
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Summary</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div>
            	<h1>Financial Summary for FY${year}</h1>
            	<table>
            		<thead>
            			<th>Department</th>
            			<th>Vertical</th>
            			<th>Q1 Income</th>
            			<th>Q1 Expense</th>
            			<th>Q2 Income</th>
            			<th>Q2 Expense</th>
            			<th>Q3 Income</th>
            			<th>Q3 Expense</th>
            			<th>Q4 Income</th>
            			<th>Q4 Expense</th>
            		</thead>
            		<tbody>
            		<g:each var="cc" in="${ics.CostCenter.list([sort:'name'])}">
            			<tr>
            				<td>
            					${cc.name}
            				</td>
            				<td>
            					${cc.costCategory.name}
            				</td>
		            		<g:each var="attr" in="${ics.Attribute.findAllWhere(domainClassName:'CostCenter',domainClassAttributeName:cc.id.toString(),category:year,[sort:'id'])}">
						<td>
							${ics.AttributeValue.findByAttribute(attr)?.value?:0}
						</td>
		            		</g:each>            				
            			</tr>
            		</g:each>
            		</tbody>
            	</table>
	    </div>
        </div>

    </body>
</html>
