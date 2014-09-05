
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Search by cheuque no</title>
    </head>
    <body>

        <div class="body">
            <h1>Search by cheque no</h1>
             <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
           <g:form controller='donation' action="searchByChequeNo" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Cheque No:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="name" value="" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="save" value="Search" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
