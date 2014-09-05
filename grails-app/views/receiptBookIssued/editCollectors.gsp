
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')}" />
        <!--<title><g:message code="default.edit.label" args="[entityName]" /></title>-->
        <title>Edit ReceiptBookIssued Collectors</title>
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
        	$("#retrunDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
            })
    	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="Issue ReceiptBook" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="Edit ReceiptBookIssued Collectors" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${receiptBookIssuedInstance}">
            <div class="errors">
                <g:renderErrors bean="${receiptBookIssuedInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" controller="receiptBookIssued" action="updateCollectors" onsubmit="return validate();">
                <g:hiddenField name="id" value="${receiptBookIssuedInstance?.id}" />
                <g:hiddenField name="version" value="${receiptBookIssuedInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
			<g:set var="cntr" value="${0}" />
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="receiptBook"><g:message code="receiptBookIssued.batchId.label" default="Batch Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'batchId', 'errors')}">
                                	<!--<g:hiddenField name="receiptBook.id" value="${receiptBookIssuedInstance?.receiptBook?.id}" />-->
                                    <label>${batchId} </label>
                                    <g:hiddenField name="batchId" value="${batchId}" />
                                </td>
                            </tr>
                        
                            <tr>
                         	<td colspan="2" width="60%">
                         	<table width="40%">
                         	<tbody>
                         	<tr>
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.label" default="Id" /></b></td>
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.receiptBook" default="Receipt Book" /></b></td>
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.numPages" default="Number Of Pages" /></b></td>
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.startingReceiptNumber" default="Starting Receipt Number" /></b></td>
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.issuedTo" default="Issued To" /></b></td>
					<td valign="top" class="name">	</td>
					<td valign="top" class="name"><b>Councellor</b></td>
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.issueDate" default="Issue Date" /></b></td>
				</tr>
				<g:each in="${ids}" status="i" var="receiptBookIssuedInstance">
				<g:hiddenField name="id${i}" value="${receiptBookIssuedInstance?.id}" />
				 <tr>
					<td valign="top" class="value">${receiptBookIssuedInstance?.id}</td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook}</td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.numPages}</td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.startingReceiptNumber}</td>


				<td>
					<b>${receiptBookIssuedInstance?.issuedTo}</b>
				</td>				
				<td>
				       <g:hiddenField name="h_issuedTo.id" value="${receiptBookIssuedInstance?.issuedTo}" />
					<g:checkBox name="issuedToChkBox${i}" value="${true}"/>&nbsp;Use This Name?

				</td>
				<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
				<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(receiptBookIssuedInstance.issuedTo,crel)?.individual2}" />

                                <td valign="top" class="value">
					${counsellor}                              
                                </td>                                
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'issueDate', 'errors')}">
					${receiptBookIssuedInstance?.issueDate?.format("dd-MM-yyyy")}                              
                                </td>

				</tr>
				<tr>
					<td>
					</td>
				<td>
				</td>
				<td>
				</td>
				<td>
				</td>
				<td>New Collector
				</td>					
					<td>
					
					 <div style="width: 200px">
						<gui:autoComplete
							id="acCollector${i}"
							width="200px"
							controller="individual"
							action="findCollectorsAsJSON"
							useShadow="true"
							queryDelay="0.5" minQueryLength='3'
						/>
						</div>
					</td>
				</tr>
				<g:set var="cntr" value="${i}" />
				
				</g:each>
				
				<g:hiddenField name="cnt_i" id="cnt_i" value="${cntr}" />
				<tr>
				<td colspan="4">
				
				</td>
				</tr>
				</tbody> 							
				</table>
				</td>
                            
                            </tr>
			
			
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                	<span class="button"><g:submitButton name="updateColl" class="save" value="${message(code: 'default.button.update.label', default: 'Update')}" action="updateCollectors"/></span>
                </div>
            </g:form>
        </div>
        <script language="javascript"> 
        	function validate()
        	{
        		alert('cnt_i='+document.getElementById("cnt_i").value);
        		return confirm("Are you sure?");
        	}
        </script>
        
    </body>
</html>
