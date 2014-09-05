<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>CostCenter Statement</title>
	<r:require module="jqui" />
    </head>
    <body>
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
            <h1>Cost Center Statement</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='costCenter' action="statementReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Department
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
				   <div style="width: 200px">
					<sec:ifAnyGranted roles="ROLE_ACC_ADMIN">
						<g:select name="costCenter.id" from="${ics.CostCenter.list(sort: 'name')}" optionKey="id"  />
					</sec:ifAnyGranted >
					<sec:ifAnyGranted roles="ROLE_CC_OWNER">
						<g:select name="costCenter.id" from="${ics.CostCenter.findAllByOwner(ics.Individual.get(session.individualid),[sort: 'name']	)}" optionKey="id"  />
					</sec:ifAnyGranted >
				    </div>
                                </td>
                            </tr>

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