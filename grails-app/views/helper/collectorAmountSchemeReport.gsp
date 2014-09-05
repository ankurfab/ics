<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Collector_Amount_Scheme Report</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Collector_Amount_Scheme Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="collectorAmountSchemeViewReport" method="post" onSubmit="return setSelectedCollectorsCount();">
                <div class="dialog">
                    <table border="0">
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual"><b>Collector(s)</b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'member', 'errors')}" colspan="3">
                                    <g:select name="collector.id" from="${collectors.sort{it.legalName}}" optionKey="id" value="${collectors?.id}" multiple="true" />
                                    <g:hiddenField name="h_collectorid" value="" />
                                    <g:hiddenField name="oneSelection" value="" />
                                </td>
                            
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <b>From Amount Criteria</b>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="fromcriteria" from="${['Equal to','Less than','Less than or Equal to','Greater than','Greater than or Equal to']}" value="${fromcriteria}"  />
                                </td>
                                <td valign="top" class="name">
                                    <b>From Amount</b>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="fromamount" value="${fromamount}"  />
                                </td>
     
                                
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <b>To Amount Criteria</b>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="tocriteria" from="${['Equal to','Less than','Less than or Equal to','Greater than','Greater than or Equal to']}" value="${tocriteria}"   noSelection="['':'-Choose Criteria-']"/>
                                </td>
                                <td valign="top" class="name">
                                    <b>To Amount</b>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="toamount" value="${toamount}"  />
                                </td>

                                
                            </tr>
							
							<tr>
                                <td valign="top" class="name">
                                    <b>Scheme</b>
                                </td>
							
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}" colspan="3">
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
        <script language="javascript">
        	function setSelectedCollectorsCount()
        	{
        		
        		var i, cnt = 0;
        		for(i=0; i<document.getElementById("collector.id").length; i++)
        		{
        			
        			if(document.getElementById("collector.id")[i].selected)
        			{
        				document.getElementById("oneSelection").value = document.getElementById("collector.id")[i].value;
        				cnt++;
        			}
        		}
        		
        		document.getElementById("h_collectorid").value = cnt;
        		return true;
        	}
        </script>
    </body>
</html>