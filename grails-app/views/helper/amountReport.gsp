<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Search By Amount Report</title>
	<gui:resources components="['autoComplete']"/>
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
          $("#fromDate").datepicker({yearRange: "-6:+0",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#toDate").datepicker({yearRange: "-6:+0",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
        })
    </script>
        <div class="body">
            <h1>Search By Amount Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="amountViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td width="20%">
                                    From Amount Criteria
                                </td>
                                <td width="20%">
                                    <g:select name="fromcriteria" from="${['Equal to','Less than','Less than or Equal to','Greater than','Greater than or Equal to']}" value="${fromcriteria}"  />
                                </td>
                                <td width="15%">
                                    From Amount
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="fromamount" value="${fromamount}"  />
                                </td>
                                
                            </tr>
                        
                            <tr class="prop">
                                <td width="20%">
                                    To Amount Criteria
                                </td>
                                <td width="20%">
                                    <g:select name="tocriteria" from="${['Equal to','Less than','Less than or Equal to','Greater than','Greater than or Equal to']}" value="${tocriteria}"   noSelection="['':'-Choose Criteria-']"/>
                                </td>
                                <td width="15%">
                                    To Amount
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="toamount" value="${toamount}"  />
                                </td>
                                
                            </tr>
                            <tr class="prop">
                                <td width="20%">
                                    From Date
                                </td>
                                <td width="20%">
                                    <g:textField name="fromDate" value=""/>
                                </td>
                                <td width="15%">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        
                            <tr class="prop">
                                <td width="20%">
                                    To Date
                                </td>
                                <td width="20%">
                                    <g:textField name="toDate" value=""/>
                                </td>
                                <td width="15%">&nbsp;</td>
                                <td>&nbsp;</td>
                         
                            </tr>
                        </tbody>
                    </table>
                </div>
                

                <div class="buttons">
                    <span class="button"><g:submitButton name="generate" class="save" value="GenerateReport" /></span>
                </div>
            </g:form>
<br>
        </div>
    </body>
</html>