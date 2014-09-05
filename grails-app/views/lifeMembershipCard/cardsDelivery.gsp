<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Cards Delivery</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Cards Delivery</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='lifeMembershipCard' action="cardsArrivedList" method="post" onsubmit="return validate();">
                <div class="dialog">
                    <table>
                        <tbody>
				<tr>
				<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'originatingDeptCollector', 'error')} required">
					<td>
					<label for="originatingDeptCollector">
						<!--<g:message code="lifeMembershipCard.originatingDeptCollector.label" default="Originating Dept Collector" />-->
						<b>Patron Care Collector
						<span class="required-indicator">*</span><b>
					</label>
					</td>
					<td>
					<g:hiddenField name="originatingDeptCollector" value="" />
					   <div style="width: 300px">
						<gui:autoComplete
							id="acOriginatingDeptCollector"
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
				<tr>
				<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'originatingDeptCollector', 'error')} required">
					<td>
					<label>
						<!--<g:message code="lifeMembershipCard.originatingDeptCollector.label" default="Originating Dept Collector" />-->
						<b>Card Collected By
						<span class="required-indicator">*</span><b>
					</label>
					</td>
					<td>
						<g:textField name="cardCollectedBy" value=""/>
					</td>
				</div>
				</tr>   
				
                        </tbody>
                    </table>
                </div>
                

                <div class="buttons">
                    <span class="button"><g:submitButton name="cardsArrivedList" class="save" value="Cards Arrived List" /></span>
                </div>
            </g:form>
        <script language="javascript"> 
        	function validate()
        	{
        
			if (document.getElementById("acOriginatingDeptCollector"))
			{
				if (document.getElementById("acOriginatingDeptCollector").value == '')
				{
					alert("Please enter Patron Care Collector!!");
					document.getElementById("acOriginatingDeptCollector").focus();
					return false;
				}
			}
			if (document.getElementById("cardCollectedBy"))
			{
				if (document.getElementById("cardCollectedBy").value == '')
				{
					alert("Please enter Card Collected By!!");
					document.getElementById("cardCollectedBy").focus();
					return false;
				}
			}
        		
        		
        		return true;
        	}
        </script>
            
    </body>
</html>