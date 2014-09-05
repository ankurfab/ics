<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Book Read Report</title>
    </head>
    <body>
        <div class="body">
            <h1>Book Read Report</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller='bookRead' action="list" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Book
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
					<g:select name="book.id" from="${ics.Book.list(sort:'name')}" value="" optionKey="id" optionValue="name"
						  noSelection="['':'-Choose Book-']"/>
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