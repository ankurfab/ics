<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Period Report</title>
    </head>
    <body>
    
        <div class="body">
            <h1>Period Report</h1>
            <g:form controller='helper' action="downloadPeriodReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Period
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:select name="period.id"
				              from="${ics.Period.list(sort: "id", order: "desc")}"
				              value=""
          				optionKey="id" />
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