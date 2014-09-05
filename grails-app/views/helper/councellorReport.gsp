<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Councellor Councelle Report</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Councellor Councelle Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="councellorViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Councellor
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
				       <div style="width: 300px">
					<gui:autoComplete
					    id="acCouncellor"
					    width="200px"
					    controller="individual"
					    action="allCouncellorsAsJSON"
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