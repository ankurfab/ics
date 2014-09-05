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
            <h1>Individualwise Schemes Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="individualwiseSchemesViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="member"><g:message code="schemeMember.member.label" default="Member" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'member', 'errors')}">
                                   
				   <div style="width: 300px">
					<gui:autoComplete
						id="acIndividual"
						width="200px"
						controller="individual"
						action="allIndividualsAsJSON"
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