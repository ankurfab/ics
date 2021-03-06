<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Datewise Advance Donation Detailed Report</title>
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
          $("#fromDate").datepicker({yearRange: "-6:+6",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#toDate").datepicker({yearRange: "-6:+6",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          newFilterPaymentMode();
        })
    </script>

        <div class="body">
            <h1>Datewise Advance Donation Detailed Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="datewiseLoanViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    From Date
                                </td>
                                <td valign="top" class="value">
                                    <!--<g:datePicker name="fromDate" value="${new Date()}"  precision="day" />-->
                                    <g:textField name="fromDate" value=""/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    To Date
                                </td>
                                <td valign="top" class="value">
                                    <!--<g:datePicker name="toDate" value="${new Date()}"  precision="day" />-->
                                    <g:textField name="toDate" value=""/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="generate" class="save" value="GenerateReport" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>