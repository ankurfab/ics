

<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>Assign FD Number</title>
        
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
          		$("#loanStartDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          		$("#loanEndDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
			
        	})
    	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            
        </div>
  
        <div class="body">
        
            <h1>Assign FD Number</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="assignfdnumbertolot" onsubmit="return validate();">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lotId"><g:message code="loan.lotId.label" default="Lot Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'lotId', 'errors')}">
									<g:select name="lotId" from="${lotForFD}" value="${loanInstance?.lotId}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fdNumber"><g:message code="loan.fdNumber.label" default="FD Number" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanedBy', 'errors')}">
									<g:textField name="fdNumber" value="${loanInstance?.fdNumber}" />
                                </td>
                            </tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="loanStartDate"><g:message code="loan.loanStartDate.label" default="FD Date" /></label>*
								</td>
								<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanStartDate', 'errors')}">
									<g:textField name="loanStartDate" precision="day" value="${loanInstance?.loanStartDate?.format('dd-MM-yyyy')}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="loanEndDate"><g:message code="loan.loanEndDate.label" default="FD Maturity Date" /></label>*
								</td>
								<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanEndDate', 'errors')}">
									<g:textField name="loanEndDate" precision="day" value="${loanInstance?.loanEndDate?.format('dd-MM-yyyy')}"  />
								</td>
							</tr>

                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="assignFDNum" class="save" value="Save" /></span>
                </div>
            </g:form>
        </div>
        <script language="javascript">
        function validate()
        {
			if(document.getElementById('fdNumber').value == '')
			{
				alert("Please enter FD Number!");
				document.getElementById('fdNumber').focus();
				return false;
			}
			
			if(document.getElementById('loanStartDate').value == '')
			{
				alert("Please enter FD Date!");
				document.getElementById('loanStartDate').focus();
				return false;
			}

			if(document.getElementById('loanEndDate').value == '')
			{
				alert("Please enter FD Maturity Date!");
				document.getElementById('loanEndDate').focus();
				return false;
			}



			return true;
        	
        }
        
        </script>
    </body>
</html>
