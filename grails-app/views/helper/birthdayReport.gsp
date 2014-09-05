<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Birthday Report</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Birthday Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="birthdayViewReport" method="post">
            <g:hiddenField name="selIndex" value="0" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Month
                                </td>
                                <td valign="top" class="value">
						<g:select name="month" from="${['Today','Tomorrow','January','February','March','April','May','June','July','August','September','October','November','December']}" value="Today"   onChange="setSelIndex();" />
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
        function setSelIndex()
        {
        	document.getElementById("selIndex").value = document.getElementById("month").selectedIndex;
        	return true;
        }
        </script>
    </body>
</html>