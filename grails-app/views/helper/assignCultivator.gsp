<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Assign Cultivator</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Assign Cultivator</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='Helper' method="post">
                <div class="dialog">
                    <table>
                        <tbody>
				<tr>
				<div>
					<td>
					<label>
						
						<b>Patron Care Collector
						<span class="required-indicator">*</span><b>
					</label>
					</td>
					<td>
					<g:hiddenField name="h_patronCareCollector" value="" />
					   <div style="width: 300px">
						<gui:autoComplete
							id="acpatronCareCollector"
							width="200px"
							controller="individual"
							action="findPatronCareAsJSON"
							useShadow="true"
							queryDelay="0.2"

						/>
						</div>
					</td>
				</div>
				</tr>   
 
				
                        </tbody>
                    </table>
                </div>
                

                <div class="buttons">
                	<span class="button"><g:actionSubmit name="assignCultivatorToDonors" class="save" action="assignCultivatorToDonorsList" value="Donors List" /></span>
                	<span class="button"><g:actionSubmit name="assignCultivatorToNonDonors" class="save" action="assignCultivatorToNonDonorsList" value="Non Donors List" /></span>
                    <!--<span class="button"><g:submitButton name="assignCultivatorToDonorsList" class="save" value="Donors List" /></span>
                    <span class="button"><g:submitButton name="assignCultivatorToNonDonorsList" class="save" value="Non Donors List" /></span>-->
                </div>
            </g:form>
    </body>
</html>