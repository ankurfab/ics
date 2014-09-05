<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Commitment Report</title>
	<r:require module="jqui" />
    </head>
    <body>
    <script type="text/javascript">
        $(document).ready(function()
        {
	$( "#clor" ).autocomplete({
		source: "${createLink(controller:'individual',action:'allCounsellorsAsJSON_JQ')}",//todo take care of data from other departments
		minLength: 1,
		  select: function(event, ui) { // event handler when user selects a company from the list.
		   $("#clorid").val(ui.item.id); // update the hidden field.
		  }
	});

        })
    </script>
    
        <div class="body">
            <h1>Commitment Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="commitmentViewReport" method="post">
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="counsellor">Counsellor</label>
                                </td>
                                <td valign="top">
                                    <g:hiddenField name="clorid" value=""/>
                                    <input id="clor" size="40" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="scheme">Donation Type</label>
                                </td>
                                <td valign="top">
				<g:select name="scheme.id" from="${
					ics.Scheme.createCriteria().list{
						and {
							le("effectiveFrom", new Date())
							ge("effectiveTill", new Date())
						    }
						    order("name", "asc")
					}}" 
				optionKey="id" value="${donationInstance?.scheme?.id}" noSelection="['':'-Select-']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    From Date
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <!--<g:textField name="fromDate" value=""/>-->
					<g:datePicker name="fromDate" value="${new Date()}"
             				 precision="month"/>                                    
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