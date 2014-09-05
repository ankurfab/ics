<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Scheme Report</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Schemewise Individuals Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="schemewiseIndividualsViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Scheme
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
				<g:select name="schemeid" from="${ics.Scheme.list(sort:'name')}" optionKey="id" value="${ schemeid}"   noSelection="['':'-Select Scheme-']" />
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