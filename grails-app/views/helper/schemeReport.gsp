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
            <h1>Scheme Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="schemeViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Scheme
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                <!-- show schemes for the department of the logged in user -->
				<g:if test="${department!=null}">
					<g:select name="schemeid" from="${ics.Scheme.findAllByDepartment(department,[sort:'name'])}" optionKey="id" value="${ schemeid}"   noSelection="['':'-Select Scheme-']" />
				</g:if>
				<g:else>
					<g:select name="schemeid" from="${ics.Scheme.list(sort:'name')}" optionKey="id" value="${ schemeid}"   noSelection="['':'-Select Scheme-']" />
				</g:else>
				</td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Category
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
				<g:select name="category" optionKey="name" from="${ics.DonationCategory.list(sort:'name')}" value="${category}" noSelection="['':'-Select Donation Category-']" />
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