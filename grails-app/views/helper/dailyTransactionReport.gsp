<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Generate Reports</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="body">
            <h1>Generate Reports</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='helper' action="viewreport" method="post">
		<g:hiddenField name="reportName" value="daily_transaction" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    Database
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
					<g:radio name="reportName" value="daily_transaction"/> New
					<g:radio name="reportName" value="old_daily_transaction" checked="true"/> Old
                                </td>
                            </tr>-->

                            <tr class="prop">
                                <td valign="top" class="name">
                                    Receiver(s)
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:select multiple="multiple" name="param3" from="${recepients}" optionKey="id" value="${session.individualid}"  />
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    From Date
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:datePicker name="param1" value="${new Date()}"  precision="day" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    To Date
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:datePicker name="param2" value="${new Date()}"  precision="day" />
                                </td>
                            </tr>
                        
                        
                        
                        </tbody>
                    </table>
                </div>
                

                <div class="buttons">
                    <span class="button"><g:submitButton name="generate" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>



        </div>
    </body>
</html>