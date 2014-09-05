<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Course Report</title>
    </head>
    <body>
        <div class="body">
            <h1>Course Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='individualCourse' action="list" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Course
                                </td>
                                <td valign="top">
					<g:select name="course.id" from="${ics.Course.list(sort:'name')}" value="" optionKey="id" optionValue="name"
						  noSelection="['':'-Choose Course-']"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                

                <div class="buttons">
                    <span class="button"><g:submitButton name="generate" class="save" value="GenerateReport" /></span>
                </div>
            </g:form>
    </body>
</html>