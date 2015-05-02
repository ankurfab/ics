<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Donation Receipt Bulk Print</title>
    </head>
    <body>
        <div class="body">
            <h1>Donation Receipt Bulk Print</h1>
            <g:form controller='donation' action="bulkPrintView" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Receipt Book Nos
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="rbnos" value="" placeholder="comma seperated receipt booknos" size="50"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Receipt Nos
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textField name="rnos" value="" placeholder="comma seperated receipt nos" size="50"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Donation IDs
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textArea name="ids" value="" placeholder="comma seperated donation ids"/>
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