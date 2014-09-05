<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>PC Report</title>
	<r:require module="jqui" />
    </head>
    <body>
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#fromDate").datepicker({yearRange: "-1:+0",dateFormat: 'dd-mm-yy'});
          $("#toDate").datepicker({yearRange: "-1:+0",dateFormat: 'dd-mm-yy'});
        })
    </script>
    
        <div class="body">
            <h1>PC Report</h1>
            <g:form controller='helper' action="pcViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    From Date
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="fromDate" value=""/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    To Date
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="toDate" value=""/>
                                </td>
                            </tr>
                        
                        
                        
                        </tbody>
                    </table>
                </div>
                

                <div class="buttons">
                    <span class="button"><g:submitButton name="generate" class="save" value="Report" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>