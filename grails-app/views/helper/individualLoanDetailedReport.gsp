<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Individualwise Advance Donation Detailed Report</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Individualwise Advance Donation Detailed Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="individualLoanDetailedViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Individual
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
				       <div style="width: 200px">
					<gui:autoComplete
					    id="acIndividual"
					    width="200px"
					    controller="individual"
					    action="allIndividualsExceptDummyDonorAsJSON"
					    useShadow="true"
					    queryDelay="0.5" minQueryLength='3'
				    />
				    </div>
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