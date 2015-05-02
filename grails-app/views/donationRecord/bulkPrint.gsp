<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Donation Receipt Bulk Print</title>
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
            <h1>Donation Receipt Bulk Print</h1>
            <g:form controller='donationRecord' action="bulkPrintView" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    From Date
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="fromDate" value="${(new Date()-90).format('dd-MM-yyyy')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    To Date
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="toDate" value="${new Date().format('dd-MM-yyyy')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Authority
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
					<g:select name="authority" from="${ics.IndividualRole.findAllByRoleAndStatus(ics.Role.findByName('Receiver'),'VALID').collect{it.individual}}"
						  noSelection="['':'-Choose Authority-']"/>                                
				</td>
                            </tr>
                        
                        
                        
                        </tbody>
                    </table>
                </div>
                

                <div class="buttons">
                    <span class="button"><g:submitButton name="generate" class="save" value="Generate" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>